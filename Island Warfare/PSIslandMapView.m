//
//  PSIslandMapView.m
//  Island Warfare
//
//  Created by Philippe Sawaya on 8/30/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSIslandMapView.h"

#import "PSIslandMapUnit.h"

#import "PSIslandMask.h"
#import "PSFractionalBrownianNoise.h"
#import "PSBlendMode.h"

static const float kNoiseScale = 30.0f;

static const NSUInteger kScreenHeight = 480;
static const NSUInteger kScreenWidth = 320;

static const NSUInteger kUnitHeight = 2;
static const NSUInteger kUnitWidth = 2;

static const NSUInteger kUnitsUp = (kScreenHeight/kUnitHeight);
static const NSUInteger kUnitsAcross = (kScreenWidth/kUnitWidth);

@interface PSIslandMapView ()

@property (nonatomic, strong) NSMutableArray *mapUnits;

@end

@implementation PSIslandMapView

-(id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.mapUnits = [NSMutableArray array];
        
        PSFractionalBrownianNoise *fbm   = [PSFractionalBrownianNoise noiseGeneratorWithSeed:arc4random_uniform(10000)];
        PSIslandMask              *mask  = [PSIslandMask maskWithCenterX:kUnitsAcross/2 y:kUnitsUp/2 width:kUnitsAcross height:kUnitsUp];
        
        for(NSUInteger x = 0; x < kUnitsAcross; x++) {
            for(NSUInteger y = 0; y < kUnitsUp; y++) {
                //Get the current elevation value
                float currentNoiseValue = (float)[fbm noise2ForX:(x/kNoiseScale) y:(y/kNoiseScale)];
                float currentMaskValue  = (float)[mask valueAtX:x y:y];
                float currentBlendValue = (float)[PSBlendMode vividLightBlendBetweenBase:currentNoiseValue andBlend:currentMaskValue];
                
                CGRect currentUnitFrame = CGRectMake(x*kUnitWidth, y*kUnitHeight, kUnitWidth, kUnitHeight);
                PSIslandMapUnit *currentUnit = [[PSIslandMapUnit alloc] initWithFrame:currentUnitFrame elevation:currentBlendValue];
                [self.mapUnits addObject:currentUnit];
            }
        }
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    for(PSIslandMapUnit *currentUnit in self.mapUnits) {
        [self addSubview:currentUnit];
    }
}

@end
