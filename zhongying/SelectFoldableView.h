//
//  SelectFoldableView.h
//  zhongying
//
//  Created by lik on 14-3-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "FoldableView.h"

@interface SelectFoldableView : FoldableView{
    int selectIndex;
    NSMutableDictionary *buttons;
}

@property (strong) UIImage *unselectItemImage;
@property (strong) UIImage *selectItemImage;

- (int)getSelectIndex;
- (void)setSelectIndex:(int)index;

@end
