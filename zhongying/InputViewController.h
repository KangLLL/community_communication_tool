//
//  InputViewController.h
//  zhongying
//
//  Created by LI K on 17/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"

@interface InputViewController : ZhongYingBaseViewController<UITextFieldDelegate>{
    NSMutableArray *textFields;
    float keyboardHeight;
}

- (void)registerTextField:(UIView *)textField;
- (void)inputFinish;
- (void)resignFocus;

- (void)keyboardWillShow;
- (void)keyboardWillHide;

@end
