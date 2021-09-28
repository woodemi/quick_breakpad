package com.example.quick_breakpad_example;

import android.os.Handler;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onResume() {
        super.onResume();
        new Handler().postDelayed(() -> {
            Utils.crash();
        }, 1000);
    }
}
