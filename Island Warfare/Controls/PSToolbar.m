//
//  PSToolbar.m
//  Island Warfare
//
//  Created by Philippe Sawaya on 5/31/15.
//  Copyright (c) 2015 Philippe Sawaya. All rights reserved.
//

#import "PSToolbar.h"
#import "PSToolbarButton.h"

#import "PSChatViewController.h"
#import "PSSettingsViewController.h"
#import "PSMarketView.h"

@interface PSToolbar ()

@property (nonatomic, strong) PSSettingsViewController *settingsViewController;
@property (nonatomic, strong) PSChatViewController     *chatViewController;
@property (nonatomic, strong) PSMarketView             *marketView;
@property (nonatomic, strong) NSArray *screens;

@property (nonatomic) CGRect visibleFrame;
@property (nonatomic) CGRect hiddenFrame;

@property (nonatomic, strong) UIView *currentlyDisplayedView;

@end

@implementation PSToolbar

#pragma mark -
#pragma mark Initialization
-(id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.currentlyDisplayedView = nil;
        
        self.visibleFrame = CGRectMake(kToolbarWidth,              0, kScreenWidth-kToolbarWidth, kScreenHeight);
        self.hiddenFrame  = CGRectMake(kToolbarWidth-kScreenWidth, 0, kScreenWidth-kToolbarWidth, kScreenHeight);
        
        [self _initializeBar];
        [self _initializeButtons];
        [self _initializeScreens];
    }
    return self;
}
-(void)_initializeBar {
    UIView *barBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kToolbarWidth, kScreenHeight)];
    barBackground.backgroundColor = [UIColor colorWithRed:kToolbarRed green:kToolbarGreen blue:kToolbarBlue alpha:1.0f];
    [self addSubview:barBackground];
}
-(void)_initializeButtons {
    for(int i = 0; i < kToolbarNumberofButtons; i++) {
        PSToolbarButton *button = [PSToolbarButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, i*kToolbarButtonHeight, kToolbarWidth, kToolbarButtonHeight);
        [button setButtonType:(PSButtonTag)i];
        [button addTarget:self action:@selector(toggleViewForButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}
-(void)_initializeScreens {
    self.chatViewController = [[PSChatViewController alloc] init];
    self.settingsViewController = [[PSSettingsViewController alloc] init];
    
    self.chatViewController.view.frame = self.hiddenFrame;
    self.settingsViewController.view.frame = self.hiddenFrame;
    self.marketView = [[PSMarketView alloc] initWithFrame:self.hiddenFrame];
    
    [self addSubview:self.chatViewController.view];
    [self addSubview:self.settingsViewController.view];
    [self addSubview:self.marketView];
    
    self.screens = @[self.chatViewController.view, self.settingsViewController.view, self.marketView];
}

#pragma mark -
#pragma mark Showing/Hiding Screens
-(void)toggleViewForButton:(PSToolbarButton *)sender {
    PSButtonTag tag = sender.tag;
    UIView *chosenView, *toView, *fromView;
    
    if      (tag == PSButtonTagHome)               {;}
    else if (tag == PSButtonTagChat)               {chosenView = self.chatViewController.view;}
    else if (tag == PSButtonTagLeaderboard)        {;}
    else if (tag == PSButtonTagSettings)           {chosenView = self.settingsViewController.view;}
    else if (tag == PSButtonTagMarket)             {chosenView = self.marketView;}
    else                                           {PSLog(@"Invalid button pressed");}
    
    BOOL userChoseAlreadyDisplayedView = ([self.currentlyDisplayedView isEqual:chosenView]);
    BOOL viewIsBeingDisplayed = (self.currentlyDisplayedView != nil);
    
    if(viewIsBeingDisplayed && !userChoseAlreadyDisplayedView) {
        toView   = chosenView;
        fromView = self.currentlyDisplayedView;
    }
    else if(viewIsBeingDisplayed && userChoseAlreadyDisplayedView) {
        toView   = nil;
        fromView = chosenView;
    }
    else if(!viewIsBeingDisplayed) {
        toView = chosenView;
        fromView = nil;
    }
    
    [self animateToView:toView fromView:fromView];
}
-(void)animateToView:(UIView *)toView fromView:(UIView *)fromView {
    [UIView animateWithDuration:kToolbarAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromView.frame = self.hiddenFrame;
    } completion:^(BOOL finished){
        self.currentlyDisplayedView = toView;
        [UIView animateWithDuration:kToolbarAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            toView.frame = self.visibleFrame;
        } completion:nil];
    }];
}

#pragma mark -
#pragma mark Screen Information
-(BOOL)screenIsCurrentlyDisplayed {
    for(UIView *view in self.screens) {
        if(CGRectEqualToRect(view.frame, self.visibleFrame)) {
            return true;
        }
    }
    return false;
}

@end
