#import "MySpeechToTextPlugin.h"
#if __has_include(<my_speech_to_text/my_speech_to_text-Swift.h>)
#import <my_speech_to_text/my_speech_to_text-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "my_speech_to_text-Swift.h"
#endif

@implementation MySpeechToTextPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMySpeechToTextPlugin registerWithRegistrar:registrar];
}
@end
