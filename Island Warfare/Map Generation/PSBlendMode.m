//
//  PSBlendMode.m
//  PSIslandTerrainGenerator
//
//  Created by Philippe Sawaya on 8/26/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSBlendMode.h"

@implementation PSBlendMode

float blend(float base, float blend) {
    if(blend > 0.5f) return fminf(base + (2.05f * (blend - 0.5f)), 1.0);
    else             return fmaxf((base + 2.05f * blend) - 1     , 0.0);
}

@end
