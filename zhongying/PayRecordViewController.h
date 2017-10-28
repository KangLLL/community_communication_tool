//
//  PayRecordViewController.h
//  zhongying
//
//  Created by lk on 14-4-15.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "GetMyUtilitiesResponseParameter.h"
#import "GetMyParkingResponseParameter.h"
#import "EGORefreshTableHeaderView.h"
#import "PageDataManager.h"

typedef enum{
    recordProperty,
    recordParking
}RecordType;


@interface PayRecordViewController : ZhongYingBaseViewController<UITableViewDataSource, UITableViewDelegate, CommunicationDelegate, EGORefreshTableHeaderDelegate>{
    RecordType currentType;
    GetMyUtilitiesResponseParameter *propertyResponse;
    GetMyParkingResponseParameter *parkingResponse;
    
    EGORefreshTableHeaderView *refreshHeaderView;
    PageDataManager *utilitiesDataManager;
    PageDataManager *parkingDataManager;
    BOOL isReloading;
}

@property (strong) IBOutlet UIButton *buttonProperty;
@property (strong) IBOutlet UIButton *buttonParking;
@property (strong) IBOutlet UIView *viewPropertyHead;
@property (strong) IBOutlet UIView *viewParkingHead;
@property (strong) IBOutlet UITableView *tableInformation;

- (IBAction)getProperty:(id)sender;
- (IBAction)getParking:(id)sender;

@end
