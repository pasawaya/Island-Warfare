//
//  PSToolbarButton.h
//  Island Warfare
//
//  Created by Philippe Sawaya on 5/31/15.
//  Copyright (c) 2015 Philippe Sawaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSToolbarButton : UIButton

@property (nonatomic, strong) UIImage *titleImage;
@property (nonatomic) PSButtonTag tag;

-(void)setButtonType:(PSButtonTag)tag;

@end
