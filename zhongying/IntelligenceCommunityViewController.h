//
//  IntelligenceCommunityViewController.h
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhongYingBaseViewController.h"
#import "CommunicationDelegate.h"
#import "GetUtilitiesResponseParameter.h"
#import "GetParkingResponseParameter.h"
#import "GetExpressResponseParameter.h"
#import "MyCommunityParameter.h"

typedef enum{
    communityUtilities,
    communityParking,
    communityExpress
}CommunityFunction;


@interface IntelligenceCommunityViewController : ZhongYingBaseViewController<UITableViewDataSource, CommunicationDelegate>{
    GetUtilitiesResponseParameter *currentUtilitiesResponse;
    GetParkingResponseParameter *currentParkingResponse;
    GetExpressResponseParameter *currentExpressResponse;
    MyCommunityParameter *currentCommunity;
}

@property (assign) CommunityFunction currentFunction;

@property (strong) IBOutlet UIButton *buttonUtilities;
@property (strong) IBOutlet UIButton *butonParking;
@property (strong) IBOutlet UIButton *buttonExpress;
@property (strong) IBOutlet UILabel *labelTitle;
@property (strong) IBOutlet UITableView *tableInformations;

- (IBAction)getUtilities:(id)sender;
- (IBAction)getParking:(id)sender;
- (IBAction)getExpress:(id)sender;

@end
