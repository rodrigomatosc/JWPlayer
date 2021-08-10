//
//  ViewController.m
//  BasicPlayer-ObjC
//
//  Created by Michael Salvador on 8/3/21.
//

#import "ViewController.h"

#define videoUrlString @"https://live.impresa.pt/live/sic/sic.m3u8"
#define posterUrlString @"https://d3el35u4qe4frz.cloudfront.net/bkaovAYt-480.jpg"

@interface ViewControllerImpresa ()

@end

@implementation ViewControllerImpresa

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set the view's background color to black for better contrast.
    self.view.backgroundColor = UIColor.blackColor;

    // Set up the player.
    [self setUpPlayer];
}

-(void)setFile:(NSString*)file {
    NSURL *url = [NSURL URLWithString:file];
    urlFile = url;
}

/**
 Sets up the player with a simple configuration.
 */
- (void)setUpPlayer {
    NSLog(@"Aqui 2");
    NSURL *videoUrl = [NSURL URLWithString:videoUrlString];
    NSURL *posterUrl = [NSURL URLWithString:posterUrlString];

    // First, use the JWPlayerItemBuilder to create a JWPlayerItem that will be used by the player configuration.
    JWError *playerItemError;
    playerItemBuilder = [[JWPlayerItemBuilder alloc] init];
    [playerItemBuilder file:videoUrl];
    [playerItemBuilder posterImage:posterUrl];
    JWPlayerItem *playerItem = [playerItemBuilder buildAndReturnError:&playerItemError];
    if (playerItemError != nil) {
        // Handle error
        return;
    }

    // Second, create a player config with the created JWPlayerItem.
    JWError *configError;
    JWPlayerConfigurationBuilder *configBuilder = [[JWPlayerConfigurationBuilder alloc] init];
    [configBuilder playlist:@[playerItem]];
    JWPlayerConfiguration *config = [configBuilder buildAndReturnError:&configError];
    if (configError != nil) {
        // Handle error
        return;
    }

    // Lastly, use the created JWPlayerConfiguration to set up the player.
    [self.player configurePlayerWith:config];
}


@end
