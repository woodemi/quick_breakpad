# quick_breakpad

A cross-platform flutter plugin for `C/C++/ObjC` crash report via [Google Breakpad](https://chromium.googlesource.com/breakpad/breakpad)

# Use breakpad for quick_breakpad_example

> $CLI_BREAKPAD is local clone of https://github.com/Sunbreak/cli-breakpad.trial

## Android

- run on macOS/Linux

```sh
# Device/emulator connected
$ android_abi=`adb shell getprop ro.product.cpu.abi`
$ pushd example
$ flutter run
✓ Built build/app/outputs/flutter-apk/app-debug.apk.
I/quick_breakpad(28255): JNI_OnLoad
I quick_breakpad_example(28255): JNI_OnLoad
D quick_breakpad(28255): Dump path: /data/data/com.example.quick_breakpad_example/cache/54ecbb9d-cef5-4fa9-5b6869b2-198bc87e.dmp
$ popd
$ adb shell "run-as com.example.quick_breakpad_example sh -c 'cat /data/data/com.example.quick_breakpad_example/cache/54ecbb9d-cef5-4fa9-5b6869b2-198bc87e.dmp'" >| 54ecbb9d-cef5-4fa9-5b6869b2-198bc87e.dmp
```

- run on Linux (e.g. https://multipass.run/)

> Only C/C++ crash for now

```sh
$ $CLI_BREAKPAD/breakpad/linux/$(arch)/dump_syms example/build/app/intermediates/cmake/debug/obj/${android_abi}/libquick-breakpad-example.so > libquick-breakpad-example.so.sym
$ uuid=`awk 'FNR==1{print \$4}' libquick-breakpad-example.so.sym`
$ mkdir -p symbols/libquick-breakpad-example.so/$uuid/
$ mv ./libquick-breakpad-example.so.sym symbols/libquick-breakpad-example.so/$uuid/
$ $CLI_BREAKPAD/breakpad/linux/$(arch)/minidump_stackwalk 54ecbb9d-cef5-4fa9-5b6869b2-198bc87e.dmp symbols/ > libquick-breakpad-example.so.log
```

## iOS

- run on macOS

1. Get simulator UUID and run on it

```sh
$ flutter devices
1 connected device:
iPhone SE (2nd generation) (mobile) • C7E50B0A-D9AE-4073-9C3C-14DAF9D93329 • ios        • com.apple.CoreSimulator.SimRuntime.iOS-14-5 (simulator)
$ device=C7E50B0A-D9AE-4073-9C3C-14DAF9D93329
$ pushd example
$ flutter run -d $device
Running Xcode build...                                                  
 └─Compiling, linking and signing...                      2,162ms
Xcode build done.                                            6.2s
Lost connection to device.
$ popd
```

2. Find application data and get dump file

```sh
$ data=`xcrun simctl get_app_container booted com.example.quickBreakpadExample data`
$ ls $data/Library/Caches/Breakpad
A1D2CF75-848E-42C4-8F5C-0406E8520647.dmp        Config-FsNxCZ
$ cp $data/Library/Caches/Breakpad/A1D2CF75-848E-42C4-8F5C-0406E8520647.dmp .
```

3. Parse the dump file via symbols of `Runner`

> Only C/C++/Objective-C crash for now

```sh
$ dsymutil example/build/ios/Debug-iphonesimulator/Runner.app/Runner -o Runner.dSYM
$ $CLI_BREAKPAD/breakpad/mac/dump_syms Runner.dSYM > Runner.sym
$ uuid=`awk 'FNR==1{print \$4}' Runner.sym`
$ mkdir -p symbols/Runner/$uuid/
$ mv ./Runner.sym symbols/Runner/$uuid/
$ $CLI_BREAKPAD/breakpad/mac/$(arch)/minidump_stackwalk A1D2CF75-848E-42C4-8F5C-0406E8520647.dmp symbols > Runner.log
```

## Windows

https://github.com/woodemi/quick_breakpad/issues/4

## macOS

https://github.com/woodemi/quick_breakpad/issues/5

## Linux

https://github.com/woodemi/quick_breakpad/issues/6