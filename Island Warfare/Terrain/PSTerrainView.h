//
//  PSIslandMapView.h
//  Island Warfare
//
//  Created by Philippe Sawaya on 8/30/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSTerrainUnit;

@interface PSTerrainView : UIView

-(void)addUnit:(PSTerrainUnit *)unit atPoint:(CGPoint)p;
-(void)addCityAtPoint:(CGPoint)p;

@end
