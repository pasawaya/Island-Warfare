//
//  PSAppDelegate.m
//  Island Warfare
//
//  Created by Philippe Sawaya on 8/30/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSAppDelegate.h"
#import "PSTerrainDataManager.h"

@implementation PSAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //Hide status bar and network activity indicator
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    //Load Terrain Unit Data
    PSTerrainDataManager *dataManager = [PSTerrainDataManager sharedInstance];
    [dataManager loadAllTerrainUnitData];
    
    return YES;
}

@end
