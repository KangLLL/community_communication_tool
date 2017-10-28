//
//  UIUnderlinedButton.m
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "UIUnderlinedButton.h"

@implementation UIUnderlinedButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *plainText = self.titleLabel.text;
        NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
        
        NSDictionary *attributes = @{NSUnderlineStyleAttributeName : [NSNumber numberWithInt:1]};
        NSRange range = [plainText rangeOfString:plainText];
        [styledText setAttributes:attributes range:range];
        
        self.titleLabel.attributedText = styledText;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSString *plainText = self.titleLabel.text;
        NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
        
        NSDictionary *attributes = @{NSUnderlineStyleAttributeName : [NSNumber numberWithInt:1]};
        NSRange range = [plainText rangeOfString:plainText];
        [styledText setAttributes:attributes range:range];
        
        self.titleLabel.attributedText = styledText;
    }
    return self;
}


- (id)init
{
    self = [super init];
    if (self) {
        NSString *plainText = self.titleLabel.text;
        NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
        
        NSDictionary *attributes = @{NSUnderlineStyleAttributeName : [NSNumber numberWithInt:1]};
        NSRange range = [plainText rangeOfString:plainText];
        [styledText setAttributes:attributes range:range];
        
        self.titleLabel.attributedText = styledText;
    }
    return self;
}

@end
