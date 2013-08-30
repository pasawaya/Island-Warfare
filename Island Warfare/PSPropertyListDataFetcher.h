//
//  PSPropertyListDataFetcher.h
//  PSIslandTerrainGenerator
//
//  Created by Philippe Sawaya on 8/26/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSPropertyListDataFetcher : NSObject

+(instancetype)sharedDataFetcherWithTarget: (NSString *)target;

-(NSString *)elementWithPath: (NSString *)path;

@end

