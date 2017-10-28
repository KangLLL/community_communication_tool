//
//  RentViewController.h
//  zhongying
//
//  Created by lk on 14-4-16.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "GetRentResponseParameter.h"
#import "GetMyRentResponseParameter.h"
#import "AddRentViewController.h"
#import "MyHouseParameter.h"
#import "EGORefreshTableHeaderView.h"
#import "PageDataManager.h"

typedef enum{
    rentInformation,
    myRentInformation
}RentInfomationType;


@interface RentViewController : ZhongYingBaseViewController<UITableViewDataSource, UITableViewDelegate, CommunicationDelegate, EGORefreshTableHeaderDelegate>{
    RentInfomationType currentType;
    GetRentResponseParameter *rentResponse;
    GetMyRentResponseParameter *myRentResponse;
    
    MyHouseParameter *currentSelectRent;
    HouseParameter *currentHouse;
    //NSArray *rentTypeDescriptions;
    
    EGORefreshTableHeaderView *refreshHeaderView;
    PageDataManager *rentDataManager;
    PageDataManager *myRentDataManager;
    BOOL isReloading;
}

@property (strong) IBOutlet UIButton *buttonRent;
@property (strong) IBOutlet UIButton *buttonMyRent;
@property (strong) IBOutlet UIView *viewRentHead;
@property (strong) IBOutlet UIView *viewMyRentHead;
@property (strong) IBOutlet UITableView *tableInformation;

@property (strong) IBOutlet UIButton *buttonAdd;
@property (strong) IBOutlet NSLayoutConstraint *bottomConstraint;

- (IBAction)getRent:(id)sender;
- (IBAction)getMyRent:(id)sender;

- (IBAction)addRent:(id)sender;
- (IBAction)editRent:(id)sender;
- (IBAction)deleteRent:(id)sender;

@end
