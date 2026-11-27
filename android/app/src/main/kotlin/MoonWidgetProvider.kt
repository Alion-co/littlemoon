// ویجت صفحه‌ی اصلی ماه کوچولو (۲×۲): کارت هیرو، عیناً و با رنگ تم برنامه.
//
// تم تیره (شب): حلقه‌ی هیرو شب با ماه کوچک و ذرات و متن‌های داخل حلقه.
// تم روشن (روز): ماه هیرو روز با مدار و ستاره‌ها، «روز ۱۴ | فاز»، نوار فازها
// و وضعیت، روی گرادیان heroStart → heroEnd همان تم. با «تم شب خودکار» و
// حالت تیره‌ی گوشی، ظاهر شبِ هم‌خانواده می‌آد.
//
// این فایل عمداً در ریشه‌ی پوشه‌ی kotlin است و پکیج ir.littlemoon دارد
// (همان applicationId)، تا افزونه‌ی home_widget کلاس را پیدا کند.
// همه‌ی متن‌ها و رنگ‌ها از برنامه (به زبان و تم کاربر) در HomeWidgetPreferences
// ذخیره می‌شوند و روز چرخه هر بار همین‌جا حساب می‌شود؛ پس ویجت حتی وقتی برنامه
// چند روز باز نشده هم درست می‌ماند.
package ir.littlemoon

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.SharedPreferences
import android.content.res.Configuration
import android.graphics.Bitmap
import android.graphics.BlurMaskFilter
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.LinearGradient
import android.graphics.Matrix
import android.graphics.Paint
import android.graphics.Path
import android.graphics.RadialGradient
import android.graphics.RectF
import android.graphics.Shader
import android.graphics.SweepGradient
import android.graphics.Typeface
import android.os.Bundle
import android.text.SpannableStringBuilder
import android.text.Spanned
import android.text.style.ForegroundColorSpan
import android.text.style.StyleSpan
import android.util.TypedValue
import android.view.View
import android.widget.RemoteViews
import com.littlemoon.app.little_moon.R
import java.util.Random
import java.util.TimeZone
import kotlin.math.PI
import kotlin.math.ceil
import kotlin.math.cos
import kotlin.math.max
import kotlin.math.min
import kotlin.math.roundToInt
import kotlin.math.sin

class MoonWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(context: Context, manager: AppWidgetManager, ids: IntArray) {
        MoonWidgetRenderer.update(context, manager, ids)
    }

    // وقتی کاربر اندازه‌ی ویجت رو عوض می‌کنه، حلقه و متن‌ها هم‌اندازه می‌شن
    override fun onAppWidgetOptionsChanged(
        context: Context,
        manager: AppWidgetManager,
        id: Int,
        options: Bundle,
    ) {
        MoonWidgetRenderer.update(context, manager, intArrayOf(id))
    }
}

object MoonWidgetRenderer {
    // همان رنگ‌ها و ظاهر هر فاز در کارت هیرو (CyclePhaseLayout)
    private enum class Phase(
        val key: String,
        val color: Int,
        val moonMix: Float,
        val glowAlpha: Float,
        val glowBlur: Float,
    ) {
        MENSTRUAL("menstrual", Color.parseColor("#E76F8F"), 0.18f, 0.18f, 8f),
        FOLLICULAR("follicular", Color.parseColor("#A58BEA"), 0.22f, 0.30f, 10f),
        OVULATION("ovulation", Color.parseColor("#F4B45B"), 0.42f, 0.55f, 13f),
        LUTEAL("luteal", Color.parseColor("#7F93E6"), 0.26f, 0.28f, 9f),
    }

    /**
     * تقسیم چرخه به چهار فاز؛ عیناً همان قانون CyclePhaseLayout در Dart تا
     * ویجت و هیرو همیشه یک فاز را نشان بدهند.
     */
    private class PhaseLayout(cycleLength: Long, periodLength: Long, luteal: Long) {
        val length: Int = cycleLength.coerceIn(10L, 120L).toInt()
        val ovulationDay: Int =
            (length - luteal.toInt() - 1).coerceIn(4, length - 2) + 1
        val period: Int = max(1, min(periodLength.toInt(), ovulationDay - 2))

        /** جای روز تخمک‌گذاری روی حلقه (۰ تا ۱، از بالا ساعت‌گرد). */
        val ovulationFraction: Float = (ovulationDay - 0.5f) / length

        /** مرز فازها روی حلقه: پایان قاعدگی، شروع تخمک‌گذاری، پایان تخمک‌گذاری. */
        val boundaries: List<Float> = listOf(
            period.toFloat() / length,
            (ovulationDay - 2).toFloat() / length,
            (ovulationDay + 1).toFloat() / length,
        )

        fun phaseOfDay(day: Int): Phase = when {
            day <= period -> Phase.MENSTRUAL
            day < ovulationDay - 1 -> Phase.FOLLICULAR
            day <= ovulationDay + 1 -> Phase.OVULATION
            else -> Phase.LUTEAL
        }

        fun phaseAt(fraction: Float): Phase =
            phaseOfDay(max(1, min(ceil(fraction * length).toInt(), length)))
    }

    /** وضعیت امروزِ چرخه (وقتی داده هست). */
    private class Cycle(
        val day: Long,
        val progress: Float,
        val layout: PhaseLayout,
        val phase: Phase,
        val status: String,
    )

    /** رنگ‌های تمِ فعلی برنامه (MoonColors + ColorScheme). */
    private class Look(
        val night: Boolean,
        val bg: Int,
        val heroStart: Int,
        val heroEnd: Int,
        val primary: Int,
        val secondary: Int,
        val subtitle: Int,
        val ink: Int,
        val line: Int,
    )

    /** متن‌های ذخیره‌شده‌ی برنامه؛ اعداد به فارسی اگه زبان فارسی باشه. */
    private class Texts(private val prefs: SharedPreferences) {
        operator fun get(key: String): String = prefs.getString(key, null) ?: ""

        private val persian = get("lm_persian_digits") == "1"

        fun localize(value: String) = if (persian) persianDigits(value) else value

        fun fill(template: String, n: Long) = localize(template.replace("{n}", n.toString()))
    }

    /** یک ذره‌ی شناور دور حلقه‌ی شب (NightKnobPainter._Mote در Dart). */
    private class Mote(rnd: Random) {
        val angle = rnd.nextFloat() * TWO_PI
        val radius = 0.80f + rnd.nextFloat() * 0.40f // نسبت به شعاع حلقه
        val size = 0.8f + rnd.nextFloat() * 1.2f
        val ax = 3f + rnd.nextFloat() * 6f
        val ay = 3f + rnd.nextFloat() * 6f
        val phaseX: Float
        val phaseY: Float
        val alpha: Float

        init {
            rnd.nextInt(3) // fx و fy و twinkle فقط برای حرکت‌اند؛ ویجت ثابته
            rnd.nextInt(3)
            rnd.nextInt(4)
            phaseX = rnd.nextFloat()
            phaseY = rnd.nextFloat()
            alpha = 0.25f + rnd.nextFloat() * 0.35f
        }
    }

    /** فایلی که افزونه‌ی home_widget داده‌ها را در آن ذخیره می‌کند. */
    private const val PREFS = "HomeWidgetPreferences"
    private const val DAY_MS = 24L * 60 * 60 * 1000
    private val SOFT_WHITE = Color.parseColor("#E9DDF2")

    // تم «نیمه‌شب»، اگه هنوز برنامه چیزی نفرستاده بود
    private val DEFAULT_LOOK = Look(
        night = true,
        bg = Color.parseColor("#14132B"),
        heroStart = Color.parseColor("#2C2A52"),
        heroEnd = Color.parseColor("#1D1C38"),
        primary = Color.parseColor("#E0669B"),
        secondary = Color.parseColor("#A594F0"),
        subtitle = Color.parseColor("#B8B4D0"),
        ink = Color.parseColor("#F1EEF8"),
        line = Color.parseColor("#37345A"),
    )

    // ---- اندازه‌های هیرو شب (واحد منطقی: بوم ۲۲۴ تایی حلقه در برنامه) ----
    private const val HERO_BOX = 224f
    private const val HERO_RING_RADIUS = 98f
    private const val HERO_TEXT_INSET = 34f

    /** کادر حلقه‌ی شب چه کسری از ضلع ویجت است (۲۲۴ + ۲×۱۶ حاشیه‌ی کارت هیرو). */
    private const val BOX_FRACTION = HERO_BOX / (HERO_BOX + 32f)

    /** عکس‌ها با دو تا سه برابر بوم منطقی تا روی صفحه‌ی تراکم بالا تیز بمانند. */
    private const val RING_BITMAP = 448
    private const val BG_BITMAP = 400

    // ---- ماه و نوار فازهای هیرو روز (بوم منطقی ۱۰۰×۱۰۰ و ۲۰۰×۱۶) ----
    private const val MOON_CANVAS = 100f
    private const val MOON_BITMAP = 300
    private const val MOON_ORBIT = 36f // نصفِ اندازه‌ی ماهِ هیرو (۷۶) منهای ۲
    private const val BAR_W = 200f
    private const val BAR_H = 16f
    private const val BAR_SCALE = 3

    /** اگه لانچر اندازه نداد (قبل از اندروید ۴٫۱) ضلع ویجت. */
    private const val FALLBACK_SIDE_DP = 150f

    private const val TWO_PI = (2 * PI).toFloat()
    private const val HALF_PI = (PI / 2).toFloat()

    private val motes: List<Mote> by lazy {
        val rnd = Random(11)
        List(16) { Mote(rnd) }
    }

    fun update(context: Context, manager: AppWidgetManager, ids: IntArray) {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        for (id in ids) {
            val views = build(context, prefs)
            fitToSize(context, views, manager.getAppWidgetOptions(id))
            manager.updateAppWidget(id, views)
        }
    }

    /**
     * حلقه و متن‌ها را با اندازه‌ی واقعی ویجت هم‌مقیاس می‌کند.
     * در حالت عمودی گوشی، عرض = MIN_WIDTH و ارتفاع = MAX_HEIGHT.
     * متن‌ها از یک کف به پایین‌تر نمی‌آیند تا روی ویجت‌های کوچک خوانا بمانند.
     */
    private fun fitToSize(context: Context, views: RemoteViews, options: Bundle?) {
        val width = options?.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_WIDTH, 0) ?: 0
        val height = options?.getInt(AppWidgetManager.OPTION_APPWIDGET_MAX_HEIGHT, 0) ?: 0
        val side = if (width > 0 && height > 0) min(width, height).toFloat() else FALLBACK_SIDE_DP
        val box = side * BOX_FRACTION
        val k = box / HERO_BOX
        val density = context.resources.displayMetrics.density
        fun px(dp: Float) = (dp * density).roundToInt()
        fun pad(id: Int, dp: Float) = views.setViewPadding(id, px(dp), px(dp), px(dp), px(dp))
        fun size(id: Int, heroSp: Float, floor: Float) =
            views.setTextViewTextSize(id, TypedValue.COMPLEX_UNIT_DIP, max(floor, heroSp * k))

        // شب
        pad(R.id.widget_night_body, (side - box) / 2)
        val inset = px(HERO_TEXT_INSET * k)
        views.setViewPadding(R.id.widget_night_text, inset, 0, inset, 0)
        size(R.id.widget_day, 28f, 15f) // headlineMedium
        size(R.id.widget_phase, 14f, 10.5f) // titleSmall
        size(R.id.widget_status, 11f, 9f) // labelSmall

        // روز
        pad(R.id.widget_day_body, side * 0.075f)
        views.setTextViewTextSize(
            R.id.widget_day_status,
            TypedValue.COMPLEX_UNIT_DIP,
            max(8.5f, side * 0.062f),
        )
    }

    /** شماره‌ی روز امروز (به وقت محلی گوشی) از مبدأ یونیکس — هم‌ارز epochDay در Dart. */
    private fun todayEpochDay(): Long {
        val now = System.currentTimeMillis()
        val offset = TimeZone.getDefault().getOffset(now)
        return (now + offset) / DAY_MS
    }

    private fun persianDigits(text: String): String {
        val builder = StringBuilder(text.length)
        for (ch in text) builder.append(if (ch in '0'..'9') ('۰' + (ch - '0')) else ch)
        return builder.toString()
    }

    /**
     * تمِ فعلی: «تم شب خودکار» + حالت تیره‌ی گوشی ظاهر شبِ هم‌خانواده رو
     * انتخاب می‌کنه؛ وگرنه تم انتخابی کاربر.
     */
    private fun lookOf(context: Context, t: Texts): Look {
        val systemNight = (context.resources.configuration.uiMode and
            Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_YES
        val p = if (t["lm_auto_night"] == "1" && systemNight) "lm_n_" else "lm_a_"
        fun color(key: String, fallback: Int) = t[p + key].toLongOrNull()?.toInt() ?: fallback
        val d = DEFAULT_LOOK
        return Look(
            night = t[p + "night"] != "0",
            bg = color("bg", d.bg),
            heroStart = color("hs", d.heroStart),
            heroEnd = color("he", d.heroEnd),
            primary = color("pri", d.primary),
            secondary = color("sec", d.secondary),
            subtitle = color("sub", d.subtitle),
            ink = color("ink", d.ink),
            line = color("line", d.line),
        )
    }

    private fun cycleOf(t: Texts): Cycle? {
        val lastStart = t["lm_last_start"].toLongOrNull()
        if (t["lm_has_data"] != "1" || lastStart == null) return null

        val avgCycle = (t["lm_avg_cycle"].toLongOrNull() ?: 28L).coerceIn(10L, 120L)
        val periodLength = t["lm_period_length"].toLongOrNull() ?: 5L
        val luteal = t["lm_luteal"].toLongOrNull() ?: 14L
        val today = todayEpochDay()
        val day = today - lastStart + 1
        val daysUntil = lastStart + avgCycle - today
        val layout = PhaseLayout(avgCycle, periodLength, luteal)
        val status = when {
            day in 1..periodLength -> t.fill(t["lm_t_period_day"], day)
            daysUntil > 1 -> t.fill(t["lm_t_until"], daysUntil)
            daysUntil == 1L -> t["lm_t_tomorrow"]
            daysUntil == 0L -> t["lm_t_today"]
            daysUntil == -1L -> t["lm_t_late_one"]
            else -> t.fill(t["lm_t_late"], -daysUntil)
        }
        return Cycle(
            day = day,
            progress = (day.toFloat() / avgCycle).coerceIn(0f, 1f),
            layout = layout,
            phase = layout.phaseOfDay(day.coerceIn(1L, 100000L).toInt()),
            status = t.localize(status),
        )
    }

    private fun build(context: Context, prefs: SharedPreferences): RemoteViews {
        val t = Texts(prefs)

        // چیدمان راست‌به‌چپ یا چپ‌به‌راست بر اساس زبان «برنامه» (نه زبان گوشی):
        // فارسی و عربی راست‌چین، بقیه چپ‌چین.
        val rtl = t["lm_rtl"] != "0"
        val views = RemoteViews(
            context.packageName,
            if (rtl) R.layout.moon_widget_rtl else R.layout.moon_widget_ltr,
        )

        // لمس ویجت برنامه را باز می‌کند (اگر قفل فعال باشد، اول صفحه‌ی قفل)
        context.packageManager.getLaunchIntentForPackage(context.packageName)?.let { intent ->
            val pending = PendingIntent.getActivity(
                context,
                0,
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
            )
            views.setOnClickPendingIntent(R.id.widget_root, pending)
        }

        val look = lookOf(context, t)
        val discreet = t["lm_discreet"] == "1"
        val cycle = cycleOf(t)

        views.setImageViewBitmap(R.id.widget_bg, backgroundBitmap(look))
        views.setViewVisibility(R.id.widget_stars, if (look.night) View.VISIBLE else View.GONE)
        views.setViewVisibility(R.id.widget_night_body, if (look.night) View.VISIBLE else View.GONE)
        views.setViewVisibility(R.id.widget_day_body, if (look.night) View.GONE else View.VISIBLE)

        if (look.night) bindNight(views, t, look, cycle, discreet)
        else bindDay(views, t, look, cycle, discreet, rtl)
        return views
    }

    // ---------------------------------------------------------------- شب

    private fun bindNight(views: RemoteViews, t: Texts, look: Look, cycle: Cycle?, discreet: Boolean) {
        // بدون داده
        if (cycle == null) {
            views.setImageViewBitmap(R.id.widget_ring, ringBitmap(0f, null, null, look))
            views.setTextViewText(R.id.widget_day, "🌙")
            views.setViewVisibility(R.id.widget_phase_row, if (discreet) View.GONE else View.VISIBLE)
            views.setTextViewText(R.id.widget_phase, t["lm_t_empty"])
            views.setViewVisibility(R.id.widget_phase_dot, View.GONE)
            views.setViewVisibility(R.id.widget_status, View.GONE)
            return
        }

        // سرتیتر وسط حلقه، مثل هیرو: «روز ۱۴»
        views.setTextViewText(R.id.widget_day, t.fill(t["lm_t_day_discreet"], cycle.day))

        // حالت مخفی: حلقه سفید و بی‌رنگ، بدون ستاره‌ی تخمک‌گذاری و بدون فاز و
        // وضعیت (چیزی لو نمی‌ده)
        if (discreet) {
            views.setImageViewBitmap(R.id.widget_ring, ringBitmap(cycle.progress, null, null, look))
            views.setViewVisibility(R.id.widget_phase_row, View.GONE)
            views.setViewVisibility(R.id.widget_status, View.GONE)
            return
        }

        views.setImageViewBitmap(
            R.id.widget_ring,
            ringBitmap(cycle.progress, cycle.layout, cycle.phase, look),
        )

        // مثل هیرو: نام فاز سفید است و یک نقطه‌ی رنگی کنارش رنگ فاز را نشان می‌دهد
        views.setViewVisibility(R.id.widget_phase_row, View.VISIBLE)
        views.setTextViewText(R.id.widget_phase, t["lm_t_phase_${cycle.phase.key}"])
        views.setViewVisibility(R.id.widget_phase_dot, View.VISIBLE)
        views.setInt(R.id.widget_phase_dot, "setColorFilter", cycle.phase.color)
        views.setTextViewText(R.id.widget_status, cycle.status)
        views.setViewVisibility(R.id.widget_status, View.VISIBLE)
    }

    // ---------------------------------------------------------------- روز

    private fun bindDay(
        views: RemoteViews,
        t: Texts,
        look: Look,
        cycle: Cycle?,
        discreet: Boolean,
        rtl: Boolean,
    ) {
        views.setTextColor(R.id.widget_day_title, look.ink)
        views.setTextColor(R.id.widget_day_status, look.subtitle)
        views.setViewVisibility(R.id.widget_bar, View.GONE)
        views.setViewVisibility(R.id.widget_day_status, View.GONE)

        // بدون داده
        if (cycle == null) {
            views.setImageViewBitmap(R.id.widget_moon, moonBitmap(0f, null, null, look))
            views.setTextViewText(R.id.widget_day_title, if (discreet) "🌙" else t["lm_t_empty"])
            return
        }

        val dayText = t.fill(t["lm_t_day_discreet"], cycle.day)

        // حالت مخفی: ماه و مدار بی‌رنگ، فقط «روز ۱۴»
        if (discreet) {
            views.setImageViewBitmap(R.id.widget_moon, moonBitmap(cycle.progress, null, null, look))
            views.setTextViewText(R.id.widget_day_title, dayText)
            return
        }

        views.setImageViewBitmap(
            R.id.widget_moon,
            moonBitmap(cycle.progress, cycle.layout, cycle.phase, look),
        )

        // «روز ۱۴ | تخمک‌گذاری»؛ رنگ فاز روی زمینه‌ی روشن کمی تیره‌تر
        val title = SpannableStringBuilder()
        fun add(text: String, color: Int) {
            val from = title.length
            title.append(text)
            title.setSpan(ForegroundColorSpan(color), from, title.length, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
            title.setSpan(StyleSpan(Typeface.BOLD), from, title.length, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
        }
        add(dayText, look.ink)
        add("  |  ", withAlpha(look.subtitle, 0.45f))
        add(t["lm_t_phase_${cycle.phase.key}"], mix(cycle.phase.color, Color.BLACK, 0.28f))
        views.setTextViewText(R.id.widget_day_title, title)

        views.setImageViewBitmap(R.id.widget_bar, barBitmap(cycle, rtl))
        views.setViewVisibility(R.id.widget_bar, View.VISIBLE)
        views.setTextViewText(R.id.widget_day_status, cycle.status)
        views.setViewVisibility(R.id.widget_day_status, View.VISIBLE)
    }

    // ---------------------------------------------------------------- نقاشی

    private fun withAlpha(color: Int, alpha: Float): Int =
        Color.argb((alpha.coerceIn(0f, 1f) * 255).toInt(), Color.red(color), Color.green(color), Color.blue(color))

    private fun mix(from: Int, to: Int, t: Float): Int = Color.rgb(
        (Color.red(from) + (Color.red(to) - Color.red(from)) * t).toInt(),
        (Color.green(from) + (Color.green(to) - Color.green(from)) * t).toInt(),
        (Color.blue(from) + (Color.blue(to) - Color.blue(from)) * t).toInt(),
    )

    private fun fill(color: Int) = Paint(Paint.ANTI_ALIAS_FLAG).apply { this.color = color }

    private fun deg(radians: Float) = Math.toDegrees(radians.toDouble()).toFloat()

    /** ستاره‌ی چهارپر (✦)؛ همان sparklePath در Dart. */
    private fun sparkle(cx: Float, cy: Float, r: Float): Path {
        val k = r * 0.22f
        return Path().apply {
            moveTo(cx, cy - r)
            quadTo(cx + k, cy - k, cx + r, cy)
            quadTo(cx + k, cy + k, cx, cy + r)
            quadTo(cx - k, cy + k, cx - r, cy)
            quadTo(cx - k, cy - k, cx, cy - r)
            close()
        }
    }

    /**
     * پس‌زمینه‌ی کارت. شب: شیشه‌ی نیمه‌شفاف (۷٪ سفید + لبه‌ی ۱۶٪) روی آسمان تم؛
     * روز: گرادیان heroStart → heroEnd → کمی عمیق‌تر (همان کارت هیرو روز) با
     * لبه‌ی dividerColor.
     */
    private fun backgroundBitmap(look: Look): Bitmap {
        val s = BG_BITMAP.toFloat()
        val bitmap = Bitmap.createBitmap(BG_BITMAP, BG_BITMAP, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        val radius = if (look.night) 75f else 64f
        val rect = RectF(0f, 0f, s, s)

        val colors: IntArray
        val stops: FloatArray?
        if (look.night) {
            colors = intArrayOf(look.heroStart, mix(look.heroStart, look.bg, 0.6f), look.bg)
            stops = null
        } else {
            colors = intArrayOf(look.heroStart, look.heroEnd, mix(look.heroEnd, look.primary, 0.14f))
            stops = floatArrayOf(0f, 0.55f, 1f)
        }
        canvas.drawRoundRect(
            rect, radius, radius,
            Paint(Paint.ANTI_ALIAS_FLAG).apply { shader = LinearGradient(0f, 0f, s, s, colors, stops, Shader.TileMode.CLAMP) },
        )
        if (look.night) canvas.drawRoundRect(rect, radius, radius, fill(withAlpha(Color.WHITE, 0.07f)))

        val border = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            style = Paint.Style.STROKE
            strokeWidth = 3f
            color = if (look.night) withAlpha(Color.WHITE, 0.16f) else withAlpha(look.line, 0.5f)
        }
        rect.inset(1.5f, 1.5f)
        canvas.drawRoundRect(rect, radius, radius, border)
        return bitmap
    }

    /**
     * حلقه‌ی هیرو شب (NightRingPainter + NightKnobPainter) به‌صورت عکس ثابت، با
     * همان اندازه‌های بوم ۲۲۴ تاییِ برنامه (همه‌چیز در [u] ضرب می‌شه):
     * مسیر کم‌رنگ، خط‌چین آینده به رنگ هر فاز، کمان گذشته با هاله و گرادیان،
     * ستاره‌ی روز تخمک‌گذاری، ذرات شناور و ماه کوچک روی امروز.
     *
     * [layout] و [phase] اگر `null` باشند (بدون داده یا حالت مخفی) حلقه بی‌رنگ
     * کشیده می‌شود: خط‌چین‌ها و کمان سفید، بدون ستاره‌ی تخمک‌گذاری.
     */
    private fun ringBitmap(progress: Float, layout: PhaseLayout?, phase: Phase?, look: Look): Bitmap {
        val startColor = if (layout == null) SOFT_WHITE else look.secondary
        val endColor = if (layout == null) SOFT_WHITE else look.primary
        val bitmap = Bitmap.createBitmap(RING_BITMAP, RING_BITMAP, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        val u = RING_BITMAP / HERO_BOX
        val cx = RING_BITMAP / 2f
        val cy = cx
        val radius = HERO_RING_RADIUS * u
        val rect = RectF(cx - radius, cy - radius, cx + radius, cy + radius)
        val p = progress.coerceIn(0f, 1f)
        val sweep = p * TWO_PI

        fun stroke(width: Float, color: Int) = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            style = Paint.Style.STROKE
            strokeWidth = width * u
            strokeCap = Paint.Cap.ROUND
            this.color = color
        }

        // مسیر خیلی کم‌رنگ زیر همه‌چیز
        canvas.drawCircle(cx, cy, radius, stroke(3f, withAlpha(Color.WHITE, 0.07f)))

        // آینده: خط‌چین، هر تکه به رنگ فازش
        val dashPaint = stroke(3f, Color.WHITE)
        val dash = 5f / HERO_RING_RADIUS
        val gap = 7f / HERO_RING_RADIUS
        var a = sweep
        while (a < TWO_PI - 0.01f) {
            val len = min(dash, TWO_PI - a)
            val color = layout?.phaseAt((a + len / 2) / TWO_PI)?.color ?: SOFT_WHITE
            dashPaint.color = withAlpha(color, if (layout == null) 0.35f else 0.62f)
            canvas.drawArc(rect, deg(a - HALF_PI), deg(len), false, dashPaint)
            a += dash + gap
        }

        // گذشته: هاله + کمان گرادیانی با سر گرد
        if (sweep > 0.01f) {
            canvas.drawArc(
                rect, -90f, deg(sweep), false,
                stroke(8f, withAlpha(Color.WHITE, 0.10f)).apply {
                    maskFilter = BlurMaskFilter(6f * u, BlurMaskFilter.Blur.NORMAL)
                },
            )
            val gradient = SweepGradient(cx, cy, intArrayOf(startColor, Color.WHITE, endColor), null)
            gradient.setLocalMatrix(Matrix().apply { setRotate(deg(-HALF_PI - 0.2f), cx, cy) })
            canvas.drawArc(rect, -90f, deg(sweep), false, stroke(4.5f, Color.WHITE).apply { shader = gradient })
        }

        // ستاره‌ی روز تخمک‌گذاری
        if (layout != null) {
            val gold = Phase.OVULATION.color
            val angle = layout.ovulationFraction * TWO_PI - HALF_PI
            val sx = cx + radius * cos(angle)
            val sy = cy + radius * sin(angle)
            val glowR = 9f * u
            canvas.drawCircle(
                sx, sy, glowR,
                Paint(Paint.ANTI_ALIAS_FLAG).apply {
                    shader = RadialGradient(
                        sx, sy, glowR,
                        withAlpha(gold, 0.45f), withAlpha(gold, 0f), Shader.TileMode.CLAMP,
                    )
                },
            )
            canvas.drawPath(sparkle(sx, sy, 6f * u), fill(gold))
        }

        // ذرات ریز شناور (جای ثابتِ لحظه‌ی صفر انیمیشن هیرو)
        val dust = Paint(Paint.ANTI_ALIAS_FLAG)
        for (m in motes) {
            val twinkle = 0.5f + 0.5f * sin(TWO_PI * m.phaseX)
            dust.color = withAlpha(Color.WHITE, m.alpha * (0.35f + 0.65f * twinkle))
            canvas.drawCircle(
                cx + radius * m.radius * cos(m.angle) + m.ax * u * sin(TWO_PI * m.phaseX),
                cy + radius * m.radius * sin(m.angle) + m.ay * u * cos(TWO_PI * m.phaseY),
                m.size * u,
                dust,
            )
        }

        // ماه کوچک روی نقطه‌ی امروز (بالای حلقه شروع می‌شه و ساعت‌گرد می‌ره)
        val kAngle = p * TWO_PI - HALF_PI
        val kx = cx + radius * cos(kAngle)
        val ky = cy + radius * sin(kAngle)
        val halo = mix(Color.WHITE, phase?.color ?: Color.WHITE, 0.45f)
        val haloR = 17f * u // وسطِ نفس‌کشیدنِ هاله (۱۴ تا ۲۰)
        canvas.drawCircle(
            kx, ky, haloR,
            Paint(Paint.ANTI_ALIAS_FLAG).apply {
                shader = RadialGradient(
                    kx, ky, haloR,
                    withAlpha(halo, 0.60f), withAlpha(halo, 0f), Shader.TileMode.CLAMP,
                )
            },
        )
        canvas.drawCircle(kx, ky, 8f * u, fill(Color.parseColor("#F4F2FF")))
        val crater = fill(withAlpha(Color.parseColor("#BDB8D8"), 0.6f))
        canvas.drawCircle(kx - 2.5f * u, ky - 1.5f * u, 1.8f * u, crater)
        canvas.drawCircle(kx + 2.2f * u, ky + 2.4f * u, 1.3f * u, crater)
        return bitmap
    }

    /**
     * ماه هیرو روز (هاله + MoonCrescentPainter + MoonSkyPainter) به‌صورت عکس
     * ثابت: مدار با خط‌چین فازها و کمان گذشته، ستاره‌ی تخمک‌گذاری، ماهِ هلالی
     * با رنگ فاز، سه ستاره‌ی ریز و نقطه‌ی امروز. رنگ‌ها: primary → secondary تم.
     *
     * [layout] و [phase] اگر `null` باشند (بدون داده یا حالت مخفی) مدار و ماه
     * بی‌رنگ (subtitle) کشیده می‌شن و ستاره‌ی تخمک‌گذاری نیست.
     */
    private fun moonBitmap(progress: Float, layout: PhaseLayout?, phase: Phase?, look: Look): Bitmap {
        val neutral = layout == null
        val start = if (neutral) look.subtitle else look.primary
        val end = if (neutral) look.subtitle else look.secondary
        val bitmap = Bitmap.createBitmap(MOON_BITMAP, MOON_BITMAP, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        val u = MOON_BITMAP / MOON_CANVAS
        val cx = MOON_BITMAP / 2f
        val cy = cx
        val orbit = MOON_ORBIT * u
        val p = progress.coerceIn(0f, 1f)
        val sweep = p * TWO_PI

        // هاله‌ی نرم پشت ماه
        canvas.drawCircle(
            cx, cy, cx,
            Paint(Paint.ANTI_ALIAS_FLAG).apply {
                shader = RadialGradient(
                    cx, cy, cx,
                    withAlpha(look.primary, 0.22f), withAlpha(look.primary, 0f), Shader.TileMode.CLAMP,
                )
            },
        )

        // ---- مدار ----
        val rect = RectF(cx - orbit, cy - orbit, cx + orbit, cy + orbit)
        val dashPaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            style = Paint.Style.STROKE
            strokeWidth = 1.5f * u
            strokeCap = Paint.Cap.ROUND
        }
        val dash = 3f * u / orbit
        val gap = 4.5f * u / orbit
        var a = sweep
        while (a < TWO_PI - 0.01f) {
            val len = min(dash, TWO_PI - a)
            dashPaint.color = if (layout == null) withAlpha(look.subtitle, 0.35f)
            else withAlpha(layout.phaseAt((a + len / 2) / TWO_PI).color, 0.60f)
            canvas.drawArc(rect, deg(a - HALF_PI), deg(len), false, dashPaint)
            a += dash + gap
        }
        if (sweep > 0.01f) {
            val gradient = SweepGradient(
                cx, cy,
                intArrayOf(start, end, end),
                floatArrayOf(0f, p.coerceIn(0.01f, 1f), 1f),
            )
            gradient.setLocalMatrix(Matrix().apply { setRotate(-90f, cx, cy) })
            canvas.drawArc(
                rect, -90f, deg(sweep), false,
                Paint(Paint.ANTI_ALIAS_FLAG).apply {
                    style = Paint.Style.STROKE
                    strokeWidth = 2.4f * u
                    strokeCap = Paint.Cap.ROUND
                    shader = gradient
                },
            )
        }
        if (layout != null) {
            val angle = layout.ovulationFraction * TWO_PI - HALF_PI
            canvas.drawPath(
                sparkle(cx + orbit * cos(angle), cy + orbit * sin(angle), 4.4f * u),
                fill(Phase.OVULATION.color),
            )
        }

        // ---- ماهِ هلالی ----
        val r = orbit * 0.62f
        val cut = r * (0.20f + 1.70f * p)
        val lit = Path().apply {
            addCircle(0f, 0f, r, Path.Direction.CW)
            op(Path().apply { addCircle(cut, cut * 0.35f, r * 0.85f, Path.Direction.CW) }, Path.Op.DIFFERENCE)
        }
        val litStart = if (phase == null) start else mix(start, phase.color, phase.moonMix)
        val litEnd = if (phase == null) end else mix(end, phase.color, phase.moonMix * 0.6f)
        val glow = if (phase == null) start else mix(start, phase.color, 0.7f)
        val glowAlpha = phase?.glowAlpha ?: 0.28f
        val glowBlur = phase?.glowBlur ?: 9f

        canvas.save()
        canvas.translate(cx, cy)
        canvas.rotate(-0.35f * 180f / PI.toFloat())

        // قرص کم‌رنگِ بخش تاریک و لبه‌اش
        canvas.drawCircle(
            0f, 0f, r,
            Paint(Paint.ANTI_ALIAS_FLAG).apply {
                shader = LinearGradient(
                    -r, -r, r, r,
                    withAlpha(start, 0.16f), withAlpha(end, 0.10f), Shader.TileMode.CLAMP,
                )
            },
        )
        canvas.drawCircle(
            0f, 0f, r,
            Paint(Paint.ANTI_ALIAS_FLAG).apply {
                style = Paint.Style.STROKE
                strokeWidth = 0.8f * u
                color = withAlpha(start, 0.22f)
            },
        )

        // هاله و بخش روشن
        canvas.drawPath(
            lit,
            fill(withAlpha(glow, glowAlpha)).apply { maskFilter = BlurMaskFilter(glowBlur * u, BlurMaskFilter.Blur.NORMAL) },
        )
        canvas.drawPath(
            lit,
            Paint(Paint.ANTI_ALIAS_FLAG).apply {
                shader = LinearGradient(-r, -r, r, r, litStart, litEnd, Shader.TileMode.CLAMP)
            },
        )

        // لبه‌ی سفید و دهانه‌ها فقط روی بخش روشن
        canvas.save()
        canvas.clipPath(lit)
        canvas.drawCircle(
            0f, 0f, r - 0.6f * u,
            Paint(Paint.ANTI_ALIAS_FLAG).apply {
                style = Paint.Style.STROKE
                strokeWidth = 1.4f * u
                color = withAlpha(Color.WHITE, 0.65f)
            },
        )
        val crater = fill(withAlpha(mix(end, Color.BLACK, 0.30f), 0.20f))
        for ((dx, dy, dz) in CRATERS) canvas.drawCircle(dx * r, dy * r, dz * r, crater)
        canvas.restore()
        canvas.restore()

        // ---- آسمان: سه ستاره‌ی ریز و نقطه‌ی امروز روی مدار ----
        val star = fill(withAlpha(start, 0.90f))
        for ((x, y, rr) in SKY_STARS) {
            canvas.drawPath(sparkle(cx + orbit * x, cy + orbit * y, orbit * rr), star)
        }
        val kAngle = p * TWO_PI - HALF_PI
        val kx = cx + orbit * cos(kAngle)
        val ky = cy + orbit * sin(kAngle)
        val haloR = 10f * u // وسطِ نفس‌کشیدنِ هاله (۸ تا ۱۲)
        canvas.drawCircle(
            kx, ky, haloR,
            Paint(Paint.ANTI_ALIAS_FLAG).apply {
                shader = RadialGradient(
                    kx, ky, haloR,
                    withAlpha(start, 0.50f), withAlpha(start, 0f), Shader.TileMode.CLAMP,
                )
            },
        )
        canvas.drawCircle(kx, ky, 3.4f * u, fill(start))
        canvas.drawCircle(kx, ky, 1.3f * u, fill(withAlpha(Color.WHITE, 0.85f)))
        return bitmap
    }

    /** دهانه‌های ماه (dx، dy، شعاع نسبت به شعاع ماه) — همان MoonCrescentPainter._craters. */
    private val CRATERS = listOf(
        Triple(-0.32f, -0.26f, 0.16f),
        Triple(0.08f, 0.32f, 0.11f),
        Triple(-0.50f, 0.18f, 0.08f),
        Triple(0.34f, -0.42f, 0.07f),
    )

    /** ستاره‌های ریز دور ماه (x، y، شعاع نسبت به شعاع مدار) — همان MoonSkyPainter. */
    private val SKY_STARS = listOf(
        Triple(0.62f, -0.34f, 0.10f),
        Triple(-0.78f, 0.62f, 0.06f),
        Triple(-0.50f, -0.86f, 0.05f),
    )

    /**
     * نوار باریک فازها (_PhaseBarPainter): چهار تکه به رنگ فازها، بخش گذشته
     * پررنگ، ستاره‌ی طلایی روی روز تخمک‌گذاری و نقطه‌ی امروز. در زبان‌های
     * راست‌به‌چپ از راست پر می‌شه.
     */
    private fun barBitmap(cycle: Cycle, rtl: Boolean): Bitmap {
        val u = BAR_SCALE.toFloat()
        val bitmap = Bitmap.createBitmap((BAR_W * u).toInt(), (BAR_H * u).toInt(), Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        val pad = 6f
        val track = 5f
        val w = BAR_W - pad * 2
        val cy = BAR_H / 2
        val p = cycle.progress.coerceIn(0f, 1f)

        fun x(f: Float) = (if (rtl) pad + w * (1 - f) else pad + w * f) * u
        fun segment(x1: Float, x2: Float): RectF {
            val left = min(x1, x2)
            val right = max(x1, x2)
            // فاصله‌ی ریز بین تکه‌ها
            val l = left + u
            val r = right - u
            return RectF(l, (cy - track / 2) * u, max(l, r), (cy + track / 2) * u)
        }
        fun draw(rect: RectF, color: Int) = canvas.drawRoundRect(rect, track / 2 * u, track / 2 * u, fill(color))

        val edges = listOf(0f) + cycle.layout.boundaries + listOf(1f)
        val phases = Phase.values()
        for (i in 0 until 4) {
            val from = edges[i]
            val to = edges[i + 1]
            val color = phases[i].color
            draw(segment(x(from), x(to)), withAlpha(color, 0.28f))
            if (p > from) draw(segment(x(from), x(min(p, to))), color)
        }

        canvas.drawPath(sparkle(x(cycle.layout.ovulationFraction), (cy - 7.5f) * u, 3.6f * u), fill(Phase.OVULATION.color))

        val dx = x(p)
        val dy = cy * u
        canvas.drawCircle(
            dx, dy, 7.5f * u,
            Paint(Paint.ANTI_ALIAS_FLAG).apply {
                shader = RadialGradient(
                    dx, dy, 7.5f * u,
                    withAlpha(cycle.phase.color, 0.40f), withAlpha(cycle.phase.color, 0f), Shader.TileMode.CLAMP,
                )
            },
        )
        canvas.drawCircle(dx, dy, 5f * u, fill(Color.WHITE))
        canvas.drawCircle(dx, dy, 3.2f * u, fill(cycle.phase.color))
        return bitmap
    }
}
