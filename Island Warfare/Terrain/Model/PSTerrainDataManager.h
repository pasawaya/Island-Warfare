//
//  PSTerrainUnitDataManager.h
//  PSIslandTerrainGenerator
//
//  Created by Philippe Sawaya on 9/15/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSTerrainDataManager : NSObject

+(instancetype)sharedInstance;
-(void)loadAllTerrainUnitData;

-(UIColor *)colorForTerrainType:(PSTerrainType)type;
-(PSTerrainType)terrainTypeForElevation:(float)elevation;

@end
