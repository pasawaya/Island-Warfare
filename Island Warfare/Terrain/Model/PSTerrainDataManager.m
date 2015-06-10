//
//  PSTerrainUnitDataManager.m
//  PSIslandTerrainGenerator
//
//  Created by Philippe Sawaya on 9/15/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSTerrainDataManager.h"
#import "PSPropertyListDataFetcher.h"

@interface PSTerrainDataManager ()

@property (nonatomic, strong) PSPropertyListDataFetcher *fetcher;
@property (nonatomic, strong) NSDictionary *unitColors;
@property (nonatomic, strong) NSArray      *unitElevations;

@end

@implementation PSTerrainDataManager

#pragma mark -
#pragma mark Initialization
+(instancetype)sharedInstance {
    static dispatch_once_t once;
    static PSTerrainDataManager *sharedTerrainUnitDataManager;
    
    dispatch_once(&once, ^ {
        sharedTerrainUnitDataManager = [[PSTerrainDataManager alloc] init];
    });
    
    return sharedTerrainUnitDataManager;
}
-(id)init {
    if(self = [super init]) {
        self.fetcher = [PSPropertyListDataFetcher sharedDataFetcherWithTarget:[[NSBundle mainBundle] pathForResource:@"Terrain" ofType:@"plist"]];
        self.unitColors = [NSDictionary dictionary];
        self.unitElevations = [NSArray array];
    }
    return self;
}

#pragma mark -
#pragma mark Loading Data
-(void)loadAllTerrainUnitData {
    [self loadColorData];
    [self loadElevationData];
}
-(void)loadColorData {
    NSMutableDictionary *colors = [[NSMutableDictionary alloc] initWithCapacity:PSTerrainTypeNumberOfTypes];
    
    for(NSUInteger currentTerrainType = 0; currentTerrainType < PSTerrainTypeNumberOfTypes; currentTerrainType++) {
        NSString *typeName = [PSTerrainDataManager typeAsString:currentTerrainType];
        float r = [[self.fetcher elementWithPath:[NSString stringWithFormat:@"%@.color.red", typeName]] floatValue];
        float g = [[self.fetcher elementWithPath:[NSString stringWithFormat:@"%@.color.green", typeName]] floatValue];
        float b = [[self.fetcher elementWithPath:[NSString stringWithFormat:@"%@.color.blue", typeName]] floatValue];
        [colors setObject:[UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1.0f] forKey:@(currentTerrainType)];
    }
    
    self.unitColors = colors;
}
-(void)loadElevationData {
    NSMutableArray *elevations = [[NSMutableArray alloc] initWithCapacity:PSTerrainTypeNumberOfTypes];
    
    for(NSUInteger currentTerrainType = 0; currentTerrainType < PSTerrainTypeNumberOfTypes; currentTerrainType++) {
        float elevation = [[self.fetcher elementWithPath:[NSString stringWithFormat:@"%@.upper_elevation_threshold", [PSTerrainDataManager typeAsString:currentTerrainType]]] floatValue];
        [elevations addObject:@(elevation)];
    }
    
    self.unitElevations = elevations;
}

#pragma mark - 
#pragma mark Retrieving Data
-(UIColor *)colorForTerrainType: (PSTerrainType)type {
    return self.unitColors[@(type)];
}
-(PSTerrainType)terrainTypeForElevation:(float)elevation {
    NSUInteger index = 0;
    
    while(index < PSTerrainTypeNumberOfTypes-1) {
        if(elevation < [self.unitElevations[index++] floatValue]) {return index;}
    }
    
    return PSTerrainTypeUnknown;
}

#pragma mark -
#pragma mark Utilities
+(NSString *)typeAsString:(PSTerrainType)type {
    static NSString * const kTerrainUnitStringRepresentations[] = {@"deep_water",
                                                                   @"medium_water",
                                                                   @"shallow_water",
                                                                   @"beach",
                                                                   @"low_grass",
                                                                   @"medium_grass",
                                                                   @"forest",
                                                                   @"light_rock",
                                                                   @"medium_rock",
                                                                   @"dark_rock",
                                                                   @"snow"};
    return kTerrainUnitStringRepresentations[type];
}

@end