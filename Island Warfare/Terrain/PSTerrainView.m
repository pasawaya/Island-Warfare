//
//  PSIslandMapView.m
//  Island Warfare
//
//  Created by Philippe Sawaya on 8/30/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSTerrainView.h"
#import "PSTerrainUnit.h"
#import "PSTerrainMap.h"

@interface PSTerrainView ()

@property (nonatomic, strong) PSTerrainMap *terrainMap;

@end

@implementation PSTerrainView

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.terrainMap = [PSTerrainMap terrainMap];
    }
    return self;
}
-(void)addUnit:(PSTerrainUnit *)unit atPoint:(CGPoint)p {
    [self.terrainMap replaceUnitAtPoint:p withUnit:unit];
    [self setNeedsDisplay];
}
-(void)addCityAtPoint:(CGPoint)p {
    
}
-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    for(PSTerrainUnit *unit in [self.terrainMap allUnits]) {
        CGContextSetFillColorWithColor(context, unit.color.CGColor);
        CGContextFillRect(context, CGRectMake(unit.origin.x, unit.origin.y, kUnitWidth, kUnitHeight));
    }
}

@end