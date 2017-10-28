//
//  ShopViewController.m
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ShopViewController.h"
#import "CommonUtilities.h"
#import "UserInformation.h"
#import "CommonConsts.h"
#import "GetShopsRequestParameter.h"
#import "ShopParameter.h"
#import "OptionCell.h"
#import "DistrictInformation.h"
#import "ShopCell.h"
#import "CategoryCell.h"
#import "DistrictCell.h"
#import "ShopDetailViewController.h"


#define CATEGORY_CELL_REUSE_IDENTIFIER      @"Category"
#define DISTRICT_CELL_REUSE_IDENTIFIER      @"Region"
#define SHOP_CELL_REUSE_IDENTIFIER          @"Shop"

#define DETAIL_SEGUE_IDENTIFIER             @"Detail"

@interface ShopViewController ()

- (void)sendGetShopsRequest;
- (void)sendGetShopsRequestWithPage:(int)page andPageSize:(int)pageSize;
- (void)constructSelectionTable;
- (void)showSelectionTable;
- (void)hideSelectionTable;

@end

@implementation ShopViewController

@synthesize viewMask, tableCategoryChild, tableCategoryParent, tableShops, tableProvince, tableCity, tableDistrict, buttonCategory, buttonDistrict;

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
    self.tableCategoryChild.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableCategoryParent.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableProvince.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableCity.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableDistrict.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableShops.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSelectionTable)];
    [self.viewMask addGestureRecognizer:tapGesture];
    
    cacher = [[DownloadCacher alloc] init];
    currentType = shopSelectionCommunity;
    
    shopDataManager = [[PageDataManager alloc] initWithPageSize:DEFAULT_PAGE_SIZE];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{
    if([[shopDataManager allData] count] == 0){
        [self sendGetShopsRequest];
    }
    else{
        [self sendGetShopsRequestWithPage:1 andPageSize:[[shopDataManager allData] count]];
        [shopDataManager clear];
    }
}

#pragma mark - Data table Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == self.tableShops){
        return [[shopDataManager allData] count];
    }
    else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(tableView == tableCommunitySelection){
        return [[UserInformation instance].communities count];
    }
    else if(tableView == self.tableProvince){
        return [[DistrictInformation instance].provinces count];
    }
    else if(tableView == self.tableCity){
        if(currentProvince != nil){
            return [[[DistrictInformation instance] getCitys:currentProvince.regionId] count];
        }
    }
    else if(tableView == self.tableDistrict){
        if(currentCity != nil){
            return [[[DistrictInformation instance] getDistricts:currentCity.regionId] count];
        }
    }
    else if(tableView == self.tableCategoryParent){
        if(currentResponse != nil){
            return [currentResponse.categories count];
        }
    }
    else if(tableView == self.tableCategoryChild){
        if(currentParentCategory != nil){
            return [currentParentCategory.childCategories count];
        }
    }
    else if(tableView == self.tableShops){
        if(currentResponse != nil){
            return 1;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tableShops){
        return 90;
    }
    else if(tableView == tableCommunitySelection){
        return 44;
    }
    else{
        return 33;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == self.tableShops){
        return 6;
    }
    else if(tableView == tableCommunitySelection){
        return 44;
    }
    else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == self.tableShops){
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
    else if(tableView == tableCommunitySelection){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableCommunitySelection.bounds.size.width, 44)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 44)];
        label.text = @"    请选择小区";
        view.backgroundColor = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [view addSubview:label];
        
        return view;
    }
    else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableCommunitySelection){
        OptionCell *cell = [tableView dequeueReusableCellWithIdentifier:OPTION_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        [cell setOptionString:[[UserInformation instance] getCommunity:indexPath.row].communityName];
        return cell;
    }
    else if(tableView == self.tableCategoryParent){
        CategoryParameter *param = [currentResponse.categories objectAtIndex:indexPath.row];
        CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CATEGORY_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        cell.labelName.text = param.categoryName;
        cell.labelCount.text = [NSString stringWithFormat:@"(%d)",param.shopCount];
        return cell;
    }
    else if(tableView == self.tableCategoryChild){
        CategoryParameter *param = [currentParentCategory.childCategories objectAtIndex:indexPath.row];
        CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CATEGORY_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        cell.labelName.text = param.categoryName;
        cell.labelCount.text = [NSString stringWithFormat:@"(%d)",param.shopCount];
        return cell;
    }
    else if(tableView == self.tableProvince){
        RegionInformation *param = [[DistrictInformation instance].provinces objectAtIndex:indexPath.row];
        DistrictCell *cell = [tableView dequeueReusableCellWithIdentifier:DISTRICT_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        cell.labelName.text = param.regionName;
        return cell;
    }
    else if(tableView == self.tableCity){
        RegionInformation *param = [[[DistrictInformation instance] getCitys:currentProvince.regionId] objectAtIndex:indexPath.row];
        DistrictCell *cell = [tableView dequeueReusableCellWithIdentifier:DISTRICT_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        cell.labelName.text = param.regionName;
        return cell;
    }
    else if(tableView == self.tableDistrict){
        RegionInformation *param = [[[DistrictInformation instance] getDistricts:currentCity.regionId] objectAtIndex:indexPath.row];
        DistrictCell *cell = [tableView dequeueReusableCellWithIdentifier:DISTRICT_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        cell.labelName.text = param.regionName;
        return cell;
    }
    else{
        ShopParameter *param = [[shopDataManager allData] objectAtIndex:indexPath.section];
        ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:SHOP_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        cell.labelName.text = param.shopName;
        cell.labelPhone.text = param.phone;
        cell.labelAddress.text = param.address;
        cell.tag = indexPath.section;
        [cacher getImageWithUrl:param.imageUrl andCell:cell inImageView:cell.imagePhoto withActivityView:cell.activityView];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableCommunitySelection){
        [UserInformation instance].currentCommunityIndex = indexPath.row;
        currentType = shopSelectionCommunity;
        [self.buttonCategory setTitle:@"请选择商家" forState:UIControlStateNormal];
        [self.buttonDistrict setTitle:@"请选择地区" forState:UIControlStateNormal];
        [shopDataManager clear];
        [self sendGetShopsRequest];
        [self hideSelectionTable];
    }
    else if(tableView == self.tableCategoryParent){
        CategoryParameter *cate = [currentResponse.categories objectAtIndex:indexPath.row];
        if(cate != currentParentCategory){
            if([cate.childCategories count] == 0){
                currentChildCategory = cate;
                self.tableCategoryParent.hidden = YES;
                self.tableCategoryChild.hidden = YES;
                [self.buttonCategory setTitle:cate.categoryName forState:UIControlStateNormal];
                currentType = shopSelectionCategory;
                [shopDataManager clear];
                [self sendGetShopsRequest];
            }
            else{
                currentParentCategory = cate;
                currentChildCategory = nil;
                self.tableCategoryChild.hidden = NO;
                [self.tableCategoryChild reloadData];
            }
        }
    }
    else if(tableView == self.tableCategoryChild){
        CategoryParameter *cate = [currentParentCategory.childCategories objectAtIndex:indexPath.row];
        if(cate != currentChildCategory){
            currentChildCategory = cate;
            self.tableCategoryParent.hidden = YES;
            self.tableCategoryChild.hidden = YES;
            [self.buttonCategory setTitle:cate.categoryName forState:UIControlStateNormal];
            currentType = shopSelectionCategory;
            [shopDataManager clear];
            [self sendGetShopsRequest];
        }
    }
    else if(tableView == self.tableProvince){
        RegionInformation *region = [[DistrictInformation instance].provinces objectAtIndex:indexPath.row];
        if(currentProvince != region){
            currentProvince = region;
            currentCity = nil;
            currentDisctrict = nil;
            self.tableCity.hidden = NO;
            [self.tableCity reloadData];
            self.tableDistrict.hidden = YES;
        }
    }
    else if(tableView == self.tableCity){
        RegionInformation *region = [[[DistrictInformation instance] getCitys:currentProvince.regionId] objectAtIndex:indexPath.row];
        if(currentCity != region){
            currentCity = region;
            currentDisctrict = nil;
            self.tableDistrict.hidden = NO;
            [self.tableDistrict reloadData];
        }
    }
    else if(tableView == self.tableDistrict){
        RegionInformation *region = [[[DistrictInformation instance] getDistricts:currentCity.regionId] objectAtIndex:indexPath.row];
        if(currentDisctrict != region){
            currentDisctrict = region;
            self.tableProvince.hidden = YES;
            self.tableCity.hidden = YES;
            self.tableDistrict.hidden = YES;
            [self.buttonDistrict setTitle:region.regionName forState:UIControlStateNormal];
            currentType = shopSelectionDistrict;
            [shopDataManager clear];
            [self sendGetShopsRequest];
        }
    }
    else if(tableView == self.tableShops){
        currentSelectIndex = indexPath.section;
        [self performSegueWithIdentifier:DETAIL_SEGUE_IDENTIFIER sender:nil];
    }
}

#pragma mark - Button Actions
- (IBAction)selectCategory:(id)sender
{
    self.tableCategoryParent.hidden = NO;
    self.tableCategoryChild.hidden = YES;
    self.tableProvince.hidden = YES;
    self.tableCity.hidden = YES;
    self.tableDistrict.hidden = YES;
}

- (IBAction)selectDistrict:(id)sender
{
    self.tableCategoryParent.hidden = YES;
    self.tableCategoryChild.hidden = YES;
    self.tableProvince.hidden = NO;
    self.tableCity.hidden = YES;
    self.tableDistrict.hidden = YES;
}

- (IBAction)selectCommunity:(id)sender
{
    self.tableCategoryParent.hidden = YES;
    self.tableCategoryChild.hidden = YES;
    self.tableProvince.hidden = YES;
    self.tableCity.hidden = YES;
    self.tableDistrict.hidden = YES;
    
    [self showSelectionTable];
}

#pragma mark - Private Methods

- (void)sendGetShopsRequest
{
    [self sendGetShopsRequestWithPage:[shopDataManager getNextLoadPage] andPageSize:DEFAULT_PAGE_SIZE];
}

- (void)sendGetShopsRequestWithPage:(int)page andPageSize:(int)pageSize
{
    currentResponse = nil;
    
    GetShopsRequestParameter *request = [[GetShopsRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.page = page;
    request.pageSize = pageSize;
    
    if(currentType == shopSelectionCommunity){
        request.communityId = [[UserInformation instance] currentCommunity].communityId;
    }
    else{
        if(currentChildCategory != nil){
            request.categoryId = currentChildCategory.categoryId;
        }
        if(currentProvince != nil){
            request.provinceId = [NSString stringWithFormat:@"%d",currentProvince.regionId];
        }
        if(currentCity != nil){
            request.cityId = [NSString stringWithFormat:@"%d",currentCity.regionId];
        }
        if(currentDisctrict != nil){
            request.districtId = [NSString stringWithFormat:@"%d",currentDisctrict.regionId];
        }
        
        currentProvince = nil;
        currentCity = nil;
        currentDisctrict = nil;
    }
    [[CommunicationManager instance] getShops:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)constructSelectionTable
{
    tableCommunitySelection = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, 300, 0)];
    [tableCommunitySelection registerClass:[OptionCell class] forCellReuseIdentifier:OPTION_CELL_REUSE_IDENTIFIER];
    tableCommunitySelection.dataSource = self;
    tableCommunitySelection.delegate = self;
    tableCommunitySelection.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableCommunitySelection];
}

- (void)showSelectionTable
{
    if(tableCommunitySelection == nil){
        [self constructSelectionTable];
    }
    self.viewMask.hidden = NO;
    tableCommunitySelection.hidden = NO;
    
    [tableCommunitySelection reloadData];
    float totalHeight = tableCommunitySelection.contentSize.height;
    float maxHeight = self.view.bounds.size.height - 2 * MIN_SELECTION_MARGIN;
    
    CGRect newFrame = tableCommunitySelection.frame;
    newFrame.size.height = MIN(totalHeight, maxHeight);
    tableCommunitySelection.frame = newFrame;
    tableCommunitySelection.center = self.view.center;
}

- (void)hideSelectionTable
{
    tableCommunitySelection.hidden = YES;
    self.viewMask.hidden = YES;
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    currentResponse = response;
    if([currentResponse.shops count] == 0){
        [self showErrorMessage:@"当前暂无此商家"];
    }
    
    [shopDataManager populateData:currentResponse.shops];
    [self.tableShops reloadData];
    
    CGFloat height = MAX(self.tableShops.contentSize.height, self.tableShops.frame.size.height);
    if(refreshHeaderView == nil){
        EGORefreshTableHeaderView *view =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, height, self.tableShops.bounds.size.width, self.tableShops.bounds.size.height)];
        view.delegate = self;
        [self.tableShops addSubview:view];
        refreshHeaderView = view;
    }
    else{
        CGRect newFrame = refreshHeaderView.frame;
        newFrame.origin.y = height;
        refreshHeaderView.frame = newFrame;
        [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableShops];
        isReloading = NO;
    }
    
    [self.tableCategoryParent reloadData];
    [[CommonUtilities instance] hideNetworkConnecting];
}

- (void)ProcessServerFail:(ServerFailInformation *)failInfo
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableShops];
    isReloading = NO;
    NSLog(@"%@",failInfo.message);
    [self showErrorMessage:failInfo.message];
}

- (void)ProcessCommunicationError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableShops];
    isReloading = NO;
    NSLog(@"%@",error.localizedDescription);
    [self showErrorMessage:error.localizedDescription];
}


#pragma mark - EGORefreshTableHeaderDelegate Methods
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    isReloading = YES;
    [self sendGetShopsRequest];
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ShopDetailViewController *detail = (ShopDetailViewController *)segue.destinationViewController;
    detail.shop = [[shopDataManager allData] objectAtIndex:currentSelectIndex];
}


@end
