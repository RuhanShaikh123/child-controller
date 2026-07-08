package com.example.child_controller;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.WebSocket;
import okhttp3.WebSocketListener;

public class WebSocketManager {

    private static final String TAG = "WebSocket";

    private static final String SERVER =
            "wss://parental-control-server-bckk.onrender.com";

    private WebSocket webSocket;

    private String lastFamilyId;

    private boolean manuallyClosed = false;

    public void connect(String familyId) {

        lastFamilyId = familyId;

        manuallyClosed = false;

        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url(SERVER + "?role=child&familyId=" + familyId)
                .build();

        webSocket = client.newWebSocket(
                request,
                new WebSocketListener() {

                    @Override
                    public void onOpen(
                            WebSocket webSocket,
                            Response response
                    ) {
                        Log.d(TAG, "Child WebSocket Connected");
                    }

                    @Override
                    public void onClosed(
                            WebSocket webSocket,
                            int code,
                            String reason
                    ) {
                        Log.d(TAG, "Closed : " + reason);

                        reconnect();
                    }

                    @Override
                    public void onFailure(
                            WebSocket webSocket,
                            Throwable t,
                            Response response
                    ) {
                        Log.e(TAG, "Error", t);

                        reconnect();
                    }
                });
    }

    private void reconnect() {

        if (manuallyClosed) return;

        if (lastFamilyId == null) return;

        Log.d(TAG, "Reconnecting in 3 seconds...");

        new Handler(Looper.getMainLooper())
                .postDelayed(() -> {
                    connect(lastFamilyId);
                }, 3000);
    }

    public void send(byte[] audio) {

        if (webSocket != null) {

            webSocket.send(okio.ByteString.of(audio));

        }

    }

    public void disconnect() {

        manuallyClosed = true;

        if (webSocket != null) {

            webSocket.close(1000, "bye");

            webSocket = null;

        }

    }
}