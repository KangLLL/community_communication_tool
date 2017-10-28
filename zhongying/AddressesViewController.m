//
//  AddressesViewController.m
//  zhongying
//
//  Created by lk on 14-4-14.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddressesViewController.h"
#import "UserInformation.h"
#import "CommonUtilities.h"
#import "CommonHelper.h"
#import "AddressCell.h"
#import "AddressParameter.h"
#import "GetAddressesRequestParameter.h"
#import "EditAddressViewController.h"

#define ADDRESS_CELL_REUSE_IDENTIFIER           @"Address"
#define ADDRESS_DISPLAY_FORMAT                  @"%@%@%@%@"
#define ADD_ADDRESS_SEGUE_IDENTIFIER            @"Add"
#define EDIT_ADDRESS_SEGUE_IDENTIFIER           @"Edit"

@interface AddressesViewController ()

- (void)sendGetAddressesRequest;

@end

@implementation AddressesViewController
@synthesize tableInformations, isSelect, selectAddressId;

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
    self.tableInformations.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self sendGetAddressesRequest];
}


#pragma mark - Private Methods

- (void)sendGetAddressesRequest
{
    currentResponse = nil;
    
    GetAddressesRequestParameter *request = [[GetAddressesRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    
    [[CommunicationManager instance] getAddresses:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Button Action
- (IBAction)addAddress:(id)sender
{
    [self performSegueWithIdentifier:ADD_ADDRESS_SEGUE_IDENTIFIER sender:nil];
}

- (IBAction)editAddress:(id)sender
{
    UIButton *button = (UIButton *)sender;
    currentSelectIndex = [self.tableInformations indexPathForCell:[CommonHelper getParentCell:button]].section;
    [self performSegueWithIdentifier:EDIT_ADDRESS_SEGUE_IDENTIFIER sender:nil];
}

#pragma mark - Data table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(currentResponse == nil){
        return 0;
    }
    else{
        return [currentResponse.addresses count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = indexPath.section;
    AddressParameter *param = [currentResponse.addresses objectAtIndex:index];
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ADDRESS_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    
    cell.labelName.text = param.name;
    cell.labelPhone.text = param.phone;
    cell.labelAddress.text = [NSString stringWithFormat:ADDRESS_DISPLAY_FORMAT,param.provinceName, param.cityName, param.districtName, param.address];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isSelect){
        AddressParameter *param = [currentResponse.addresses objectAtIndex:indexPath.section];
        self.selectAddressId = param.addressId;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    currentResponse = response;
    
    [self.tableInformations reloadData];
    [[CommonUtilities instance] hideNetworkConnecting];
}

- (void)ProcessServerFail:(ServerFailInformation *)failInfo
{
    [[CommonUtilities instance] hideNetworkConnecting];
    NSLog(@"%@",failInfo.message);
    [self showErrorMessage:failInfo.message];
}

- (void)ProcessCommunicationError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
    NSLog(@"%@",error.localizedDescription);
    [self showErrorMessage:error.localizedDescription];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.hidesBottomBarWhenPushed = YES;
    if([segue.destinationViewController isKindOfClass:[EditAddressViewController class]]){
        EditAddressViewController *viewController = (EditAddressViewController *)segue.destinationViewController;
        viewController.currentAddress = [currentResponse.addresses objectAtIndex:currentSelectIndex];
    }
}


@end
