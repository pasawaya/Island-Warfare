//
//  PSViewController.m
//  Island Warfare
//
//  Created by Philippe Sawaya on 8/30/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSViewController.h"
#import "PSTerrainView.h"
#import "PSToolbar.h"
#import "PSGridView.h"

#import "PSTerrainUnit.h"

@interface PSViewController ()

@property (nonatomic, strong) PSTerrainView *terrainView;
@property (nonatomic, strong) PSToolbar     *toolbar;
@property (nonatomic, strong) PSGridView    *grid;

@end

@implementation PSViewController

#pragma mark -
#pragma mark Initialization
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.terrainView = [[PSTerrainView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.terrainView];
    
    self.grid = [[PSGridView alloc] initWithFrame:CGRectMake(kToolbarWidth, kInfoBarHeight, kScreenWidth-kToolbarWidth, kScreenHeight-kInfoBarHeight)];
    [self.view addSubview:self.grid];
    
    self.toolbar = [[PSToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.toolbar];
}

#pragma mark -
#pragma mark Touch Input Handling
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.grid appear];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.grid disappear];
    
    CGPoint touchLocation = [[[touches allObjects] lastObject] locationInView:self.view];
    PSTerrainUnit *unit = [[PSTerrainUnit alloc] initWithOrigin:touchLocation elevation:0.9];
    [self.terrainView addUnit:unit atPoint:touchLocation];
}

#pragma mark -
#pragma mark Clean-up
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end