//
//  PSChatViewController.m
//  Island Warfare
//
//  Created by Philippe Sawaya on 5/31/15.
//  Copyright (c) 2015 Philippe Sawaya. All rights reserved.
//

#import "PSChatViewController.h"
#import "PSChatMessage.h"
#import "PSChatTableViewCell.h"

@interface PSChatViewController ()

@property (nonatomic, strong) NSMutableArray *currentMessages;
@property (nonatomic, strong) UITableView    *messagesTableView;

@end

@implementation PSChatViewController

#pragma mark -
#pragma mark Initialization
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.opacity = kChatTableViewOpacity;
    self.currentMessages = [[NSMutableArray alloc] init];
    
    [self loadSampleMessages];
    
    CGRect tableFrame = CGRectMake(0, 0, kScreenWidth-kToolbarWidth, kScreenHeight);
    self.messagesTableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    self.messagesTableView.dataSource = self;
    self.messagesTableView.delegate = self;
    self.messagesTableView.scrollEnabled = YES;
    self.messagesTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.messagesTableView.showsVerticalScrollIndicator = NO;
    self.messagesTableView.showsHorizontalScrollIndicator = NO;
    [self.messagesTableView registerClass:[PSChatTableViewCell class] forCellReuseIdentifier:kChatCellReuseIdentifier];
    
    [self.view addSubview:self.messagesTableView];
}

#warning For testing purposes only
-(void)loadSampleMessages {
    for(NSUInteger index = 0; index < 30; index++) {
        PSChatMessage *currentMessage = [[PSChatMessage alloc] init];
        currentMessage.contents = [NSString stringWithFormat:@"I need %d archers immediately. Someone fill my req.", arc4random_uniform(40)];
        
        int rand = arc4random_uniform(4);
        if((rand % 4) == 0)      currentMessage.sender = @"Me";
        else if((rand % 4) == 1) currentMessage.sender = @"StonelyOrphan";
        else if((rand % 4) == 2) currentMessage.sender = @"BallisticFish24";
        else                     currentMessage.sender = @"FootStrongish06";
        [self.currentMessages addObject:currentMessage];
    }
}

#pragma mark -
#pragma mark UITableView Data Source
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PSChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kChatCellReuseIdentifier];
    
    if(!cell) {
        cell = [[PSChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kChatCellReuseIdentifier];
    }
    
    cell.message = self.currentMessages[indexPath.row];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentMessages.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark -
#pragma mark UITableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [self.currentMessages[indexPath.row] formattedContents];
    CGSize textSize = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:10.0f], NSParagraphStyleAttributeName: [NSParagraphStyle defaultParagraphStyle]}];
    return textSize.height + kChatTableViewCellPadding;
}

#pragma mark - 
#pragma mark Clean-up
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
