#import "QuickBreakpadPlugin.h"
#import "BreakpadController.h"

@implementation QuickBreakpadPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"quick_breakpad"
                                     binaryMessenger:[registrar messenger]];
    QuickBreakpadPlugin* instance = [[QuickBreakpadPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    [registrar addApplicationDelegate:instance];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [BreakpadController.sharedInstance start:YES];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [BreakpadController.sharedInstance stop];
}

@end
