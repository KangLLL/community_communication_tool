//
//  AddOrderViewController.h
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "AddOrderResponseParameter.h"
#import "CommonEnum.h"
#import "CommunicationManager.h"
#import "ZhiFuBaoWebViewController.h"

@interface AddOrderViewController : ZhongYingBaseViewController<CommunicationDelegate>{
    ZhiFuBaoWebViewController *payWeb;
    NSString *payUrl;
}

@property (strong) IBOutlet UILabel *labelSn;
@property (strong) IBOutlet UILabel *labelPayType;
@property (strong) IBOutlet UILabel *labelOrderPrice;

@property (strong) AddOrderResponseParameter *currentResponse;
@property (assign) PayType payType;
@property (strong) NSString *payName;
@property (strong) NSString *orderPrice;
@property (strong) NSString *productName;

- (IBAction)payOrder:(id)sender;
- (IBAction)checkOrder:(id)sender;

@end
