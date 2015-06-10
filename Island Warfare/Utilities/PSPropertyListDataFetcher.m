//
//  PSPropertyListDataFetcher.m
//  PSIslandTerrainGenerator
//
//  Created by Philippe Sawaya on 8/26/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSPropertyListDataFetcher.h"

@interface PSPropertyListDataFetcher ()

@property (nonatomic, strong) NSString *target;
@property (nonatomic, strong) NSMutableDictionary *cachedPlistData;

@end


@implementation PSPropertyListDataFetcher

+(instancetype)sharedDataFetcherWithTarget: (NSString *)target {
    static dispatch_once_t once;
    static PSPropertyListDataFetcher *sharedResourceManager;
    
    if(nil != sharedResourceManager && !([sharedResourceManager.target isEqualToString:target])) sharedResourceManager.target = target;
    
    dispatch_once(&once, ^ {
        sharedResourceManager = [[PSPropertyListDataFetcher alloc] initWithTarget:target];
    });
    return sharedResourceManager;
}

-(id)initWithTarget: (NSString *)t {
    if(self = [super init]) {
        self.target = t;
        self.cachedPlistData = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(void)storeData: (NSString *)data forPath: (NSString *)path {
    [self.cachedPlistData setObject:data forKey:path];
}
-(NSString *)retrieveCachedDataForPath: (NSString *)path {
    return [self.cachedPlistData objectForKey:path];
}

-(NSString *)elementWithPath: (NSString *)path {
    @autoreleasepool {
        //If it's already cached, return it.
        if([self.cachedPlistData objectForKey:path]) {
            return [self retrieveCachedDataForPath:path];
        }
        
        //Otherwise retrieve it from the property list file
        NSDictionary *currentData = [NSDictionary dictionaryWithContentsOfFile:self.target];
        NSUInteger numberOfLayers = [[path componentsSeparatedByString:@"."] count];
    
        for(NSUInteger i = 0; i < numberOfLayers; i++) {
            NSString *pathComponentInCurrentLayer = [path componentsSeparatedByString:@"."][i];
        
            //If there's another layer...
            if([[currentData objectForKey:pathComponentInCurrentLayer] isKindOfClass: [NSDictionary class]]) {
                currentData = [currentData objectForKey:pathComponentInCurrentLayer];
            }
            //If it's the data we want, store it, then return it
            else {
                [self storeData:[currentData objectForKey:pathComponentInCurrentLayer] forPath:path];
                return [currentData objectForKey:pathComponentInCurrentLayer];
            }
        }
    }
    
    return nil;
}

@end
