//
//  NewsDetailViewController.h
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "NewsParameter.h"

@interface NewsDetailViewController : ZhongYingBaseViewController

@property (strong) IBOutlet UILabel *labelTitle;
@property (strong) IBOutlet UILabel *labelTime;
@property (strong) IBOutlet UILabel *labelAuthor;
@property (strong) IBOutlet UIWebView *webContent;

@property (strong) NewsParameter *news;

@end
