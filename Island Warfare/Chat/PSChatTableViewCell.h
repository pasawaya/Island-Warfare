//
//  PSChatTableViewCell.h
//  PSIslandTerrainGenerator
//
//  Created by Philippe Sawaya on 9/26/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSChatMessage;

@interface PSChatTableViewCell : UITableViewCell

@property (nonatomic, strong) PSChatMessage *message;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)ident;

@end
