//
//  PaymentCenterViewController.h
//  zhongying
//
//  Created by lik on 14-3-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "SelectFoldableView.h"
#import "FoldableViewDataDelegate.h"
#import "FoldableViewDelegate.h"
#import "CommunicationDelegate.h"
#import "GetUtilitiesResponseParameter.h"
#import "GetParkingResponseParameter.h"
#import "GetExpressResponseParameter.h"
#import "EGORefreshTableHeaderView.h"
#import "PageDataManager.h"

typedef enum{
    paymentUtilities,
    paymentParking,
    paymentExpress
}PaymentFunction;

typedef enum{
    utilitiesAll,
    utilitiesFilterPayed,
    utilitiesFilterUnpayed
}UtilitiesFilterType;

@interface PaymentCenterViewController : ZhongYingBaseViewController<FoldableViewDataDelegate, FoldableViewDelegate, UITableViewDataSource, UITableViewDelegate, CommunicationDelegate, EGORefreshTableHeaderDelegate>{
    GetUtilitiesResponseParameter *currentUtilitiesResponse;
    GetParkingResponseParameter *currentParkingResponse;
    GetExpressResponseParameter *currentExpressResponse;
    
    NSMutableArray *utilitiesPayed;
    NSMutableArray *utilitiesUnpayed;
    NSArray *filterDescriptions;
    
    UtilitiesFilterType filterType;
    
    int currentSelectIndex;
    
    UITableView *tableOptions;
    
    EGORefreshTableHeaderView *refreshHeaderView;
    PageDataManager *utilitiesDataManager;
    PageDataManager *parkingDataManager;
    PageDataManager *expressDataManager;
    BOOL isReloading;
}

@property (assign) PaymentFunction currentFunction;

@property (strong) IBOutlet UIButton *buttonUtilities;
@property (strong) IBOutlet UIButton *buttonParking;
@property (strong) IBOutlet UIButton *buttonExpress;
@property (strong) IBOutlet UITableView *tableInformations;
@property (strong) IBOutlet UIButton *buttonFilter;
@property (strong) IBOutlet NSLayoutConstraint *tableTopMargin;
@property (strong) IBOutlet UIView *viewMask;
@property (strong) IBOutlet UIView *viewFitler;

@property (strong) IBOutlet SelectFoldableView *communitiesView;

- (IBAction)getMore:(id)sender;
- (IBAction)getUtilities:(id)sender;
- (IBAction)getParking:(id)sender;
- (IBAction)getExpress:(id)sender;

- (IBAction)getUtilitiesDetail:(id)sender;
- (IBAction)getParkingDetail:(id)sender;
- (IBAction)filterUtilities:(id)sender;
@end
