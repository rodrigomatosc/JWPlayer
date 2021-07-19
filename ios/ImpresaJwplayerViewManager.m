#import "React/RCTViewManager.h"
#import <JWPlayer_iOS_SDK/JWPlayerController.h>


@interface RCT_EXTERN_MODULE(ImpresaJwplayerViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(color, NSString)
RCT_EXPORT_VIEW_PROPERTY(file, NSString)
RCT_EXPORT_VIEW_PROPERTY(imageFile, NSString)

// simple properties
RCT_EXPORT_VIEW_PROPERTY(volume, double)
RCT_EXPORT_VIEW_PROPERTY(autostart, BOOL)
RCT_EXPORT_VIEW_PROPERTY(repeatVideo, BOOL)
RCT_EXPORT_VIEW_PROPERTY(controls, BOOL)
RCT_EXPORT_VIEW_PROPERTY(heightVideo, double)
RCT_EXPORT_VIEW_PROPERTY(widthVideo, double)

// events properties
RCT_EXPORT_VIEW_PROPERTY(onFullScreen, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onFullScreenExit, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onPlay, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onPause, RCTBubblingEventBlock)

// methods properties
RCT_EXTERN_METHOD(play:(nonnull NSNumber *)node)

RCT_EXTERN_METHOD(pause)

RCT_EXTERN_METHOD(fullscreen)
RCT_EXTERN_METHOD(exitFullscreen)

@end
