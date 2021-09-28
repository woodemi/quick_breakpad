package com.example.quick_breakpad_example;

public class Utils {
    static {
        System.loadLibrary("quick-breakpad-example");
    }

    public static native void crash();
}
