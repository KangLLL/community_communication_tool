//
//  ZhiFuBaoWebViewController.h
//  zhongying
//
//  Created by lk on 14-4-17.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"

@interface ZhiFuBaoWebViewController : ZhongYingBaseViewController<UIWebViewDelegate>

@property (strong) IBOutlet UIWebView *webView;

@property (strong) NSString *url;
@property (assign) BOOL isPaySuccess;

@end
