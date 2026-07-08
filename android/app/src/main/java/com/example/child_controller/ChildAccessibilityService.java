package com.example.child_controller;

import android.accessibilityservice.AccessibilityService;
import android.view.accessibility.AccessibilityEvent;
import android.util.Log;

public class ChildAccessibilityService extends AccessibilityService {

    @Override
    public void onAccessibilityEvent(AccessibilityEvent event) {

        if (event == null) return;

        if (event.getPackageName() != null) {

            String packageName = event.getPackageName().toString();

            Log.d("ChildService", "Opened App : " + packageName);

        }

    }

    @Override
    public void onInterrupt() {

    }

    @Override
    protected void onServiceConnected() {
        super.onServiceConnected();

        Log.d("ChildService", "Accessibility Connected");
    }
}