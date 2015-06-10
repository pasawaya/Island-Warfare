//
//  PSTerrainMap.h
//  Island Warfare
//
//  Created by Philippe Sawaya on 6/1/15.
//  Copyright (c) 2015 Philippe Sawaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PSTerrainUnit;

@interface PSTerrainMap : NSObject

+(instancetype)terrainMap;

-(NSArray *)allUnits;
-(PSTerrainUnit *)unitAtPoint:(CGPoint)p;
-(void)replaceUnitAtPoint:(CGPoint)p withUnit:(PSTerrainUnit *)unit;

@end
