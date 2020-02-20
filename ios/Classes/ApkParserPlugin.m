#import "ApkParserPlugin.h"
#if __has_include(<apk_parser/apk_parser-Swift.h>)
#import <apk_parser/apk_parser-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "apk_parser-Swift.h"
#endif

@implementation ApkParserPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftApkParserPlugin registerWithRegistrar:registrar];
}
@end
