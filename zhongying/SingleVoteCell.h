//
//  SingleVoteCell.h
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "VoteCell.h"

@interface SingleVoteCell : VoteCell{
    NSMutableArray *optionButtons;
    NSMutableArray *optionLabels;
    int currentSelection;
}

@property (strong) UIImage *selectImage;
@property (strong) UIImage *unselectImage;

+ (float)getCellHeightAccordingToOptions:(int)count;

@end
