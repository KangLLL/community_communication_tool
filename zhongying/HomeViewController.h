//
//  FirstViewController.h
//  zhongying
//
//  Created by lik on 14-3-18.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "AdvertisementView.h"

@interface HomeViewController : ZhongYingBaseViewController<UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate, CommunicationDelegate>{
    UITableView *tableCommunities;
    
    BOOL isToExpress;
    BOOL isToGroup;
    
    NSString *currentAdvertisementCommunityId;
}

@property (strong) IBOutlet UILabel *labelName;
@property (strong) IBOutlet UIButton *buttonCommunity;
@property (strong) IBOutlet UILabel *labelCity;
@property (strong) IBOutlet UILabel *labelCommunity;
@property (strong) IBOutlet UIView *viewMask;
@property (strong) IBOutlet UIScrollView *scrollContent;

@property (strong) IBOutlet UIButton *buttonLogin;
@property (strong) IBOutlet UIButton *buttonRegister;

@property (strong) IBOutlet AdvertisementView *advertisementView;

@property (strong) NSString *performSegueIdentifier;

//- (IBAction)query:(id)sender;
- (IBAction)complaint:(id)sender;
- (IBAction)payment:(id)sender;
- (IBAction)vote:(id)sender;
- (IBAction)hobby:(id)sender;
- (IBAction)notification:(id)sender;
- (IBAction)neighbour:(id)sender;
- (IBAction)shop:(id)sender;
- (IBAction)news:(id)sender;
- (IBAction)communityEWM:(id)sender;
- (IBAction)express:(id)sender;
- (IBAction)reserve:(id)sender;
- (IBAction)group:(id)sender;

- (IBAction)login:(id)sender;
- (IBAction)registerUser:(id)sender;
- (IBAction)selectCommunity:(id)sender;

@end
