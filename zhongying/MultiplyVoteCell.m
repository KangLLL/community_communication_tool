//
//  MutiplyVoteCell.m
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "MultiplyVoteCell.h"
#import "VoteOptionParameter.h"

#define OPTION_BUTTON_WIDTH     20
#define OPTION_BUTTON_HEIGHT    20
#define OPTION_LABEL_WIDTH      200
#define OPTION_LABEL_HEIGHT     20
#define OPTION_START_X          20
#define OPTION_START_Y          30
#define OPTION_X_SPACE          30
#define OPTION_Y_SPACE          20
#define BOTTOM_SPACE            35

#define TIPS_LABEL_WIDTH        150
#define TIPS_LABEL_HEIGHT       20
#define TIPS_LABEL_START_X      220

@interface MultiplyVoteCell()

- (void)changeSelection:(id)sender;

@end

@implementation MultiplyVoteCell

+ (float)getCellHeightAccordingToOptions:(int)count
{
    return OPTION_START_Y + (count - 1) * OPTION_Y_SPACE + BOTTOM_SPACE;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    optionButtons = [NSMutableArray array];
    optionLabels = [NSMutableArray array];
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1;
    
    titleTips = @"多选";
}

- (void)initWithInformation:(VoteParameter *)param withVoteTarget:(id)target andSelector:(SEL)selector
{
    for (UILabel *label in selectionLabels) {
        [label removeFromSuperview];
    }
    
    for(int i = 0; i < [param.options count]; i++){
        VoteOptionParameter *option = [param.options objectAtIndex:i];
        BOOL isSelected = [param.mySelection containsObject:option.optionId];
        
        if(i < [optionButtons count]){
            UILabel *label = [optionLabels objectAtIndex:i];
            label.text = option.optionName;
            
            UIButton *button = [optionButtons objectAtIndex:i];
            button.userInteractionEnabled = !param.isVoted;
            
            [button setSelected:isSelected];
        }
        else{
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(OPTION_START_X, OPTION_START_Y + i * OPTION_Y_SPACE, OPTION_BUTTON_WIDTH, OPTION_BUTTON_HEIGHT)];
            [button setBackgroundImage:self.selectImage forState:UIControlStateSelected];
            [button setBackgroundImage:self.unselectImage forState:UIControlStateNormal];
            button.userInteractionEnabled = !param.isVoted;
            [button addTarget:self action:@selector(changeSelection:) forControlEvents:UIControlEventTouchUpInside];
            [button setSelected:isSelected];
            
            [self.contentView addSubview:button];
            [optionButtons addObject:button];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(OPTION_START_X + OPTION_X_SPACE, OPTION_START_Y + i * OPTION_Y_SPACE, OPTION_LABEL_WIDTH, OPTION_LABEL_HEIGHT)];
            label.text = option.optionName;
            label.font = [UIFont systemFontOfSize:12];
            
            [self.contentView addSubview:label];
            [optionLabels addObject:label];
        }
        
        if(param.isVoted && isSelected){
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(TIPS_LABEL_START_X, OPTION_START_Y + i * OPTION_Y_SPACE, TIPS_LABEL_WIDTH, TIPS_LABEL_HEIGHT)];
            label.font = [UIFont systemFontOfSize:12];
            label.text = TIPS_TEXT;
            label.textColor = [UIColor orangeColor];
            [selectionLabels addObject:label];
            [self.contentView addSubview:label];
        }
    }
    
    for (int i = [optionButtons count] - 1; i >= [param.options count]; i--) {
        UIButton *button = [optionButtons objectAtIndex:i];
        [button removeFromSuperview];
        [optionButtons removeLastObject];
        
        UILabel *label = [optionLabels objectAtIndex:i];
        [label removeFromSuperview];
        [optionLabels removeLastObject];
    }
    
    if(labelSummaryTitle == nil){
        labelSummaryTitle = [[UILabel alloc] init];
        [self.contentView addSubview:labelSummaryTitle];
        labelSummary = [[UILabel alloc] init];
        [self.contentView addSubview:labelSummary];
        buttonVote = [[UIButton alloc] init];
        [self.contentView addSubview:buttonVote];
    }
    
    labelSummaryTitle.frame = CGRectMake(SUMMARY_TITLE_LABEL_X, OPTION_START_Y + [optionButtons count] * OPTION_Y_SPACE, SUMMARY_TITLE_LABEL_WIDTH, SUMMARY_TITLE_LABEL_HEIGHT);
    labelSummary.frame = CGRectMake(SUMMARY_LABEL_X, OPTION_START_Y + [optionButtons count] * OPTION_Y_SPACE, SUMMARY_LABEL_WIDTH, SUMMARY_LABEL_HEIGHT);
    buttonVote.frame = CGRectMake(VOTE_BUTTON_X, labelSummary.frame.origin.y - (VOTE_BUTTON_HEIGHT - SUMMARY_LABEL_HEIGHT) / 2, VOTE_BUTTON_WIDTH, VOTE_BUTTON_HEIGHT);
    
    [super initWithInformation:param withVoteTarget:target andSelector:selector];
}

- (IBAction)changeSelection:(id)sender
{
    UIButton *b = (UIButton *)sender;
    NSNumber *num = [NSNumber numberWithInt:[optionButtons indexOfObject:b]];
    VoteOptionParameter *selectParam = [voteParameter.options objectAtIndex:[num intValue]];
    
    [b setSelected:!b.selected];
    
    if([currentSelections containsObject:num]){
        [voteParameter.mySelection removeObject:selectParam.optionId];
        [currentSelections removeObject:num];
    }
    else{
        [voteParameter.mySelection addObject:selectParam.optionId];
        [currentSelections addObject:num];
    }
    
    if(self.delegate != nil){
        [self.delegate voteCellSelectionChange:voteParameter.voteId andSelection:voteParameter.mySelection];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
