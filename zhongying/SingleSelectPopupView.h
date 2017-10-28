//
//  SelectPopupView.h
//  zhongying
//
//  Created by LI K on 8/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import "PopupView.h"

@interface SingleSelectPopupView : PopupView{
    NSMutableDictionary *options;
}

@property (strong) UIImage *selectImage;
@property (strong) UIImage *unselectImage;
@property (assign) CGRect imageFrame;
@property (assign) int selectIndex;

@end
