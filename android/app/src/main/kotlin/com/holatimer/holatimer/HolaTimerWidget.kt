package com.holatimer.holatimer

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Color
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class HolaTimerWidget : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        val launchIntent = context.packageManager.getLaunchIntentForPackage(context.packageName)
        val pendingIntent = PendingIntent.getActivity(
            context, 0, launchIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )

        val type = widgetData.getString("widget_type", "custom") ?: "custom"

        val bgRes = when (type) {
            "pregnancy"   -> R.drawable.widget_bg_pregnancy
            "birthday"    -> R.drawable.widget_bg_birthday
            "anniversary" -> R.drawable.widget_bg_anniversary
            "travel"      -> R.drawable.widget_bg_travel
            else          -> R.drawable.widget_bg_custom
        }

        val accentColor = when (type) {
            "pregnancy"   -> Color.parseColor("#FFB3D9")
            "birthday"    -> Color.parseColor("#FFCC80")
            "anniversary" -> Color.parseColor("#EF9A9A")
            "travel"      -> Color.parseColor("#81D4FA")
            else          -> Color.parseColor("#CE93D8")
        }

        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.holatimer_widget).apply {
                setInt(R.id.widget_root, "setBackgroundResource", bgRes)
                setTextViewText(
                    R.id.widget_name,
                    widgetData.getString("widget_name", "HolaTimer") ?: "HolaTimer",
                )
                setTextViewText(
                    R.id.widget_emoji,
                    widgetData.getString("widget_emoji", "⏳") ?: "⏳",
                )
                setTextViewText(
                    R.id.widget_count,
                    widgetData.getString("widget_count", "—") ?: "—",
                )
                setTextViewText(
                    R.id.widget_unit,
                    widgetData.getString("widget_unit", "") ?: "",
                )
                setTextColor(R.id.widget_unit, accentColor)
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
