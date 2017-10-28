//
//  ProductDetailViewController.h
//  zhongying
//
//  Created by lk on 14-4-20.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "GroupDetailResponseParameter.h"

typedef enum{
    productWeb,
    productParameter
}ProductDetailType;

@interface ProductDetailViewController : ZhongYingBaseViewController<UIWebViewDelegate>{
    ProductDetailType currentType;
}

@property (strong) IBOutlet UIWebView *webView;
@property (strong) IBOutlet UIView *viewParameter;
@property (strong) IBOutlet UIButton *buttonWeb;
@property (strong) IBOutlet UIButton *buttonParameter;

@property (strong) NSString *productId;
@property (strong) NSString *productDetailUrl;

- (IBAction)displayWeb:(id)sender;
- (IBAction)displayParameter:(id)sender;

@end
