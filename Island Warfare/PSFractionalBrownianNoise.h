//
//  PSFractionalBrownianNoise.h
//  PSNoise
//
//  Created by Philippe Sawaya on 8/22/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSFractionalBrownianNoise : NSObject

//Returns a PSFractionalBrownianNoise object with default values
+(instancetype)noiseGeneratorWithSeed: (NSInteger)seed;

//Returns the noise value for the given coordinates
-(double)noise2ForX: (double)x y: (double)y;

@end
