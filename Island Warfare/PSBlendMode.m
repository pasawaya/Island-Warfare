//
//  PSBlendMode.m
//  PSIslandTerrainGenerator
//
//  Created by Philippe Sawaya on 8/26/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSBlendMode.h"

@implementation PSBlendMode

+(double)colorBurnBlendBetweenBase: (double)base andBlend: (double)blend {
    
    if(blend == 0.0) return blend;
    else             return fmax((1.0 - ((1.0 - base) / blend)), 0.0);
}
+(double)colorDodgeBlendBetweenBase: (double)base andBlend: (double)blend {
    
    if(blend == 1.0) return blend;
    else             return fmin((base / (1.0 - blend)), 1.0);
}

+(double)vividLightBlendBetweenBase: (double)base andBlend: (double)blend {
    
    //Soft light
    /*if(blend < 0.5) return (2.0 * base * blend) + (blend*base) - (2.0 * base*base*blend);
    else            return 2.0 * sqrt(base) * blend - sqrt(base) + 2.0 * base - 2.0 * base*blend;*/
    
    //Hard light
    if(blend > 0.5) return ((base + (2.05 * (blend - 0.5))) > 1.0 ? 1.0 : (base + (2.05 * (blend - 0.5))));
    else            return (((base + 2.05 * blend) - 1) > 1.0 ? 1.0 : ((base + 2.05 * blend) - 1));
    
    //Vivid light
    /*if(blend < 0.5)  return [PSBlendMode colorBurnBlendBetweenBase:base andBlend:(1.3*blend)];
    else             return [PSBlendMode colorDodgeBlendBetweenBase:base andBlend:((blend - 0.5))];*/
}

@end
