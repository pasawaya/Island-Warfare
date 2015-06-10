//
//  PSPerlinNoise.m
//  PSNoise
//
//  Created by Philippe Sawaya on 8/22/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSFractionalBrownianNoise.h"

@implementation PSFractionalBrownianNoise

#pragma mark - Random Noise
inline static float classicNoise(float x, float y) {
    int n = x + y * 57;
    n = (n << 13) ^ n;
    return (1.0f - ((n * (n * n * 15731 + 789221) + 1376312589) & 0x7fffffff) / 1073741824.0f);
}

#pragma mark - Smoothing
inline static float smoothNoise(float x, float y) {
    float outer =   (classicNoise(x - 2, y - 2) + classicNoise(x + 2, y - 2) + classicNoise(x - 2, y + 2) + classicNoise(x + 2, y + 2)) / 32;
    float corners = (classicNoise(x - 1, y - 1) + classicNoise(x + 1, y - 1) + classicNoise(x - 1, y + 1) + classicNoise(x + 1, y + 1)) / 16;
    float sides =   (classicNoise(x - 1, y    ) + classicNoise(x + 1, y    ) + classicNoise(x    , y - 1) + classicNoise(x    , y + 1)) / 8;
    float center =  (classicNoise(x    , y    )) / 4;
    return corners + sides + center + outer;
}

#pragma mark - Interpolation
inline static float interpolatedNoise(float x, float y, float seed) {
    int xInt = (int)x;
    float fractionalX = x-xInt;
    
    int yInt = (int)y;
    float fractionalY = y-yInt;
    
    float v1 = seed*smoothNoise(xInt    , yInt);
    float v2 = seed*smoothNoise(xInt + 1, yInt);
    float v3 = seed*smoothNoise(xInt    , yInt + 1);
    float v4 = seed*smoothNoise(xInt + 1, yInt + 1);
    
    float i1 = seed*cosineInterpolation(v1, v2, fractionalX);
    float i2 = seed*cosineInterpolation(v3, v4, fractionalX);
    
    return (seed*cosineInterpolation(i1, i2, fractionalY));
}
inline static float cosineInterpolation(float a, float b, float x) {
    float f = (1-cosf(x*kPi)) * 0.5f;
    return a*(1-f) + b*f;
}

#pragma mark - Perlin Noise
float noise2(float x, float y, float seed) {
    float total = 0.0f;
    NSInteger n = kFBMOctaveCount - 1;
    float p = kFBMPersistence, frequency = kFBMFrequency, amplitude = 0.0f;
    
    for(int currentOctave = 0; currentOctave < n; currentOctave++) {
        
        frequency = powf(2.0f, currentOctave);
        amplitude = powf(p, currentOctave);
        total += interpolatedNoise((x*frequency), (y*frequency), seed) * amplitude;
    }
    
    return convertBetweenRanges(total, -1.0f, 1.0f, 0.0f, 1.0f);
}

#pragma mark - Utility
inline static float convertBetweenRanges(float x, float oldLow, float oldHigh, float newLow, float newHigh) {
    float oldRange = oldHigh-oldLow;
    float newRange = newHigh-newLow;
    return (((x-oldLow)*newRange)/oldRange)+newLow;
}


@end