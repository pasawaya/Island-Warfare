//
//  PSIslandMapUnit.m
//  Island Warfare
//
//  Created by Philippe Sawaya on 8/30/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSTerrainUnit.h"
#import "PSPropertyListDataFetcher.h"
#import "PSTerrainDataManager.h"

@interface PSTerrainUnit ()

@property (nonatomic, strong) PSTerrainDataManager *dataManager;

@end

@implementation PSTerrainUnit

-(id)initWithOrigin:(CGPoint)o elevation:(double)e {
    if (self = [super initWithOrigin:o]) {
        self.dataManager = [PSTerrainDataManager sharedInstance];
        self.terrainType = [self.dataManager terrainTypeForElevation:e];
        self.color       = [self.dataManager colorForTerrainType:self.terrainType];
        self.size        = CGSizeMake(kUnitWidth, kUnitHeight);
    }
    return self;
}

@end