//
//  ShopMapViewController.h
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "BMapKit.h"

@interface ShopMapViewController : ZhongYingBaseViewController

@property (strong) IBOutlet UILabel *labelName;
@property (strong) IBOutlet BMKMapView *mapView;

@property (strong) NSString *shopName;
@property (assign) float longitude;
@property (assign) float latitude;
 
@end
