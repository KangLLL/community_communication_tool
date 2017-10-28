//
//  RentViewController.m
//  zhongying
//
//  Created by lk on 14-4-16.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "RentViewController.h"
#import "CommonUtilities.h"
#import "CommonConsts.h"
#import "UserInformation.h"
#import "GetRentRequestParameter.h"
#import "GetMyRentRequestParameter.h"
#import "RentCell.h"
#import "MyRentCell.h"
#import "HouseParameter.h"
#import "DeleteRentRequestParameter.h"
#import "CommonHelper.h"
#import "RentDetailViewController.h"

#define RENT_CELL_REUSE_IDENTIFIER          @"Rent"
#define MY_RENT_CELL_REUSE_IDENTIFIER       @"MyRent"
#define ADD_RENT_SEGUE_IDENTIFIER           @"Add"
#define DETAIL_SEGUE_IDENTIFIER             @"Detail"

#define RENT_PAGE_SIZE                      15

@interface RentViewController ()

- (void)updateUI;
- (void)sendGetRentRequest;
- (void)sendGetMyRentRequest;
- (void)sendDeleteRentRequest;

- (void)sendGetRentRequestWithPage:(int)page andPageSize:(int)pageSize;
- (void)sendGetMyRentRequestWithPage:(int)page andPageSize:(int)pageSize;

@end

@implementation RentViewController

@synthesize buttonMyRent, buttonRent, viewMyRentHead, viewRentHead, tableInformation,buttonAdd, bottomConstraint;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currentType = rentInformation;
    //rentTypeDescriptions = [NSArray arrayWithObjects:@"整租",@"合租",@"短期出租",@"出售", nil];
    self.tableInformation.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self updateUI];
    
    rentDataManager = [[PageDataManager alloc] initWithPageSize:RENT_PAGE_SIZE];
    myRentDataManager = [[PageDataManager alloc] initWithPageSize:RENT_PAGE_SIZE];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    if(currentType == rentInformation){
        if([[rentDataManager allData] count] == 0){
            [self sendGetRentRequest];
        }
        else{
            [self sendGetRentRequestWithPage:1 andPageSize:[[rentDataManager allData] count]];
            [rentDataManager clear];
        }
    }
    else{
        if([[myRentDataManager allData] count] == 0){
            [self sendGetMyRentRequest];
        }
        else{
            [self sendGetMyRentRequestWithPage:1 andPageSize:[[rentDataManager allData] count]];
            [myRentDataManager clear];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data table Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(currentType == rentInformation){
        return [[rentDataManager allData] count];
    }
    else if(currentType == myRentInformation){
        return [[myRentDataManager allData] count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = indexPath.row;
    if(currentType == rentInformation){
        HouseParameter *param = [[rentDataManager allData] objectAtIndex:index];
        RentCell *cell = [tableView dequeueReusableCellWithIdentifier:RENT_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        cell.labelMoney.text = [NSString stringWithFormat:@"%.2f",param.price];
        cell.labelTime.text = param.time;
        cell.labelName.text = param.contactName;
        cell.labelTitle.text = param.title;
        cell.labelType.text = param.rentType;
        return cell;
    }
    else{
        MyHouseParameter *param = [[myRentDataManager allData] objectAtIndex:index];
        MyRentCell *cell = [tableView dequeueReusableCellWithIdentifier:MY_RENT_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        cell.labelMoney.text = [NSString stringWithFormat:@"%.2f",param.price];
        cell.labelTime.text = param.time;
        cell.labelTitle.text = param.title;
        cell.labelType.text = param.rentType;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(currentType == rentInformation){
        currentHouse = [[rentDataManager allData] objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:DETAIL_SEGUE_IDENTIFIER sender:nil];
    }
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    if(response == nil){
        [self sendGetMyRentRequest];
    }
    else{
        if(currentType == rentInformation){
            rentResponse = response;
            [rentDataManager populateData:rentResponse.houses];
        }
        else{
            myRentResponse = response;
            [myRentDataManager populateData:myRentResponse.houses];
        }
        
        [self.tableInformation reloadData];
        CGFloat height = MAX(self.tableInformation.contentSize.height, self.tableInformation.frame.size.height);
        if(refreshHeaderView == nil){
            EGORefreshTableHeaderView *view =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, height, self.tableInformation.bounds.size.width, self.tableInformation.bounds.size.height)];
            view.delegate = self;
            [self.tableInformation addSubview:view];
            refreshHeaderView = view;
        }
        else{
            CGRect newFrame = refreshHeaderView.frame;
            newFrame.origin.y = height;
            refreshHeaderView.frame = newFrame;
            [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformation];
            isReloading = NO;
        }

        [[CommonUtilities instance] hideNetworkConnecting];
    }
}

- (void)ProcessServerFail:(ServerFailInformation *)failInfo
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [self.tableInformation reloadData];
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformation];
    isReloading = NO;
    NSLog(@"%@",failInfo.message);
    [self showErrorMessage:failInfo.message];
}

- (void)ProcessCommunicationError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [self.tableInformation reloadData];
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformation];
    isReloading = NO;
    NSLog(@"%@",error.localizedDescription);
    [self showErrorMessage:error.localizedDescription];
}


#pragma mark - Button Actions

- (IBAction)getRent:(id)sender
{
    if(currentType != rentInformation){
        currentType = rentInformation;
        [self updateUI];
        [self sendGetRentRequest];
    }
}

- (IBAction)getMyRent:(id)sender
{
    if(currentType != myRentInformation){
        currentType = myRentInformation;
        [self updateUI];
        [self sendGetMyRentRequest];
    }
}

- (IBAction)addRent:(id)sender
{
    self.hidesBottomBarWhenPushed = YES;
    currentSelectRent = nil;
    [self performSegueWithIdentifier:ADD_RENT_SEGUE_IDENTIFIER sender:nil];
}

- (IBAction)editRent:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int index = [self.tableInformation indexPathForCell:[CommonHelper getParentCell:button]].row;
    self.hidesBottomBarWhenPushed = YES;
    currentSelectRent = [[myRentDataManager allData] objectAtIndex:index];
    [self performSegueWithIdentifier:ADD_RENT_SEGUE_IDENTIFIER sender:nil];
}

- (IBAction)deleteRent:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int index = [self.tableInformation indexPathForCell:[CommonHelper getParentCell:button]].row;
    currentSelectRent = [[myRentDataManager allData] objectAtIndex:index];
    [self sendDeleteRentRequest];
}

#pragma mark - Private Methods

- (void)updateUI
{
    if(currentType == rentInformation){
        [self.buttonRent setSelected:YES];
        [self.buttonMyRent setSelected:NO];
        
        self.viewRentHead.hidden = NO;
        self.viewMyRentHead.hidden = YES;
        
        self.buttonAdd.hidden = YES;
        self.bottomConstraint.constant = 4;
    }
    else{
        [self.buttonRent setSelected:NO];
        [self.buttonMyRent setSelected:YES];
        
        self.viewRentHead.hidden = YES;
        self.viewMyRentHead.hidden = NO;
        
        self.buttonAdd.hidden = NO;
        self.bottomConstraint.constant = 44;
    }
}

- (void)sendGetRentRequest
{
    [self sendGetRentRequestWithPage:[rentDataManager getNextLoadPage] andPageSize:RENT_PAGE_SIZE];
}

- (void)sendGetMyRentRequest
{
    [self sendGetMyRentRequestWithPage:[myRentDataManager getNextLoadPage] andPageSize:RENT_PAGE_SIZE];
}

- (void)sendDeleteRentRequest
{
    DeleteRentRequestParameter *request = [[DeleteRentRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.messageId = currentSelectRent.messageId;
    [[CommunicationManager instance] deleteRent:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendGetRentRequestWithPage:(int)page andPageSize:(int)pageSize
{
    rentResponse = nil;
    
    GetRentRequestParameter *request = [[GetRentRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.communityId = [[UserInformation instance] currentCommunity].communityId;
    request.page = page;
    request.pageSize = pageSize;
    [[CommunicationManager instance] getRent:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendGetMyRentRequestWithPage:(int)page andPageSize:(int)pageSize
{
    myRentResponse = nil;
    
    GetMyRentRequestParameter *request = [[GetMyRentRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.communityId = [[UserInformation instance] currentCommunity].communityId;
    request.page = page;
    request.pageSize = pageSize;
    [[CommunicationManager instance] getMyRent:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - EGORefreshTableHeaderDelegate Methods
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    isReloading = YES;
    switch (currentType) {
        case rentInformation:
            [self sendGetRentRequest];
            break;
        case myRentInformation:
            [self sendGetMyRentRequest];
            break;
    }
}

-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return isReloading;
}

#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[RentDetailViewController class]]){
        RentDetailViewController *controller = (RentDetailViewController *)segue.destinationViewController;
        controller.currentHouse = currentHouse;
    }
    else{
        AddRentViewController *controller = (AddRentViewController *)segue.destinationViewController;
        controller.currentHouse = currentSelectRent;
    }
}


@end
