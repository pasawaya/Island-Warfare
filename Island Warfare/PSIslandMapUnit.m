//
//  PSIslandMapUnit.m
//  Island Warfare
//
//  Created by Philippe Sawaya on 8/30/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSIslandMapUnit.h"
#import "PSPropertyListDataFetcher.h"

@interface PSIslandMapUnit ()


@end

@implementation PSIslandMapUnit

-(id)initWithFrame:(CGRect)frame elevation:(double)e {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [self colorForElevation:e];
    }
    
    return self;
}

-(UIColor *)colorForElevation:(double)elevation {

    PSPropertyListDataFetcher *fetcher = [PSPropertyListDataFetcher sharedDataFetcherWithTarget:[[NSBundle mainBundle] pathForResource:@"Terrain" ofType:@"plist"]];
    float r = 0.0f, g = 0.0f, b = 0.0f;
    
    //Definitely a code smell, but it's the simplest way to do it
    if(elevation < [[fetcher elementWithPath:@"deep_water.upper_elevation_threshold"] doubleValue]) {
        r = [[fetcher elementWithPath:@"deep_water.color.red"] floatValue];
        g = [[fetcher elementWithPath:@"deep_water.color.green"] floatValue];
        b = [[fetcher elementWithPath:@"deep_water.color.blue"] floatValue];
    }
    else if(elevation < [[fetcher elementWithPath:@"medium_water.upper_elevation_threshold"] doubleValue]) {
        r = [[fetcher elementWithPath:@"medium_water.color.red"] floatValue];
        g = [[fetcher elementWithPath:@"medium_water.color.green"] floatValue];
        b = [[fetcher elementWithPath:@"medium_water.color.blue"] floatValue];
    }
    else if(elevation < [[fetcher elementWithPath:@"shallow_water.upper_elevation_threshold"] doubleValue]) {
        r = [[fetcher elementWithPath:@"shallow_water.color.red"] floatValue];
        g = [[fetcher elementWithPath:@"shallow_water.color.green"] floatValue];
        b = [[fetcher elementWithPath:@"shallow_water.color.blue"] floatValue];
    }
    else if(elevation < [[fetcher elementWithPath:@"beach.upper_elevation_threshold"] doubleValue]) {
        r = [[fetcher elementWithPath:@"beach.color.red"] floatValue];
        g = [[fetcher elementWithPath:@"beach.color.green"] floatValue];
        b = [[fetcher elementWithPath:@"beach.color.blue"] floatValue];
    }
    else if(elevation < [[fetcher elementWithPath:@"low_grass.upper_elevation_threshold"] doubleValue]) {
        r = [[fetcher elementWithPath:@"low_grass.color.red"] floatValue];
        g = [[fetcher elementWithPath:@"low_grass.color.green"] floatValue];
        b = [[fetcher elementWithPath:@"low_grass.color.blue"] floatValue];
    }
    else if(elevation < [[fetcher elementWithPath:@"medium_grass.upper_elevation_threshold"] doubleValue]) {
        r = [[fetcher elementWithPath:@"medium_grass.color.red"] floatValue];
        g = [[fetcher elementWithPath:@"medium_grass.color.green"] floatValue];
        b = [[fetcher elementWithPath:@"medium_grass.color.blue"] floatValue];
    }
    else if(elevation < [[fetcher elementWithPath:@"forest.upper_elevation_threshold"] doubleValue]) {
        r = [[fetcher elementWithPath:@"forest.color.red"] floatValue];
        g = [[fetcher elementWithPath:@"forest.color.green"] floatValue];
        b = [[fetcher elementWithPath:@"forest.color.blue"] floatValue];
    }
    else if(elevation < [[fetcher elementWithPath:@"light_rock.upper_elevation_threshold"] doubleValue]) {
        r = [[fetcher elementWithPath:@"light_rock.color.red"] floatValue];
        g = [[fetcher elementWithPath:@"light_rock.color.green"] floatValue];
        b = [[fetcher elementWithPath:@"light_rock.color.blue"] floatValue];
    }
    else if(elevation < [[fetcher elementWithPath:@"medium_rock.upper_elevation_threshold"] doubleValue]) {
        r = [[fetcher elementWithPath:@"medium_rock.color.red"] floatValue];
        g = [[fetcher elementWithPath:@"medium_rock.color.green"] floatValue];
        b = [[fetcher elementWithPath:@"medium_rock.color.blue"] floatValue];
    }
    else if(elevation < [[fetcher elementWithPath:@"dark_rock.upper_elevation_threshold"] doubleValue]) {
        r = [[fetcher elementWithPath:@"dark_rock.color.red"] floatValue];
        g = [[fetcher elementWithPath:@"dark_rock.color.green"] floatValue];
        b = [[fetcher elementWithPath:@"dark_rock.color.blue"] floatValue];
    }
    else {
        r = [[fetcher elementWithPath:@"snow.color.red"] floatValue];
        g = [[fetcher elementWithPath:@"snow.color.green"] floatValue];
        b = [[fetcher elementWithPath:@"snow.color.blue"] floatValue];
    }
    
    return [UIColor colorWithRed:(r/255) green:(g/255) blue:(b/255) alpha:1.0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
