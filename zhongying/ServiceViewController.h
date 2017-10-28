//
//  SecondViewController.h
//  zhongying
//
//  Created by lik on 14-3-18.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhongYingBaseViewController.h"

@interface ServiceViewController : ZhongYingBaseViewController{
    BOOL isGroup;
}

- (IBAction)shop:(id)sender;
- (IBAction)group:(id)sender;
- (IBAction)reserve:(id)sender;
- (IBAction)rent:(id)sender;
- (IBAction)complement:(id)sender;
- (IBAction)discount:(id)sender;
- (IBAction)channel:(id)sender;

@end
