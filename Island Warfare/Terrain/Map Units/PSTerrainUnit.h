//
//  PSIslandMapUnit.h
//  Island Warfare
//
//  Created by Philippe Sawaya on 8/30/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSMapUnit.h"

@interface PSTerrainUnit : PSMapUnit

@property (nonatomic) PSTerrainType terrainType;

-(id)initWithOrigin:(CGPoint)o elevation:(double)e;

@end
