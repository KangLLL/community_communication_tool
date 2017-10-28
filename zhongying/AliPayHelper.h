//
//  AliPayHelper.h
//  zhongying
//
//  Created by lk on 14-4-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AliPayHelper : NSObject{
    SEL currentResultReceiver;
}

+ (AliPayHelper *)instance;
- (void)setResultReceiver:(SEL)receiver;
- (void)payProduct:(NSString *)productName withTradeNo:(NSString *)tradeNo andPrice:(NSString *)price;

@end
