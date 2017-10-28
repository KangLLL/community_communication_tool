//
//  FirstViewController.m
//  zhongying
//
//  Created by lik on 14-3-18.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "HomeViewController.h"
#import "UserInformation.h"
#import "MyCommunityParameter.h"
#import "IntelligenceCommunityViewController.h"
#import "GetCommunityRequestParameter.h"
#import "GetRoomRequestParameter.h"
#import "PaymentCenterViewController.h"
#import "ComplaintRepairViewController.h"
#import "AddComplaintRequestParameter.h"
#import "OptionCell.h"
#import "CommonConsts.h"
#import "CommonUtilities.h"
#import "LoginViewController.h"
#import "GetMyCommunitiesRequestParameter.h"
#import "GroupViewController.h"
#import "GetAdvertisementsRequestParameter.h"
#import "GetAdvertisementsResponseParameter.h"
#import "AdvertisementParameter.h"
#import "RegisterViewController.h"

#define WELCOME_TITLE                   @"欢迎你！"

@interface HomeViewController ()

- (void)constructSelectionTable;
- (void)toSegue:(NSString *)segueIdentifier;

- (void)sendGetAdvertisementsRequest;
- (NSArray *)constructAdvertisementResponse;

@end

@implementation HomeViewController

@synthesize labelCity, labelName, buttonCommunity, scrollContent, viewMask, performSegueIdentifier, buttonLogin, buttonRegister, advertisementView;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    if(self.performSegueIdentifier != nil){
        [self performSegueWithIdentifier:self.performSegueIdentifier sender:nil];
        self.performSegueIdentifier = nil;
    }
    else{
        if([UserInformation instance].userId != nil){
            self.labelName.hidden = NO;
            self.labelName.text = [NSString stringWithFormat:@"%@%@",WELCOME_TITLE,[UserInformation instance].name];
            self.buttonLogin.hidden = YES;
            self.buttonRegister.hidden = YES;
         }
        else{
            self.labelName.hidden = YES;
            self.buttonLogin.hidden = NO;
            self.buttonRegister.hidden = NO;
        }
        
        if([UserInformation instance].currentCommunityIndex >=0 ){
            self.buttonCommunity.hidden = NO;
            self.labelCommunity.hidden = NO;
            CommunityInformation *currentCommunity = [[UserInformation instance] currentCommunity];
            self.labelCity.text = currentCommunity.city;
            self.labelCommunity.text = currentCommunity.communityName;
        }
        else{
            self.buttonCommunity.hidden = YES;
            self.labelCity.hidden = YES;
            self.labelCommunity.hidden = YES;
        }
    }
    
    self.scrollContent.contentOffset = CGPointZero;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.delegate = self;
    
    if([UserInformation instance].userId != nil){
        if([UserInformation instance].communities == nil){
            GetMyCommunitiesRequestParameter *request = [[GetMyCommunitiesRequestParameter alloc] init];
            
            request.userId = [UserInformation instance].userId;
            request.password = [UserInformation instance].password;
            request.isUserCenter = YES;
            
            [[CommunicationManager instance] getMyCommunities:request withDelegate:self];
            [[CommonUtilities instance] showNetworkConnecting:self];
        }
        else{
            [self sendGetAdvertisementsRequest];
        }
    }
    else{
        [self.advertisementView displayAdvertiseWithImages:[self constructAdvertisementResponse]];
        currentAdvertisementCommunityId = nil;
    }
    
    //self.scrollContent.contentOffset = testPoint;
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.tabBarController.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions
/*
- (IBAction)query:(id)sender
{
  
    GetCommunityRequestParameter *request = [[GetCommunityRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.provinceId = @"32";
    request.cityId = @"394";
    request.districtId = @"3330";
  
    
    GetRoomRequestParameter *request = [[GetRoomRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.communityId = @"57";
    
    //[[CommunicationManager instance] getAllCommunities:request withDelegate:nil];
    [[CommunicationManager instance] getAllRooms:request withDelegate:nil];
    
    //[self performSegueWithIdentifier:QUERY_SEGUE_IDENTIFIER sender:self];
}
*/

- (IBAction)payment:(id)sender
{
    isToExpress = NO;
    [self toSegue:HOME_PAYMENT_SEGUE_IDENTIFIER];
}

- (IBAction)complaint:(id)sender
{
    [self toSegue:HOME_COMPLAINT_SEGUE_IDENTIFIER];
}

- (IBAction)vote:(id)sender
{
    [self toSegue:HOME_VOTE_SEGUE_IDENTIFIER];
}

- (IBAction)hobby:(id)sender
{
    [self toSegue:HOME_HOBBY_SEGUE_IDENTIFIER];
}

- (IBAction)reserve:(id)sender
{
    isToGroup = NO;
    [self toSegue:HOME_RESERVE_SEGUE_IDENTIFIER];
}

- (IBAction)notification:(id)sender
{
    [self toSegue:HOME_NOTIFICATION_SEGUE_IDENTIFIER];
}

- (IBAction)neighbour:(id)sender
{
    [self toSegue:HOME_NEIGHBOUR_SEGUE_IDENTIFIER];
}

- (IBAction)shop:(id)sender
{
    [self toSegue:HOME_SHOP_SEGUE_IDENTIFIER];
}

- (IBAction)news:(id)sender
{
    [self toSegue:HOME_NEWS_SEGUE_IDENTIFIER];
}

- (IBAction)express:(id)sender
{
    isToExpress = YES;
    [self toSegue:HOME_PAYMENT_SEGUE_IDENTIFIER];
}

- (IBAction)group:(id)sender
{
    isToGroup = YES;
    [self toSegue:HOME_RESERVE_SEGUE_IDENTIFIER];
}

- (IBAction)communityEWM:(id)sender
{
    [self showErrorMessage:FUNCTION_NOT_AVAILABEL_TIPS];
}

- (IBAction)selectCommunity:(id)sender
{
    if(tableCommunities == nil){
        [self constructSelectionTable];
    }
    [tableCommunities reloadData];
    tableCommunities.hidden = NO;
    self.viewMask.hidden = NO;
    
    float totalHeight = tableCommunities.contentSize.height;
    float maxHeight = self.view.bounds.size.height - 2 * MIN_SELECTION_MARGIN;
    
    CGRect newFrame = tableCommunities.frame;
    newFrame.size.height = MIN(totalHeight, maxHeight);
    tableCommunities.frame = newFrame;
    tableCommunities.center = self.view.center;
}

- (IBAction)login:(id)sender
{
    [self performSegueWithIdentifier:HOME_LOGIN_SEGUE_IDENTIFIER sender:nil];
}

- (IBAction)registerUser:(id)sender
{
    [self performSegueWithIdentifier:HOME_REGISTER_SEGUE_IDENTIFIER sender:nil];
}

#pragma mark - Private Methods

- (void)constructSelectionTable
{
    tableCommunities = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, 300, 0)];
    [tableCommunities registerClass:[OptionCell class] forCellReuseIdentifier:OPTION_CELL_REUSE_IDENTIFIER];
    tableCommunities.dataSource = self;
    tableCommunities.delegate = self;
    tableCommunities.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableCommunities];
}


- (void)toSegue:(NSString *)segueIdentifier
{
    self.hidesBottomBarWhenPushed = YES;
    if([UserInformation instance].name == nil){
        [[CommonUtilities instance] showGlobeMessage:LOG_IN_TIPS];
        [self performSegueWithIdentifier:HOME_LOGIN_SEGUE_IDENTIFIER sender:nil];
    }
    else if([UserInformation instance].communities == nil){
        [[CommonUtilities instance] showGlobeMessage:BIND_COMMUNITY_TIPS];
        [self performSegueWithIdentifier:HOME_COMMUNITY_SEGUE_IDENTIFIER sender:nil];
    }
    else{
        [self performSegueWithIdentifier:segueIdentifier sender:nil];
    }
    self.hidesBottomBarWhenPushed = NO;
}

- (void)sendGetAdvertisementsRequest
{
    if(currentAdvertisementCommunityId == nil ||
       ([currentAdvertisementCommunityId length] == 0 && [UserInformation instance].communities != nil) ||
       ([UserInformation instance].communities != nil && ![[[UserInformation instance] currentCommunity].communityId isEqualToString:currentAdvertisementCommunityId])){
           GetAdvertisementsRequestParameter *request = [[GetAdvertisementsRequestParameter alloc] init];
           request.userId = [UserInformation instance].userId;
           request.password = [UserInformation instance].password;
           if([UserInformation instance].communities != nil && [UserInformation instance].currentCommunityIndex >= 0){
               request.communityId = [[UserInformation instance] currentCommunity].communityId;
               currentAdvertisementCommunityId = request.communityId;
           }
           else{
               currentAdvertisementCommunityId = @"";
           }
           
           [[CommunicationManager instance] getAdvertisement:request withDelegate:self];
           [[CommonUtilities instance] showNetworkConnecting:self];
       }
}

- (NSArray *)constructAdvertisementResponse
{
    UIImage *ad1 = [UIImage imageNamed:@"a_1"];
    UIImage *ad2 = [UIImage imageNamed:@"a_2"];
    UIImage *ad3 = [UIImage imageNamed:@"a_3"];
    
    return [NSArray arrayWithObjects:ad1, ad2, ad3, nil];
}

#pragma mark - Communication Delegate
- (void)ProcessServerResponse:(id)response
{
    [[CommonUtilities instance] hideNetworkConnecting];
    if([response isKindOfClass:[GetMyCommunitiesResponseParameter class]]){
        GetMyCommunitiesResponseParameter *param = response;
            
        [[UserInformation instance] initialCommunities:response];
        if([param.communities count] > 0){
            [UserInformation instance].currentCommunityIndex = 0;
            self.buttonCommunity.hidden = NO;
            self.labelCommunity.hidden = NO;
            CommunityInformation *currentCommunity = [[UserInformation instance] currentCommunity];
            self.labelCity.text = currentCommunity.city;
            self.labelCommunity.text = currentCommunity.communityName;
        }
        else{
            [UserInformation instance].currentCommunityIndex = -1;
        }
        
        [self sendGetAdvertisementsRequest];
    }
    else{
        GetAdvertisementsResponseParameter *param = response;
        [self.advertisementView displayAdvertiseWithAdvertisementResponse:param];
    }
}

- (void)ProcessServerFail:(ServerFailInformation *)failInfo
{
    [[CommonUtilities instance] hideNetworkConnecting];
    NSLog(@"%@",failInfo.message);
    [self showErrorMessage:failInfo.message];
    /*
    GetAdvertisementsResponseParameter *temp = [GetAdvertisementsResponseParameter alloc];
    AdvertisementParameter *param1 = [AdvertisementParameter alloc];
    param1.imageUrl = @"http://img3.cache.netease.com/photo/0005/2014-05-06/9RJIJ07D5MMC0005.jpg";
    param1.advertisementUrl = @"http://www.163.com";
    AdvertisementParameter *param2 = [AdvertisementParameter alloc];
    param2.imageUrl = @"http://img4.cache.netease.com/photo/0005/2014-05-06/9RJIJ0T85MMC0005.jpg";
    param2.advertisementUrl = @"http://www.163.com";
    
    temp.advertisements = [NSArray arrayWithObjects:param1,param2,nil];
    [self.advertisementView displayAdvertiseWithAdvertisementResponse:temp];
     */
    [self.advertisementView displayAdvertiseWithImages:[self constructAdvertisementResponse]];
    currentAdvertisementCommunityId = nil;
    
}

- (void)ProcessCommunicationError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
    NSLog(@"%@",error.localizedDescription);
    [self showErrorMessage:error.localizedDescription];
    [self.advertisementView displayAdvertiseWithImages:[self constructAdvertisementResponse]];
    currentAdvertisementCommunityId = nil;
}

#pragma mark - Tab Bar Controller Delegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if(viewController != self.navigationController){
        tableCommunities.hidden = YES;
        self.viewMask.hidden = YES;
       
    }
}

#pragma mark - Table Delegate

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[UserInformation instance].communities count];
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionCell *cell = [tableView dequeueReusableCellWithIdentifier:OPTION_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    [cell setOptionString:[[UserInformation instance] getCommunity:indexPath.row].communityName];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableCommunities.bounds.size.width, 44)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 44)];
    label.text = @"    请选择小区";
    view.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UserInformation instance].currentCommunityIndex = indexPath.row;
    tableCommunities.hidden = YES;
    self.viewMask.hidden = YES;
    self.labelCommunity.text = [[UserInformation instance] currentCommunity].communityName;
    self.labelCity.text = [[UserInformation instance] currentCommunity].city;
    
    [self sendGetAdvertisementsRequest];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ((UIViewController *)segue.destinationViewController).hidesBottomBarWhenPushed = YES;
    
    if([segue.destinationViewController isKindOfClass:[IntelligenceCommunityViewController class]]){
        IntelligenceCommunityViewController *destination = (IntelligenceCommunityViewController *)segue.destinationViewController;
        destination.currentFunction = communityParking;
    }
    else if([segue.destinationViewController isKindOfClass:[PaymentCenterViewController class]]){
        PaymentCenterViewController *destination = (PaymentCenterViewController *)segue.destinationViewController;
        if(isToExpress){
            destination.currentFunction = paymentExpress;
        }
        else{
            destination.currentFunction = paymentUtilities;
        }
    }
    else if([segue.destinationViewController isKindOfClass:[ComplaintRepairViewController class]]){
        ComplaintRepairViewController *destination = (ComplaintRepairViewController *)segue.destinationViewController;
        destination.currentFunction = complaintRepair;
    }
    else if([segue.destinationViewController isKindOfClass:[LoginViewController class]]){
        LoginViewController *controller = (LoginViewController *)segue.destinationViewController;
        controller.backController = self;
    }
    else if([segue.destinationViewController isKindOfClass:[RegisterViewController class]]){
        RegisterViewController *controller = (RegisterViewController *)segue.destinationViewController;
        controller.backController = self;
    }
    else if([segue.destinationViewController isKindOfClass:[GroupViewController class]]){
        GroupViewController *controller = (GroupViewController *)segue.destinationViewController;
        controller.isGroup = isToGroup;
    }
}

@end
