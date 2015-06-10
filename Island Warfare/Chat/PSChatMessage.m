//
//  PSChatMessage.m
//  PSIslandTerrainGenerator
//
//  Created by Philippe Sawaya on 9/26/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSChatMessage.h"

@implementation PSChatMessage

-(NSString *)formattedContents {
    return [NSString stringWithFormat:@"%@:\n%@", self.sender, self.contents];
}

@end
