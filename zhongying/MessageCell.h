//
//  MessageCell.h
//  zhongying
//
//  Created by lik on 14-4-11.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell{
    UILabel *labelContent;
    float totalHeight;
}

@property (strong) IBOutlet UILabel *labelTime;
@property (strong) IBOutlet UILabel *labelName;

- (void)setContent:(NSString *)content;
- (float)getCellHeight;

@end
