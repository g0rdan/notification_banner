#import "NotificationBannerPlugin.h"
#if __has_include(<notification_banner/notification_banner-Swift.h>)
#import <notification_banner/notification_banner-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "notification_banner-Swift.h"
#endif

@implementation NotificationBannerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNotificationBannerPlugin registerWithRegistrar:registrar];
}
@end
