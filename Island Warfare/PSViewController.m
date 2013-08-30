//
//  PSViewController.m
//  Island Warfare
//
//  Created by Philippe Sawaya on 8/30/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSViewController.h"
#import "PSIslandMapView.h"

@interface PSViewController ()

@end

@implementation PSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PSIslandMapView *map = [[PSIslandMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:map];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    //Code
}

@end
