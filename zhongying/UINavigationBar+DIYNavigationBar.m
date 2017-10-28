//
//  UINavigationBar+DIYNavigationBar.m
//  zhongying
//
//  Created by lik on 14-3-26.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "UINavigationBar+DIYNavigationBar.h"

@implementation UINavigationBar (DIYNavigationBar)


-(CGSize)sizeThatFits:(CGSize)size{
    
    CGSize newSize = CGSizeMake(self.frame.size.width, 27);
    return newSize;
}


@end
