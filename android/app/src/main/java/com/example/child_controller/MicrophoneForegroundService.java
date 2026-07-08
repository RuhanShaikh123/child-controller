package com.example.child_controller;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.Service;
import android.content.Intent;
import android.os.Build;
import android.os.IBinder;

import androidx.core.app.NotificationCompat;

public class MicrophoneForegroundService extends Service {

    public static final String CHANNEL_ID = "LiveAudioChannel";

    private WebSocketManager webSocketManager;
    private MicrophoneRecorder microphoneRecorder;

    @Override
    public void onCreate() {
        super.onCreate();

        createNotificationChannel();

        Notification notification =
                new NotificationCompat.Builder(this, CHANNEL_ID)
                        .setContentTitle("Child Controller")
                        .setContentText("Live Audio Running")
                        .setSmallIcon(android.R.drawable.ic_btn_speak_now)
                        .setOngoing(true)
                        .build();

        startForeground(1001, notification);
    }



    @Override
    public void onDestroy() {

        if (microphoneRecorder != null) {
            microphoneRecorder.stop();
        }

        if (webSocketManager != null) {
            webSocketManager.disconnect();
        }

        super.onDestroy();
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    private void createNotificationChannel() {

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {

            NotificationChannel channel =
                    new NotificationChannel(
                            CHANNEL_ID,
                            "Live Audio",
                            NotificationManager.IMPORTANCE_LOW
                    );

            NotificationManager manager =
                    getSystemService(NotificationManager.class);

            if (manager != null) {
                manager.createNotificationChannel(channel);
            }
        }
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {

        android.util.Log.d("LIVE_AUDIO", "Service Started");

        String familyId = intent.getStringExtra("familyId");

        if (familyId != null) {

            android.util.Log.d("LIVE_AUDIO", "FamilyId = " + familyId);

            webSocketManager = new WebSocketManager();

            webSocketManager.connect(familyId);

            microphoneRecorder =
                    new MicrophoneRecorder(webSocketManager);

            microphoneRecorder.start(this);
        }

        return START_STICKY;
    }
}