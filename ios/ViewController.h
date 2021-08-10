//
//  ViewController.h
//  BasicPlayer-ObjC
//
//  Created by Michael Salvador on 8/3/21.
//

#import <UIKit/UIKit.h>
#import <JWPlayerKit/JWPlayerKit.h>
#import "JWPlayerKit/JWPlayerObjCViewController.h"

@interface ViewControllerImpresa : JWPlayerObjCViewController {
    JWPlayerItemBuilder *playerItemBuilder;
    NSURL *urlFile;
}

-(void) setFile:(NSString *)file;

@end

