//
//  AddAddressViewController.m
//  zhongying
//
//  Created by lk on 14-4-14.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddAddressViewController.h"
#import "CommonUtilities.h"
#import "UserInformation.h"
#import "AddAddressRequestParameter.h"
#import "DistrictInformation.h"
#import "OptionCell.h"
#import "CommonConsts.h"


@interface AddAddressViewController ()

- (void)sendAddAddressRequest;
- (void)constructSelectionTable;
- (void)showSelectionTable;

@end

@implementation AddAddressViewController

@synthesize textZipCode, textAddress, textPhone, textName, textDistrict, textCity, textProvince;

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
    [self registerTextField:textName];
    [self registerTextField:textPhone];
    [self registerTextField:textAddress];
    [self registerTextField:textZipCode];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Action
- (IBAction)addAddress:(id)sender
{
    [self sendAddAddressRequest];
}

#pragma mark - Private Methods

- (void)sendAddAddressRequest
{
    [self resignFocus];
    if([self.textName.text length] == 0){
        [self showErrorMessage:@"请输入名字"];
    }
    else if([self.textPhone.text length] != 11){
        [self showErrorMessage:@"请输入有效的手机"];
    }
    else if([self.textAddress.text length] == 0){
        [self showErrorMessage:@"请输入地址"];
    }
    else if([self.textZipCode.text length] != 6){
        [self showErrorMessage:@"请输入有效的邮编"];
    }
    else if(currentProvince == nil){
        [self showErrorMessage:@"请输入省份"];
    }
    else if(currentCity == nil){
        [self showErrorMessage:@"请输入城市"];
    }
    else if(currentDistrict == nil){
        [self showErrorMessage:@"请输入地区"];
    }
    else{
        AddAddressRequestParameter *request = [[AddAddressRequestParameter alloc] init];
        request.userId = [UserInformation instance].userId;
        request.password = [UserInformation instance].password;
        request.name = self.textName.text;
        request.phone = self.textPhone.text;
        request.address = self.textAddress.text;
        request.zipCode = self.textZipCode.text;
        request.provinceId = currentProvince.regionId;
        request.cityId = currentCity.regionId;
        request.districtId = currentDistrict.regionId;
    
        [[CommunicationManager instance] addAddress:request withDelegate:self];
        [[CommonUtilities instance] showNetworkConnecting:self];
    }
}

- (void)constructSelectionTable
{
    tableOptions = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, 300, 0)];
    [tableOptions registerClass:[OptionCell class] forCellReuseIdentifier:OPTION_CELL_REUSE_IDENTIFIER];
    tableOptions.dataSource = self;
    tableOptions.delegate = self;
    tableOptions.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableOptions];
}

- (void)showSelectionTable
{
    [self resignFocus];
    
    self.viewMask.hidden = NO;
    tableOptions.hidden = NO;
    
    [tableOptions reloadData];
    float totalHeight = tableOptions.contentSize.height;
    float maxHeight = self.view.bounds.size.height - 2 * MIN_SELECTION_MARGIN;
    
    CGRect newFrame = tableOptions.frame;
    newFrame.size.height = MIN(totalHeight, maxHeight);
    tableOptions.frame = newFrame;
    tableOptions.center = self.view.center;
}


#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == self.textProvince){
        currentSelection = addressSelectProvince;
        currentProvince = nil;
        currentCity = nil;
        currentDistrict = nil;
        if(tableOptions == nil){
            [self constructSelectionTable];
        }
        [self showSelectionTable];
        return NO;
    }
    else if(textField == self.textCity){
        if(currentProvince != nil){
            currentSelection = addressSelectCity;
            currentCity = nil;
            currentDistrict = nil;
            [self showSelectionTable];
        }
        else{
            [self showErrorMessage:@"请先选择省"];
        }
        return NO;
    }
    else if(textField == self.textDistrict){
        if(currentCity != nil){
            currentSelection = addressSelectDistrict;
            currentDistrict = nil;
            [self showSelectionTable];
        }
        else{
            [self showErrorMessage:@"请先选择市"];
        }
        return NO;
    }
    else{
        return YES;
    }
}

#pragma mark - Table Delegate

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (currentSelection) {
        case addressSelectProvince:
            return [[[DistrictInformation instance] provinces] count];
        case addressSelectCity:
            return [[[DistrictInformation instance] getCitys:currentProvince.regionId] count];
        case addressSelectDistrict:
            return [[[DistrictInformation instance] getDistricts:currentCity.regionId] count];
    }
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionCell *cell = [tableView dequeueReusableCellWithIdentifier:OPTION_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    CGRect rect = CGRectMake(20, 10, 200, 44);
    
    switch (currentSelection) {
        case addressSelectProvince:{
            RegionInformation *region = [[[DistrictInformation instance] provinces] objectAtIndex:indexPath.row];
            [cell setOptionString:region.regionName withFrame:rect];
        }
            break;
        case addressSelectCity:{
            RegionInformation *region = [[[DistrictInformation instance] getCitys:currentProvince.regionId] objectAtIndex:indexPath.row];
            [cell setOptionString:region.regionName withFrame:rect];
        }
            break;
        case addressSelectDistrict:{
            RegionInformation *region = [[[DistrictInformation instance] getDistricts:currentCity.regionId] objectAtIndex:indexPath.row];
            [cell setOptionString:region.regionName withFrame:rect];
        }
            break;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableOptions.bounds.size.width, 44)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 44)];
    NSString *titleText = @"";
    switch (currentSelection) {
        case addressSelectProvince:{
            titleText = @"    请选择地区";
        }
            break;
        case addressSelectCity:{
            titleText = @"    请选择地区";
        }
            break;
        case addressSelectDistrict:{
            titleText = @"    请选择地区";
        }
            break;
    }
    
    label.text = titleText;
    view.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (currentSelection) {
        case addressSelectProvince:{
            RegionInformation *region = [[[DistrictInformation instance] provinces] objectAtIndex:indexPath.row];
            currentProvince = region;
            self.textProvince.text = region.regionName;
            
            self.textCity.text = @"";
            self.textDistrict.text = @"";
        }
            break;
        case addressSelectCity:{
            RegionInformation *region = [[[DistrictInformation instance] getCitys:currentProvince.regionId] objectAtIndex:indexPath.row];
            currentCity = region;
            self.textCity.text = region.regionName;
            
            self.textDistrict.text = @"";
        }
            break;
        case addressSelectDistrict:{
            RegionInformation *region = [[[DistrictInformation instance] getDistricts:currentCity.regionId] objectAtIndex:indexPath.row];
            currentDistrict = region;
            self.textDistrict.text = region.regionName;
            
        }
            break;
    }
    
    tableOptions.hidden = YES;
    self.viewMask.hidden = YES;
}


#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    [self.navigationController popViewControllerAnimated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
