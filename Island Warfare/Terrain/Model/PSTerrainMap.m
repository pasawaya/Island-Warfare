//
//  PSTerrainMap.m
//  Island Warfare
//
//  Created by Philippe Sawaya on 6/1/15.
//  Copyright (c) 2015 Philippe Sawaya. All rights reserved.
//

#import "PSTerrainMap.h"
#import "PSTerrainUnit.h"
#import "PSFractionalBrownianNoise.h"
#import "PSBlendMode.h"
#import "PSIslandMask.h"

@interface PSTerrainMap ()

@property (nonatomic, strong) NSMutableArray *terrainUnits;

@end

@implementation PSTerrainMap

#pragma mark -
#pragma mark Initialization
+(instancetype)terrainMap {
    PSTerrainMap *terrainMap = [[PSTerrainMap alloc] init];
    terrainMap.terrainUnits = [[NSMutableArray alloc] initWithCapacity:kUnitsUp*kUnitsAcross];
    [terrainMap generateTerrain];
    return terrainMap;
}
-(void)generateTerrain {
    float seed = _randomSeed();
    PSIslandMask *mask  = [[PSIslandMask alloc] initWithCenterX:kScreenWidth/2.0f
                                                              y:kScreenHeight/2.0f
                                                          width:kScreenWidth
                                                         height:kScreenHeight];
    
    for(NSUInteger x = 0; x < kUnitsAcross; x+=kUnitWidth) {
        for(NSUInteger y = 0; y < kUnitsUp; y+=kUnitHeight) {
            float noiseValue = noise2(x/kFBMNoiseScale, y/kFBMNoiseScale, seed);
            float maskValue  = [mask valueAtX:x y:y];
            float blendedValue = blend(noiseValue, maskValue);
            
            PSTerrainUnit *currentUnit = [[PSTerrainUnit alloc] initWithOrigin:CGPointMake(x, y) elevation:blendedValue];
            [self.terrainUnits addObject:currentUnit];
        }
    }
}

#pragma mark -
#pragma mark Accessing Units
-(NSArray *)allUnits {
    return self.terrainUnits;
}
-(PSTerrainUnit *)unitAtPoint:(CGPoint)p {
    return self.terrainUnits[(int)(p.x+(p.y*kUnitsAcross))];
}
-(void)replaceUnitAtPoint:(CGPoint)p withUnit:(PSTerrainUnit *)unit {
    [self.terrainUnits replaceObjectAtIndex:(int)p.x+(p.y*kUnitsAcross) withObject:unit];
}

#pragma mark -
#pragma mark Helper Methods
float _randomSeed() {
    float displacement = (((float)arc4random_uniform(100))/1000.0f);
    return (arc4random_uniform(2) == 0) ? 1.0f - displacement : 1.0f + displacement;
}

@end
