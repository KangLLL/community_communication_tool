//
//  AliPayHelper.m
//  zhongying
//
//  Created by lk on 14-4-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AliPayHelper.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"
#import "AlixLibService.h"

#define APP_SCHEME              @"zhongying"
//#define CALLBACK_NOTIFY_URL     @"http://demo.deepinfo.cn/zy/mobile/index.php/Demand/notifyurl"
#define CALLBACK_NOTIFY_URL     @"http://www.100mlife.cn/app_interface/index.php/Demand/notifyurl"

static AliPayHelper *sigleton;

@implementation AliPayHelper

+ (AliPayHelper *)instance{
    if(sigleton == nil){
        sigleton = [[AliPayHelper alloc] init];
    }
    return sigleton;
}

- (void)setResultReceiver:(SEL)receiver
{
    currentResultReceiver = receiver;
}

- (void)payProduct:(NSString *)productName withTradeNo:(NSString *)tradeNo andPrice:(NSString *)price
{
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = tradeNo;
    order.productName = productName;
    order.productDescription = productName;
    order.amount = price;
    order.notifyURL =  CALLBACK_NOTIFY_URL;
    order.inputCharset = @"utf-8";
    NSString *orderInfo = [order description];
    NSLog(@"%@",orderInfo);
    
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedStr = [signer signString:orderInfo];
    
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
    
    [AlixLibService payOrder:orderString AndScheme:@"zhongying" seletor:currentResultReceiver target:self];
}

@end
