//
//  PSPerlinNoise.m
//  PSNoise
//
//  Created by Philippe Sawaya on 8/22/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSFractionalBrownianNoise.h"

//Default frequency
#define DEFAULT_FBM_FREQUENCY 20.0

//Default number of octaves
#define DEFAULT_FBM_OCTAVE_COUNT 6

//Default persistence value
#define DEFAULT_FBM_PERSISTENCE 0.63

//Default seed value
#define DEFAULT_FBM_SEED 10.0

#define PI 3.1415927

@interface PSFractionalBrownianNoise ()

@property (nonatomic) double frequency;
@property (nonatomic) double persistence;
@property (nonatomic) NSUInteger octaveCount;
@property (nonatomic) NSUInteger seed;

@end

@implementation PSFractionalBrownianNoise

#pragma mark - Initializers
+(instancetype)noiseGeneratorWithSeed: (NSInteger)seed; {
    
    return [[PSFractionalBrownianNoise alloc] initWithFrequency:DEFAULT_FBM_FREQUENCY
                                                    persistence:DEFAULT_FBM_PERSISTENCE
                                                    octaveCount:DEFAULT_FBM_OCTAVE_COUNT
                                                           seed:seed];
}
-(id)initWithFrequency: (double)f
           persistence: (double)p
           octaveCount: (NSUInteger)oc
                  seed: (NSUInteger)s {
    
    if(self = [super init]) {
        self.frequency = f;
        self.persistence = p;
        self.octaveCount = oc;
        self.seed = s;
    }
    
    return self;
}

#pragma mark - Smoothing
-(double)smoothNoiseForX: (double)x y: (double)y {
    
    double outerCorners = (([self classicNoiseForX:x-2 y:y-2])+([self classicNoiseForX:x+2 y:y-2])+([self classicNoiseForX:x-2 y:y+2])+([self classicNoiseForX:x+2 y:y+2])) / 32;
    double corners = (([self classicNoiseForX:x-1 y:y-1])+([self classicNoiseForX:x+1 y:y-1])+([self classicNoiseForX:x-1 y:y+1])+([self classicNoiseForX:x+1 y:y+1])) / 16;
    double sides   = (([self classicNoiseForX:x-1 y:y])+([self classicNoiseForX:x+1 y:y])+([self classicNoiseForX:x y:y-1])+([self classicNoiseForX:x y:y+1])) / 8;
    double center  = ([self classicNoiseForX:x y:y]) / 4;
    return corners + sides + center + outerCorners;
}

#pragma mark - Interpolation
-(double)interpolatedNoiseForX: (double)x y: (double)y {
    
    int xInt = (int)x;
    double fractionalX = x-xInt;
    
    int yInt = (int)y;
    double fractionalY = y-yInt;
    
    double v1 = [self smoothNoiseForX:xInt     y:yInt];
    double v2 = [self smoothNoiseForX:xInt + 1 y:yInt];
    double v3 = [self smoothNoiseForX:xInt     y:yInt + 1];
    double v4 = [self smoothNoiseForX:xInt + 1 y:yInt + 1];
    
    double i1 = [self cosineInterpolationBetweenA:v1 b:v2 x:fractionalX];
    double i2 = [self cosineInterpolationBetweenA:v3 b:v4 x:fractionalX];
    
    return [self cosineInterpolationBetweenA:i1 b:i2 x:fractionalY];
}
-(double)cosineInterpolationBetweenA: (double)a b: (double)b x: (double)x {
    double ft = x*PI;
    double f = (1-cos(ft)) * 0.5;
    return a*(1-f) + b*f;
}

#pragma mark - Random Noise
-(double)classicNoiseForX: (double)x y: (double)y {
    
    int n = x + y * 57*self.seed;
    n = (n<<13)^n;
    return (1.0 - ((n*(n*n*15731+789221) + 1376312589) & 0x7fffffff) / 1073741824.0);
}

#pragma mark - Perlin Noise
-(double)noise2ForX: (double)x y: (double)y {
    double total = 0;
    NSInteger n = self.octaveCount - 1;
    double p = self.persistence, frequency = 0, amplitude = 0;
    
    for(int currentOctave = 0; currentOctave < n; currentOctave++) {
        
        frequency = pow(2, currentOctave);
        amplitude = pow(p, currentOctave);
        
        total += ([self interpolatedNoiseForX:(x*frequency) y:(y*frequency)]) * amplitude;
    }
    
    return [self convertValue:total withPriorLow:-1.0 high:1.0 toRangeWithLow:0.0 high:1.0];
}

-(double)convertValue: (double)x withPriorLow: (double)oldLow high: (double)oldHigh  toRangeWithLow: (double)newLow high: (double)newHigh  {
    
    double oldMax = oldHigh;
    double oldMin = oldLow;
    double newMax = newHigh;
    double newMin = newLow;
    
    double oldRange = oldMax-oldMin;
    double newRange = newMax-newMin;
    
    double oldValue = x;
    double newValue = (((oldValue-oldMin)*newRange)/oldRange)+newMin;
    
    return newValue;
}


@end