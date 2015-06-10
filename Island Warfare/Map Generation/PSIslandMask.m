//
//  PSIslandMask.m
//  PSNoiseDemo
//
//  Created by Philippe Sawaya on 8/24/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSIslandMask.h"

@interface PSIslandMask ()

@property (nonatomic) CGPoint center;

@property (nonatomic) float width;
@property (nonatomic) float height;

@end

@implementation PSIslandMask

#pragma mark - Initializer
-(id)initWithCenterX:(float)x y:(float)y width:(float)width height:(float)height {
    if(self = [super init]) {
        
        self.width = width;
        self.height = height;
        
        //Random offset of center so that the highest point is not in the exact middle
        double centerRandomOffsetX = arc4random_uniform((int)(self.width/kIslandMaskCenterXOffset));
        double centerRandomOffsetY = arc4random_uniform((int)(self.height/kIslandMaskCenterYOffset));
        
        //Randomly decide whether to make the offset in the positive or negative direction
        float finalOffsetX = (arc4random() % 2 == 0) ? centerRandomOffsetX : (-1*centerRandomOffsetX);
        float finalOffsetY = (arc4random() % 2 == 0) ? centerRandomOffsetY : (-1*centerRandomOffsetY);
        
        self.center = CGPointMake(x+finalOffsetX, y+finalOffsetY);
    }
    return self;
}

#pragma mark - Island Mask Generation Function
-(float)valueAtX: (float)x y: (float)y {
    //Get distance from center
    float distanceFromCenter = distance2D(self.center, CGPointMake(x, y));
    float value = scalingFunction(1.0f-(distanceFromCenter/(self.width * 2.2f)));
    
    //If the value is close to the edge, make it lower so that it is more likely to be water
    if((self.width-distanceFromCenter) < self.width/14.0f) value *= 0.88f;
    
    //If the value is close to the center, make it higher to simulate a rise in elevation
    if((self.width-(self.width-distanceFromCenter)) < self.width/14.0f) value *= 1.05f;
    
    return value;
}

#pragma mark - Helper Functions
inline static float distance2D(CGPoint p1, CGPoint p2) {
    float dx = p2.x-p1.x;
    float dy = p2.y-p1.y;
    return sqrtf(powf(dx, 2.0f) + powf(dy, 2.0f));
}

inline static float scalingFunction(float a) {
    return 0.057f * powf(3.82f, (2.0f * a)) - (a * 0.25f);
}

@end
