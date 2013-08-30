//
//  PSIslandMask.h
//  PSNoiseDemo
//
//  Created by Philippe Sawaya on 8/24/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSIslandMask : NSObject

+(instancetype)maskWithCenterX: (double)x y: (double)y width: (double)width height: (double)height;

-(double)valueAtX: (double)x y: (double)y;

@end
