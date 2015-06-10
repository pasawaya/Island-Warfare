//
//  PSChatTableViewCell.m
//  PSIslandTerrainGenerator
//
//  Created by Philippe Sawaya on 9/26/13.
//  Copyright (c) 2013 Philippe Sawaya. All rights reserved.
//

#import "PSChatTableViewCell.h"
#import "PSChatMessage.h"

@interface PSChatTableViewCell ()

@end

@implementation PSChatTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)ident {
    if (self = [super initWithStyle:style reuseIdentifier:ident]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    return self;
}

-(void)setMessage:(PSChatMessage *)message {
    _message = message;
    self.textLabel.text = message.formattedContents;
    self.textLabel.font = [UIFont fontWithName:kChatTableViewFontName size:kChatTableViewTextSize];
    self.textLabel.numberOfLines = 0;
}

@end
