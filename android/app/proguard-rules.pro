# WorkManager (pulled in transitively by home_widget's Glance dependency)
# needs its Room-generated database classes kept intact, or its
# reflection-based startup init crashes in release builds.
-keep class androidx.work.** { *; }
-keep class * extends androidx.room.RoomDatabase
-dontwarn androidx.work.**

-keep class es.antonborri.home_widget.** { *; }
