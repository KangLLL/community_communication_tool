//
//  ExpandableTextView.m
//  hide
//
//  Created by lik on 14-4-5.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ExpandableTextView.h"

@implementation ExpandableTextView

@synthesize labelPlaceholder, heightConstraint;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
        //self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        //self.layer.borderWidth = 1.0f;
        initialHeight = self.frame.size.height;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
        //self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        //self.layer.borderWidth = 1.0f;
        initialHeight = self.frame.size.height;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textChanged:(NSNotification *)notification
{
    
    if([self.text length] == 0){
        self.labelPlaceholder.hidden = NO;
    }
    else{
        self.labelPlaceholder.hidden = YES;
    }
    
    CGSize sizeThatShouldFitTheContent = [self sizeThatFits:self.frame.size];
    if(sizeThatShouldFitTheContent.height > initialHeight){
        self.heightConstraint.constant = sizeThatShouldFitTheContent.height;
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.contentSize.height);
    }
    
}


- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textChanged:nil];
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
