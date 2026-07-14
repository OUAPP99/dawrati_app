package com.dawrati.app

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

/// Shows the current cycle day and phase on the home screen. Text is
/// pre-formatted and localized on the Dart side (see HomeWidgetService)
/// and simply displayed as-is here. Premium users additionally see the
/// days until their next period/ovulation and their logging streak.
class CycleWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.cycle_widget).apply {
                val day = widgetData.getString("cycleDay", null)
                val phase = widgetData.getString("cyclePhase", null)
                val isPremium = widgetData.getBoolean("isPremium", false)
                val periodCountdown = widgetData.getString("periodCountdown", null)
                val ovulationCountdown = widgetData.getString("ovulationCountdown", null)
                val streakText = widgetData.getString("streakText", null)

                setTextViewText(R.id.widget_day, day ?: "")
                setTextViewText(R.id.widget_phase, phase ?: "دورتي")

                if (isPremium) {
                    setViewVisibility(R.id.widget_premium_row, android.view.View.VISIBLE)
                    setTextViewText(R.id.widget_period_countdown, periodCountdown ?: "")
                    setTextViewText(R.id.widget_ovulation_countdown, ovulationCountdown ?: "")

                    if (!streakText.isNullOrEmpty()) {
                        setViewVisibility(R.id.widget_streak, android.view.View.VISIBLE)
                        setTextViewText(R.id.widget_streak, streakText)
                    } else {
                        setViewVisibility(R.id.widget_streak, android.view.View.GONE)
                    }
                } else {
                    setViewVisibility(R.id.widget_premium_row, android.view.View.GONE)
                    setViewVisibility(R.id.widget_streak, android.view.View.GONE)
                }

                setOnClickPendingIntent(
                    R.id.widget_root,
                    HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)
                )
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
