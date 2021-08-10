#import "React/RCTViewManager.h"
//#import <JWPlayer_iOS_SDK/JWPlayerController.h>


@interface RCT_EXTERN_MODULE(ImpresaJwplayerViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(file, NSString)
RCT_EXPORT_VIEW_PROPERTY(imageFile, NSString)
RCT_EXPORT_VIEW_PROPERTY(adSchedule, NSArray)


// simple properties
RCT_EXPORT_VIEW_PROPERTY(volume, double)
RCT_EXPORT_VIEW_PROPERTY(autostart, BOOL)
RCT_EXPORT_VIEW_PROPERTY(repeatVideo, BOOL)
RCT_EXPORT_VIEW_PROPERTY(controls, BOOL)
RCT_EXPORT_VIEW_PROPERTY(mediaId, NSString)

RCT_EXPORT_VIEW_PROPERTY(description, NSString)
RCT_EXPORT_VIEW_PROPERTY(title, NSString)
RCT_EXPORT_VIEW_PROPERTY(licenseKey, NSString)

// events properties
RCT_EXPORT_VIEW_PROPERTY(onFullScreen, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onFullScreenExit, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onPlay, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onPause, RCTBubblingEventBlock)

// methods properties
RCT_EXTERN_METHOD(play:(nonnull NSNumber *)node)
RCT_EXTERN_METHOD(toggleFullScreen:(nonnull NSNumber *)node)
RCT_EXTERN_METHOD(pause:(nonnull NSNumber *)node)
RCT_EXTERN_METHOD(destroy:(nonnull NSNumber *)node)


@end
