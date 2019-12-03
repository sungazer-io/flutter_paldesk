#import "FlutterPaldeskPlugin.h"
#import <flutter_paldesk/flutter_paldesk-Swift.h>

@implementation FlutterPaldeskPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPaldeskPlugin registerWithRegistrar:registrar];
}
@end
