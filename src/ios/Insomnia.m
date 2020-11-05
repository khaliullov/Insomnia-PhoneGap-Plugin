#import "Insomnia.h"
#import <Cordova/CDV.h>

@implementation Insomnia

- (void) keepAwake:(CDVInvokedUrlCommand*)command {
  NSString *callbackId = command.callbackId;

  // Acquire a reference to the local UIApplication singleton
  UIApplication* app = [UIApplication sharedApplication];

  if (![app isIdleTimerDisabled]) {
    [app setIdleTimerDisabled:true];
  }
  CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void) allowSleepAgain:(CDVInvokedUrlCommand*)command {
  NSString *callbackId = command.callbackId;

  // Acquire a reference to the local UIApplication singleton
  UIApplication* app = [UIApplication sharedApplication];

  if([app isIdleTimerDisabled]) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [app setIdleTimerDisabled:false];
    });
  }
  CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

@end