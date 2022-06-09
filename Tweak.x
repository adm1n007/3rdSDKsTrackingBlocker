#import <Foundation/Foundation.h>
#include <substrate.h>

%hook AppsFlyerLib
- (id)init {
    return nil;
}
%end
%hook AppsFlyerUtils
+ (bool)isJailbrokenWithSkipAdvancedJailbreakValidation:(bool)a1 {
    return false;
}
%end
%hook APMMeasurement
- (void)setEnabled:(bool)a1 {
    return;
}
%end
%hook Amplitude
+ (id)instance {
    return nil;
}
%end
%hook Appboy
+ (void)startWithApiKey:(id)a1 inApplication:(id)a2 withLaunchOptions:(id)a3 withAppboyOptions:(id)a4 {
    return;
}
%end
%hook Bugly
+ (void)startWithAppId:(id)a1 developmentDevice:(bool)a2 config:(id)a3 {
    return;
}
%end
%hook Bugsnag
+ (id)startWithConfiguration:(id)a1 {
    return nil;
}
%end
%hook BLYDevice
- (bool)isJailbroken {
    return false;
}
%end
%hook FIRApp
+ (void)configureWithName:(id)a1 options:(id)a2 {
    return;
}
%end
%hook GADSettings
- (id)init {
    return nil;
}
%end
%hook KSCrashInstallation
- (void)sendAllReportsWithCompletion:(id)block {
    return;
}
%end
%hook NTESCrashLogger
+ (void)log:(id)a1 {
    return;
}
%end
%hook NTESCrashReporter
+ (id)sharedInstance {
    return nil;
}
%end
%hook NTESJSCrashReporter
+ (id)sharedInstance {
    return nil;
}
%end
%hook PLCrashReporter
- (id)initWithApplicationIdentifier:(id)a1 appVersion:(id)a2 appMarketingVersion:(id)a3 configuration:(id)a4 {
    return nil;
}
%end
%hook TGGDTLogger
+ (bool)reportSDKGDTlog:(id)a1 {
    return false;
}
%end
%hook UMConfigure
+ (void)initWithAppkey:(id)a1 channel:(id)a2 {
    return;
}
%end // In some apps, If we only hook +[UMConfigure initWithAppkey:channel:], the app will crash
%hook UMSocialManager
+ (id)defaultManager {
    return nil;
}
%end
%hook UMessage
+ (void)registerForRemoteNotificationsWithLaunchOptions:(id)a1 Entity:(id)a2 completionHandler:(id)a3 {
    return;
}
%end
%hook Matrix
+ (id)sharedInstance {
    return nil;
}
%end
%hook MobClick
+ (bool)isJailbroken {
    return false;
}
%end
%hook OneSignal
+ (void)init {
    return;
}
%end
%hook OneSignalRequest
- (id)init {
    return nil;
}
%end
%hook OneSignalJailbreakDetection
+ (bool)isJailbroken {
    return false;
}
%end
%hook Mixpanel
- (id)initWithToken:(id)a1 launchOptions:(id)a2 flushInterval:(unsigned long long)a3 trackCrashes:(bool)a4 automaticPushTracking:(bool)a5 optOutTrackingByDefault:(bool)a6 {
    return nil;
}
%end

static int none(void) {
    return 0;
}
extern char*** _NSGetArgv();
%ctor {
    @autoreleasepool {
        if (strstr(**_NSGetArgv(), "Application") && ![NSBundle.mainBundle.bundleIdentifier hasPrefix:@"com.apple"]) {
            %init;

            // for Swift Version of Mixpanel SDK
            if (objc_getClass("_TtC8Mixpanel16MixpanelInstance")) {
                void *mixpanel_swift_func_addr = MSFindSymbol(NULL, "_$s8Mixpanel0A8InstanceC5flush10completionyyycSg_tF");
                void *mixpanel_swift_func_addr2 = MSFindSymbol(NULL, "_$s8Mixpanel0A8InstanceC11checkDecide10forceFetch10completionySb_yAA0D8ResponseVSgctF");
                if (mixpanel_swift_func_addr && mixpanel_swift_func_addr2) {
                    MSHookFunction(mixpanel_swift_func_addr, (void *)none, NULL);
                    MSHookFunction(mixpanel_swift_func_addr2, (void *)none, NULL);
                }
            }

            if (objc_getClass("ServiceEndpointsBuilder")) {
                void *func_addr = MSFindSymbol(NULL, "_$s5Split07DefaultA14FactoryBuilderC5buildAA0aC0_pSgyF");
                if (func_addr) {
                    MSHookFunction(func_addr, (void *)none, NULL);
                }
            }
        }
    }
}
