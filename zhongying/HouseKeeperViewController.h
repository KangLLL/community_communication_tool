//
//  HouseKeeperViewController.h
//  zhongying
//
//  Created by lik on 14-3-18.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhongYingBaseViewController.h"
#import "PaymentCenterViewController.h"
#import "ComplaintRepairViewController.h"

@interface HouseKeeperViewController : ZhongYingBaseViewController{
    PaymentFunction paymentFunction;
    ComplaintFunction complaintFunction;
}

- (IBAction)communityEWM:(id)sender;
- (IBAction)utilities:(id)sender;
- (IBAction)neighbour:(id)sender;
- (IBAction)parking:(id)sender;
- (IBAction)express:(id)sender;
- (IBAction)travel:(id)sender;
- (IBAction)hobby:(id)sender;
- (IBAction)news:(id)sender;
- (IBAction)complaint:(id)sender;
- (IBAction)repair:(id)sender;
- (IBAction)vote:(id)sender;

@end
