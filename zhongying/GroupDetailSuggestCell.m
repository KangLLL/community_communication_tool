//
//  GroupDetailSuggestCell.m
//  zhongying
//
//  Created by lk on 14-4-20.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GroupDetailSuggestCell.h"
#import "GroupSuggestionParameter.h"

@implementation GroupDetailSuggestCell

@synthesize labelName1, labelName2, labelName3, labelPrice1, labelPrice2, labelPrice3, view2, view3, imagePhoto1, imagePhoto2, imagePhoto3;

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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSuggestions:(NSArray *)suggestions withCacher:(DownloadCacher *)cacher
{
    NSMutableArray *temp = [NSMutableArray array];
    
    GroupSuggestionParameter *param = [suggestions objectAtIndex:0];
    [cacher getImageWithUrl:param.imageUrl andCell:self inImageView:self.imagePhoto1 withActivityView:self.activityView1];
    self.labelPrice1.text = [NSString stringWithFormat:@"%.2f",param.price];
    self.labelName1.text = param.productName;
    [temp addObject:param.groupId];
    if([suggestions count] == 1){
        self.view2.hidden = YES;
        self.view3.hidden = YES;
    }
    else{
        self.view2.hidden = NO;
        param = [suggestions objectAtIndex:1];
        [cacher getImageWithUrl:param.imageUrl andCell:self inImageView:self.imagePhoto2 withActivityView:self.activityView2];
        self.labelPrice2.text = [NSString stringWithFormat:@"%.2f",param.price];
        self.labelName2.text = param.productName;
        [temp addObject:param.groupId];
        if([suggestions count] == 2){
            self.view3.hidden = YES;
        }
        else{
            self.view3.hidden = NO;
            param = [suggestions objectAtIndex:2];
            [cacher getImageWithUrl:param.imageUrl andCell:self inImageView:self.imagePhoto3 withActivityView:self.activityView3];
            self.labelPrice3.text = [NSString stringWithFormat:@"%.2f",param.price];
            self.labelName3.text = param.productName;
            [temp addObject:param.groupId];
        }
    }
    
    arraySuggestions = temp;
}

- (NSString *)getSuggestionGroupId:(int)index
{
    return [arraySuggestions objectAtIndex:index];
}

@end
