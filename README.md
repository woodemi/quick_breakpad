# quick_breakpad

A new flutter plugin project.

# Use breakpad for quick_breakpad_example

> $CLI_BREAKPAD is local clone of https://github.com/Sunbreak/cli-breakpad.trial

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