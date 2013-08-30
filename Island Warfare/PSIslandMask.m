//
//  PSIslandMask.m
//  PSNoiseDemo
//
//  Created by Philippe Sawaya on 8/24/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSIslandMask.h"

@interface PSIslandMask ()

@property (nonatomic) double centerX;
@property (nonatomic) double centerY;

@property (nonatomic) double width;
@property (nonatomic) double height;

@end

@implementation PSIslandMask

+(double)distanceBetweenPoint: (CGPoint)p1 andPoint: (CGPoint)p2 {

    double dx = p2.x-p1.x;
    double dy = p2.y-p1.y;
    return sqrt(pow(dx, 2) + pow(dy, 2));
}

-(double)scalingFunction: (double)a {
    return 0.069 * pow(3.85, (1.98*a)) - (a*0.25);
}

-(double)valueAtX: (double)x y: (double)y {
    
    //Get distance from center
    double distanceFromCenter = [PSIslandMask distanceBetweenPoint:CGPointMake((float)self.centerX, (float)self.centerY) andPoint:CGPointMake(x, y)];
    
    double input = 1.0-(distanceFromCenter/(self.width*2.2));
    
    double value = [self scalingFunction:input];
    
    //If the value is very close to the edge, make it lower so that it is more likely to be water
    if((self.width-distanceFromCenter) < self.width/14) value *= 0.94;
    
    if (value > 1.0) value = 0.99;
    if (value < 0.0) value = 0.01;
    
    return value;
}

+(instancetype)maskWithCenterX: (double)x y: (double)y width: (double)width height: (double)height {

    return [[PSIslandMask alloc] initWithCenterX:x y:y width:width height:height];
}

-(id)initWithCenterX: (double)x y: (double)y width: (double)width height: (double)height {

    if(self = [super init]) {
    
        self.width = width;
        self.height = height;
        
        self.centerX = x;
        self.centerY = y;
        
        //Random offset of center so that the highest point is not in the exact middle
        double centerXRandomOffset = arc4random_uniform((int)(self.width/22)) + self.width / 25;   //This way, the offset is greater than 0
        double centerYRandomOffset = arc4random_uniform((int)(self.height/22)) + self.height / 25; //and not outrageously far from the center
        
        //Randomly decide whether to make the offset in the positive or negative direction
        self.centerX += (arc4random()%2 == 0) ? centerXRandomOffset : (centerXRandomOffset*-1);
        self.centerY += (arc4random()%2 == 0) ? centerYRandomOffset : (centerYRandomOffset*-1);
    }
    
    return self;
}

@end
