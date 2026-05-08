package com.holatimer.holatimer

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
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

        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.holatimer_widget).apply {
                setTextViewText(
                    R.id.widget_name,
                    widgetData.getString("widget_name", "HolaTimer") ?: "HolaTimer",
                )
                setTextViewText(
                    R.id.widget_count,
                    widgetData.getString("widget_count", "—") ?: "—",
                )
                setTextViewText(
                    R.id.widget_unit,
                    widgetData.getString("widget_unit", "") ?: "",
                )
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
