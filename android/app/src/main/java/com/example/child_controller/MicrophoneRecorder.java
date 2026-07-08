package com.example.child_controller;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.media.AudioFormat;
import android.media.AudioRecord;
import android.media.MediaRecorder;
import android.util.Log;

import androidx.core.app.ActivityCompat;

public class MicrophoneRecorder {

    private AudioRecord audioRecord;
    private Thread recordingThread;
    private boolean isRecording = false;

    private final WebSocketManager webSocketManager;

    public MicrophoneRecorder(WebSocketManager webSocketManager) {
        this.webSocketManager = webSocketManager;
    }

    public void start(Context context) {
        int sampleRate = 16000;

        int bufferSize = AudioRecord.getMinBufferSize(
                sampleRate,
                AudioFormat.CHANNEL_IN_MONO,
                AudioFormat.ENCODING_PCM_16BIT
        );

        if (ActivityCompat.checkSelfPermission(
                context,
                Manifest.permission.RECORD_AUDIO
        ) != PackageManager.PERMISSION_GRANTED) {
            Log.e("MIC_RECORDER", "Microphone permission not granted");
            return;
        }

        audioRecord = new AudioRecord(
                MediaRecorder.AudioSource.MIC,
                sampleRate,
                AudioFormat.CHANNEL_IN_MONO,
                AudioFormat.ENCODING_PCM_16BIT,
                bufferSize
        );

        audioRecord.startRecording();
        isRecording = true;

        Log.d("MIC_RECORDER", "Recording started");

        recordingThread = new Thread(() -> {
            byte[] buffer = new byte[bufferSize];

            while (isRecording) {
                int read = audioRecord.read(
                        buffer,
                        0,
                        buffer.length
                );

                if (read > 0) {
                    Log.d("MIC_RECORDER", "Sending bytes = " + read);

                    byte[] audioData =
                            java.util.Arrays.copyOf(buffer, read);

                    webSocketManager.send(audioData);
                }
            }
        });

        recordingThread.start();
    }

    public void stop() {
        isRecording = false;

        if (audioRecord != null) {
            audioRecord.stop();
            audioRecord.release();
            audioRecord = null;
        }

        Log.d("MIC_RECORDER", "Recording stopped");
    }
}