//
//  ExpandableTextView.h
//  hide
//
//  Created by lik on 14-4-5.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandableTextView : UITextView{
    float initialHeight;
}

@property (strong) IBOutlet UILabel *labelPlaceholder;
@property (strong) IBOutlet NSLayoutConstraint *heightConstraint;


- (void)textChanged:(NSNotification*)notification;

@end
