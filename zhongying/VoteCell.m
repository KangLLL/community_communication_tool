//
//  VoteCell.m
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "VoteCell.h"

#define PEOPLE_STRING_FORMAT        @"[%d]人"
#define VOTE_BUTTON_TITLE           @"投票"
#define Y_DISTANCE                  10

@implementation VoteCell

@synthesize labelTitle, imageNotVote, imageVote;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    selectionLabels = [NSMutableArray array];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithInformation:(VoteParameter *)param withVoteTarget:(id)target andSelector:(SEL)selector
{
    voteParameter = param;
    self.labelTitle.text = [NSString stringWithFormat:@"%@(%@)",voteParameter.voteName,titleTips];
    
    NSString *plainText = [NSString stringWithFormat:PEOPLE_STRING_FORMAT,voteParameter.peopleCount];
    NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
    NSRange range = [plainText rangeOfString:[NSString stringWithFormat:@"[%d]",voteParameter.peopleCount]];
    [styledText setAttributes:attributes range:range];
    labelSummary.attributedText = styledText;
    labelSummaryTitle.text = SUMMARY_TEXT;
    
    labelSummaryTitle.font = [UIFont systemFontOfSize:10];
    labelSummary.font = [UIFont systemFontOfSize:10];
    
    self.imageNotVote.hidden = voteParameter.isVoted;
    self.imageVote.hidden = !voteParameter.isVoted;
    buttonVote.hidden = voteParameter.isVoted;
    [buttonVote setTitle:VOTE_BUTTON_TITLE forState:UIControlStateNormal];
    buttonVote.titleLabel.font = [UIFont systemFontOfSize:10];
    buttonVote.titleLabel.textColor = [UIColor blackColor];
    buttonVote.backgroundColor = [UIColor brownColor];
    [buttonVote addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}
@end
