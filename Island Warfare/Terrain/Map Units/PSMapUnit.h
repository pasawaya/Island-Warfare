//
//  PSMapUnit.h
//  Island Warfare
//
//  Created by Philippe Sawaya on 6/1/15.
//  Copyright (c) 2015 Philippe Sawaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSMapUnit : NSObject

@property (nonatomic)         CGPoint origin;
@property (nonatomic)         CGSize  size;
@property (nonatomic, strong) UIColor *color;

-(id)initWithOrigin:(CGPoint)o;

@end
