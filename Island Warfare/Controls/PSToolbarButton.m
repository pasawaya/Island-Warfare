//
//  PSToolbarButton.m
//  Island Warfare
//
//  Created by Philippe Sawaya on 5/31/15.
//  Copyright (c) 2015 Philippe Sawaya. All rights reserved.
//

#import "PSToolbarButton.h"

@implementation PSToolbarButton

-(void)setButtonType:(PSButtonTag)tag {
    self.tag = tag;
    self.titleImage = [PSToolbarButton imageForTag:tag];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self setImageEdgeInsets:UIEdgeInsetsMake((kToolbarButtonHeight-kToolbarWidth)/2.0f, 0, (kToolbarButtonHeight-kToolbarWidth)/2.0f, 0)];
    [self setImage:self.titleImage forState:UIControlStateNormal];
}
+(UIImage *)imageForTag:(PSButtonTag)tag {
    NSArray *images = @[[UIImage imageNamed:@"Home.png"],
                        [UIImage imageNamed:@"Chat.png"],
                        [UIImage imageNamed:@"Leaderboard.png"],
                        [UIImage imageNamed:@"Settings.png"],
                        [UIImage imageNamed:@"Market.png"]];
    
    UIColor *imageColor = [UIColor colorWithRed:kToolbarButtonRed
                                          green:kToolbarButtonGreen
                                           blue:kToolbarButtonBlue
                                          alpha:1.0f];
    
    UIImage *image = [UIImage newImageFromMaskImage:images[tag] inColor:imageColor];
    return image;
}

@end