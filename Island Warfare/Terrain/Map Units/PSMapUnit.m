//
//  PSMapUnit.m
//  Island Warfare
//
//  Created by Philippe Sawaya on 6/1/15.
//  Copyright (c) 2015 Philippe Sawaya. All rights reserved.
//

#import "PSMapUnit.h"

@implementation PSMapUnit

-(id)initWithOrigin:(CGPoint)o {
    if(self = [super init]) {
        self.origin = o;
    }
    return self;
}

@end
