-keep class com.razorpay.** { *; }
-keep class androidx.lifecycle.DefaultLifecycleObserver
-keepclassmembers class * {
    @androidx.lifecycle.OnLifecycleEvent *;
}
