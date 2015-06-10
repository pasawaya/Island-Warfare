//
//  PSIslandMask.h
//  PSNoiseDemo
//
//  Created by Philippe Sawaya on 8/24/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSIslandMask : NSObject

-(id)initWithCenterX:(float)x y:(float)y width:(float)width height:(float)height;
-(float)valueAtX:(float)x y:(float)y;

@end
