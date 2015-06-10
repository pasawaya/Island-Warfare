//
//  PSChatMessage.h
//  PSIslandTerrainGenerator
//
//  Created by Philippe Sawaya on 9/26/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSChatMessage : NSObject

@property (nonatomic, strong)           NSString *sender;
@property (nonatomic, strong)           NSString *contents;
@property (nonatomic, strong, readonly) NSString *formattedContents;

@end
