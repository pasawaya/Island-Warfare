//
//  PSGridView.m
//  Island Warfare
//
//  Created by Philippe Sawaya on 5/31/15.
//  Copyright (c) 2015 Philippe Sawaya. All rights reserved.
//

#import "PSGridView.h"

@implementation PSGridView

-(id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        self.layer.opacity = 0.0f;
    }
    return self;
}
-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    
    //Draw Vertical Lines
    for(NSUInteger x = 0; x < kGridNumVerticalLines; x++) {
        CGContextFillRect(context, CGRectMake(x*(kScreenWidth/kGridNumVerticalLines), 0, 1, kScreenHeight));
    }
    //Draw Horizontal Lines
    for(NSUInteger y = 0; y < kGridNumHorizontalLines; y++) {
        CGContextFillRect(context, CGRectMake(0, y*(kScreenHeight/kGridNumHorizontalLines), kScreenWidth, 1));
    }
}
-(void)appear {
    [UIView animateWithDuration:kGridAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.layer.opacity = 1.0f;
    } completion:nil];
}
-(void)disappear {
    [UIView animateWithDuration:kGridAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.layer.opacity = 0.0f;
    } completion:nil];
}

@end
