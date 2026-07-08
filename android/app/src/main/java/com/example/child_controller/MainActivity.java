package com.example.child_controller;

import android.accessibilityservice.AccessibilityServiceInfo;
import android.content.ComponentName;
import android.os.Build;
import android.content.Intent;
import android.provider.Settings;
import android.view.accessibility.AccessibilityManager;

import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "child_controller/accessibility";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {

        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(
                flutterEngine.getDartExecutor().getBinaryMessenger(),
                CHANNEL
        ).setMethodCallHandler((call, result) -> {

            switch (call.method) {

                case "openAccessibility":

                    Intent intent =
                            new Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS);

                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

                    startActivity(intent);

                    result.success(true);

                    break;

                case "isAccessibilityEnabled":

                    result.success(isAccessibilityEnabled());

                    break;

                case "openUsageAccess":

                    Intent usageIntent =
                            new Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS);

                    usageIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

                    startActivity(usageIntent);

                    result.success(true);

                    break;

                case "isUsageAccessEnabled":

                    result.success(isUsageAccessEnabled());

                    break;


                case "startMicrophoneService":

                    String familyId = call.argument("familyId");

                    startMicrophoneService(familyId);

                    result.success(true);

                    break;

                case "stopMicrophoneService":

                    stopMicrophoneService();

                    result.success(true);

                    break;

                default:

                    result.notImplemented();

            }

        });

    }

    private boolean isAccessibilityEnabled() {

        AccessibilityManager manager =
                (AccessibilityManager) getSystemService(ACCESSIBILITY_SERVICE);

        List<AccessibilityServiceInfo> enabledServices =
                manager.getEnabledAccessibilityServiceList(
                        AccessibilityServiceInfo.FEEDBACK_ALL_MASK
                );

        ComponentName myService = new ComponentName(
                this,
                ChildAccessibilityService.class
        );

        String myServiceId = myService.flattenToString();

        for (AccessibilityServiceInfo service : enabledServices) {

            ComponentName enabled = new ComponentName(
                    service.getResolveInfo().serviceInfo.packageName,
                    service.getResolveInfo().serviceInfo.name
            );

            if (enabled.flattenToString().equals(myServiceId)) {
                return true;
            }
        }

        return false;
    }

    private boolean isUsageAccessEnabled() {

        android.app.AppOpsManager appOps =
                (android.app.AppOpsManager)
                        getSystemService(APP_OPS_SERVICE);

        int mode = appOps.checkOpNoThrow(
                android.app.AppOpsManager.OPSTR_GET_USAGE_STATS,
                android.os.Process.myUid(),
                getPackageName()
        );

        return mode == android.app.AppOpsManager.MODE_ALLOWED;




    }

    private void startMicrophoneService(String familyId) {

        Intent intent = new Intent(this, MicrophoneForegroundService.class);

        intent.putExtra("familyId", familyId);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(intent);
        } else {
            startService(intent);
        }

    }
    private void stopMicrophoneService() {

        Intent intent =
                new Intent(this, MicrophoneForegroundService.class);

        stopService(intent);

    }

}