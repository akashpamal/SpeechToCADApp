#import "MySamplePackagePlugin.h"
#if __has_include(<my_sample_package/my_sample_package-Swift.h>)
#import <my_sample_package/my_sample_package-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "my_sample_package-Swift.h"
#endif

@implementation MySamplePackagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMySamplePackagePlugin registerWithRegistrar:registrar];
}
@end
