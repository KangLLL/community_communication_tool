//
//  VoteCell.h
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoteParameter.h"
#import "VoteCellDelegate.h"

#define TIPS_TEXT                       @"（我的选择）"
#define SUMMARY_TITLE_LABEL_X           9
#define SUMMARY_TITLE_LABEL_WIDTH       110
#define SUMMARY_TITLE_LABEL_HEIGHT      10
#define SUMMARY_LABEL_X                 107
#define SUMMARY_LABEL_WIDTH             126
#define SUMMARY_LABEL_HEIGHT            10
#define VOTE_BUTTON_X                   252
#define VOTE_BUTTON_WIDTH               51
#define VOTE_BUTTON_HEIGHT              15
#define SUMMARY_TEXT                    @"参与本主题投票人数"

@interface VoteCell : UITableViewCell{
    VoteParameter *voteParameter;
    NSMutableArray *selectionLabels;
    
    UILabel *labelSummaryTitle;
    UILabel *labelSummary;
    UIButton *buttonVote;
    
    NSString *titleTips;
}

@property (strong) IBOutlet UILabel *labelTitle;
@property (strong) IBOutlet UIImageView *imageNotVote;
@property (strong) IBOutlet UIImageView *imageVote;

@property (weak) id<VoteCellDelegate> delegate;

- (void)initWithInformation:(VoteParameter *)param withVoteTarget:(id)target andSelector:(SEL)selector;


@end
