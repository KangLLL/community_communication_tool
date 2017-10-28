//
//  HobbyViewController.m
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "HobbyViewController.h"
#import "HobbyCell.h"
#import "UserInformation.h"
#import "HobbyParameter.h"
#import "HobbyPeopleParameter.h"
#import "GetSameHobbyPeopleRequestParameter.h"
#import "GetHobbiesRequestParameter.h"
#import "CommonUtilities.h"
#import "CommunicationManager.h"
#import "GetMyHobbiesResponseParameter.h"
#import "AddHobbyRequestParameter.h"
#import "DeleteHobbyRequestParameter.h"
#import "CommonHelper.h"
#import "HobbyMessageViewController.h"
#import "CommonConsts.h"
#import "OptionCell.h"

//#define HOBBY_SELECT_IMAGE_NAME                 @"common_interest_bg_img"
//#define HOBBY_UNSELECT_IMAGE_NAME               @"circum_merchant_mian_bg"
#define HOBBY_EDIT_SELECT_IMAGE_NAME            @"login_checkbox_checked"
#define HOBBY_EDIT_UNSELECT_IMAGE_NAME          @"login_checkbox"

#define GET_MORE_BUTTON_FOLD_TITLE              @"更多爱好"
#define GET_MORE_BUTTON_UNFOLD_TITLE            @"收起"

#define HEAD_CELL_REUSE_IDENTIFIER              @"Head"
#define CONTENT_CELL_REUSE_IDENTIFIER           @"Content"

#define TOTAL_DESCRIPTION_FORMAT                @"共有%d位同道中人"

#define SEND_MESSAGE_SEGUE_IDENTIFIER           @"Message"
#define HOBBY_PAGE_SIZE                         20

@interface HobbyViewController ()

- (void)sendGetSameHobbyPeopleRequest;
- (void)sendGetMyHobbyRequest;
- (void)sendGetHobbiesRequest;
- (void)sendAddMyHobbyRequest;
- (void)sendDeleteHobbyRequest;

- (void)sendGetSameHobbyPeopleRequestWithPage:(int)page andPageSize:(int)pageSize;

- (void)filterHobbies;
- (void)touchAddMyHobby:(id)sender;

- (void)constructSelectionTable;
- (void)showSelectionTable;
- (void)hideSelectionTable;
- (void)constructBuildOptions;
- (void)constructFloorOptions;
- (void)constructRoomOptions;
@end

@implementation HobbyViewController

@synthesize hobbiesView, tableInformations, labelPeopleCount, viewMask,textBottomSpace,textHobbyName, buttonAddHobby, buttonAddMyHobby, buttonDeleteHobby, buttonGetMore;

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
    self.hobbiesView.selectItemImage = [UIImage imageNamed:COMMUNITY_DEFAULT_SELECT_IMAGE_NAME];
    self.hobbiesView.unselectItemImage = [UIImage imageNamed:COMMUNITY_DEFAULT_UNSELECT_IMAGE_NAME];
    
    self.hobbiesView.imageSelect = [UIImage imageNamed:HOBBY_EDIT_SELECT_IMAGE_NAME];
    self.hobbiesView.imageUnselect = [UIImage imageNamed:HOBBY_EDIT_UNSELECT_IMAGE_NAME];
    self.hobbiesView.imageFrame = CGRectMake(0, 0, 13, 13);
    
    addMyHobbyView = [[MultiplySelectPopupView alloc] initWithFrame:CGRectZero];
    
    addMyHobbyView.selectImage = [UIImage imageNamed:HOBBY_EDIT_SELECT_IMAGE_NAME];
    addMyHobbyView.unselectImage = [UIImage imageNamed:HOBBY_EDIT_UNSELECT_IMAGE_NAME];
    
    addMyHobbyView.imageFrame = CGRectMake(0, 3, 20, 20);
    
    addMyHobbyView.dataDelegate = self;
    addMyHobbyView.delegate = self;
    addMyHobbyView.hidden = YES;
    [self.view addSubview:addMyHobbyView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSelectionTable)];
    [self.viewMask addGestureRecognizer:tapGesture];
    
    sameHobbyDataManager = [[PageDataManager alloc] initWithPageSize:HOBBY_PAGE_SIZE];
    //self.tableHeight.constant = 0;
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self sendGetMyHobbyRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button Actions

- (IBAction)getMore:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if(self.hobbiesView.isFolded){
        [self.hobbiesView unfoldView];
        [button setTitle:GET_MORE_BUTTON_UNFOLD_TITLE forState:UIControlStateNormal];
        [button setSelected:YES];
    }
    else{
        [self.hobbiesView foldView];
        [button setTitle:GET_MORE_BUTTON_FOLD_TITLE forState:UIControlStateNormal];
        [button setSelected:NO];
    }
}

- (IBAction)addMyHobby:(id)sender
{
    [self sendGetHobbiesRequest];
}

- (IBAction)addNewHobby:(id)sender
{
    self.textHobbyName.superview.hidden = NO;
    self.viewMask.hidden = NO;
}

- (IBAction)deleteHobby:(id)sender
{
    if(self.hobbiesView.editType == editMultiplay && [self.hobbiesView.selections count] > 0){
        deleteHobbyIndex = 0;
        [self sendDeleteHobbyRequest];
    }
    else{
        [self showErrorMessage:@"长按，选中要删除的爱好"];
    }
}

- (IBAction)clickAddHobby:(id)sender
{
    if([self.textHobbyName.text length] > 0){
        currentFunction = hobbyAddHobby;
        AddHobbyRequestParameter *request = [[AddHobbyRequestParameter alloc] init];
        request.hobbyName = self.textHobbyName.text;
        request.userId = [UserInformation instance].userId;
        request.password = [UserInformation instance].password;
        [[CommunicationManager instance] addHobby:request withDelegate:self];
        self.textHobbyName.superview.hidden = YES;
        self.viewMask.hidden = YES;
        [self.textHobbyName resignFirstResponder];
    }
    else{
        self.textHobbyName.superview.hidden = YES;
        self.viewMask.hidden = YES;
    }
}

- (void)sendMessage:(id)sender
{
    UIButton *button = (UIButton *)sender;
    currentSelectIndex = [self.tableInformations indexPathForCell:[CommonHelper getParentCell:button]].row;
    [self performSegueWithIdentifier:SEND_MESSAGE_SEGUE_IDENTIFIER sender:nil];
}

- (void)filterCommunity:(id)sender
{
    if(currentSameHobbyPeopleResponse == nil){
        [self showErrorMessage:@"请先选择一个爱好"];
    }
    else{
        currentFilterType = hobbyPeopleFilterCommunity;
        [self showSelectionTable];
    }
}

- (void)filterBuild:(id)sender
{
    if(filterCommunityId == nil){
        [self showErrorMessage:@"请先选择一个小区"];
    }
    else{
        currentFilterType = hobbyPeopleFilterBuild;
        [self showSelectionTable];
    }
}

- (void)filterFloor:(id)sender
{
    if(filterBuildId == nil){
        [self showErrorMessage:@"请先选择一个幢"];
    }
    else{
        currentFilterType = hobbyPeopleFilterFloor;
        [self showSelectionTable];
    }
}

- (void)filterRoom:(id)sender
{
    if(filterFloorId == nil){
        [self showErrorMessage:@"请先选择一个层"];
    }
    else{
        currentFilterType = hobbyPeopleFilterRoom;
        [self showSelectionTable];
    }
}

#pragma mark - Private Methods

- (void)sendGetSameHobbyPeopleRequest
{
    [self sendGetSameHobbyPeopleRequestWithPage:[sameHobbyDataManager getNextLoadPage] andPageSize:HOBBY_PAGE_SIZE];
}

- (void)sendGetSameHobbyPeopleRequestWithPage:(int)page andPageSize:(int)pageSize
{
    currentFunction = hobbyGetSamePeople;
    currentSameHobbyPeopleResponse = nil;
    
    GetSameHobbyPeopleRequestParameter *request = [[GetSameHobbyPeopleRequestParameter alloc] init];
    
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.hobbyId = [[UserInformation instance] currentHobby].hobbyId;
    request.communityId = filterCommunityId;
    request.buildNo = filterBuildId;
    request.floorNo = filterFloorId;
    request.roomNo = filterRoomId;
    request.page = page;
    request.pageSize = pageSize;
    
    [[CommunicationManager instance] getSameHobbyPeople:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendGetMyHobbyRequest
{
    currentFunction = hobbyGetMyHobbies;
    [UserInformation instance].hobbies = nil;
    GetMyHobbiesRequestParameter *request = [[GetMyHobbiesRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    [[CommunicationManager instance] getMyHobbies:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendGetHobbiesRequest
{
    currentFunction = hobyyGetHobbies;
    currentHobbies = nil;
    GetHobbiesRequestParameter *request = [[GetHobbiesRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    [[CommunicationManager instance] getHobbies:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendAddMyHobbyRequest
{
    currentFunction = hobbyAddMyHobby;
    AddHobbyRequestParameter *request = [[AddHobbyRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    HobbyParameter *hobby = [currentHobbies.hobbies objectAtIndex:[[addMyHobbyView.selections objectAtIndex:addHobbyIndex] intValue]];
    request.hobbyId = hobby.hobbyId;
    request.hobbyName = hobby.hobbyName;
    addHobbyIndex ++;
    [[CommunicationManager instance] addHobby:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendDeleteHobbyRequest
{
    currentFunction = hobbyDeleteHobby;
    DeleteHobbyRequestParameter *request = [[DeleteHobbyRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    
    int index = [[self.hobbiesView.selections objectAtIndex:deleteHobbyIndex] intValue];
    HobbyParameter *hobby = [[UserInformation instance].hobbies objectAtIndex:index];
    request.hobbyId = hobby.hobbyId;
    deleteHobbyIndex ++;
    [[CommunicationManager instance] deleteHobby:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)filterHobbies
{
    if(currentHobbies != nil && [UserInformation instance].hobbies != nil){
        NSMutableString *filterString = [NSMutableString string];
        for (HobbyParameter *h in [UserInformation instance].hobbies) {
            if([filterString length] > 0){
                [filterString appendString:@","];
            }
            [filterString appendString:h.hobbyId];
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"not (hobbyId in %@)", filterString];
        
        currentHobbies.hobbies = [currentHobbies.hobbies filteredArrayUsingPredicate:predicate];
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
    if(tableOptions == nil){
        [self constructSelectionTable];
    }
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

- (void)hideSelectionTable
{
    tableOptions.hidden = YES;
    addMyHobbyView.hidden = YES;
    self.textHobbyName.superview.hidden = YES;
    [self.textHobbyName resignFirstResponder];
    self.viewMask.hidden = YES;
}

- (void)constructBuildOptions
{
    arrayBuild = [NSMutableArray array];
    for (HobbyPeopleParameter *param in [sameHobbyDataManager allData]) {
        if(![arrayBuild containsObject:param.buildNo]){
            [arrayBuild addObject:param.buildNo];
        }
    }
}

- (void)constructFloorOptions
{
    arrayFloor = [NSMutableArray array];
    for (HobbyPeopleParameter *param in [sameHobbyDataManager allData]) {
        if(![arrayFloor containsObject:param.floorNo]){
            [arrayFloor addObject:param.floorNo];
        }
    }
}

- (void)constructRoomOptions
{
    arrayRoom = [NSMutableArray array];
    for (HobbyPeopleParameter *param in [sameHobbyDataManager allData]) {
        if(![arrayRoom containsObject:param.roomNo]){
            [arrayRoom addObject:param.roomNo];
        }
    }
}
#pragma mark Add Button Method
- (void)touchAddMyHobby:(id)sender
{
    self.viewMask.hidden = YES;
    addMyHobbyView.hidden = YES;
    if([addMyHobbyView.selections count] > 0){
        [self sendAddMyHobbyRequest];
    }
}


#pragma mark - Data table Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == tableOptions){
        switch (currentFilterType) {
            case hobbyPeopleFilterCommunity:
                return [[UserInformation instance].communities count];
            case hobbyPeopleFilterBuild:
                return [arrayBuild count];
            case hobbyPeopleFilterFloor:
                return [arrayFloor count];
            case hobbyPeopleFilterRoom:
                return [arrayRoom count];
        }
    }
    else{
        return [[sameHobbyDataManager allData] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableOptions){
        OptionCell *cell = [tableView dequeueReusableCellWithIdentifier:OPTION_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        int index = indexPath.row;
        switch (currentFilterType) {
            case hobbyPeopleFilterCommunity:{
                NSString *communityKey = [[UserInformation instance].communities.allKeys objectAtIndex:index];
                CommunityInformation *info = [[UserInformation instance].communities objectForKey:communityKey];
                [cell setOptionString:info.communityName];
                return cell;
            }
            case hobbyPeopleFilterBuild:{
                [cell setOptionString:[arrayBuild objectAtIndex:index]];
                return cell;
            }
            case hobbyPeopleFilterFloor:{
                [cell setOptionString:[arrayFloor objectAtIndex:index]];
                return cell;
            }
            case hobbyPeopleFilterRoom:{
                [cell setOptionString:[arrayRoom objectAtIndex:index]];
                return cell;
            }
        }
    }
    else{
        HobbyCell *cell = [tableView dequeueReusableCellWithIdentifier:CONTENT_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        HobbyPeopleParameter *param = [[sameHobbyDataManager allData] objectAtIndex:indexPath.row];
        cell.labelCommunityName.text = param.communityName;
        cell.labelBuildNo.text = param.buildNo;
        cell.labelFloorNo.text = param.floorNo;
        cell.labelPhone.text = param.userName;
        cell.labelRoomNo.text = param.roomNo;
        
        return cell;
    }
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView == tableOptions;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableOptions){
        int index = indexPath.row;
        switch (currentFilterType) {
            case hobbyPeopleFilterCommunity:{
                NSString *communityKey = [[[UserInformation instance].communities allKeys] objectAtIndex:index];
                CommunityInformation *info = [[UserInformation instance].communities objectForKey:communityKey];
                filterCommunityId = info.communityId;
                filterBuildId = nil;
                filterFloorId = nil;
                filterRoomId = nil;
                break;
            }
            case hobbyPeopleFilterBuild:{
                filterBuildId = [arrayBuild objectAtIndex:index];
                filterFloorId = nil;
                filterRoomId = nil;
                break;
            }
            case hobbyPeopleFilterFloor:{
                filterFloorId = [arrayFloor objectAtIndex:index];
                filterRoomId = nil;
                break;
            }
            case hobbyPeopleFilterRoom:{
                filterRoomId = [arrayRoom objectAtIndex:index];
                break;
            }
        }
        [self hideSelectionTable];
        [sameHobbyDataManager clear];
        [self sendGetSameHobbyPeopleRequest];
    }
}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3f animations:^{
        self.textBottomSpace.constant += 100;
        [self.view layoutIfNeeded];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3f animations:^{
        self.textBottomSpace.constant -= 100;
        [self.view layoutIfNeeded];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - FoldableView Delegate

- (int)numberOfItemInView
{
    return [[UserInformation instance].hobbies count];
}

- (NSString *)foldableView:(FoldableView *)foldableView titleAtIndex:(int)index
{
    HobbyParameter *hobby = [[UserInformation instance].hobbies objectAtIndex:index];
    return hobby.hobbyName;
}

- (void)foldableView:(FoldableView *)foldableView didSelectAtIndex:(int)index
{
    [UserInformation instance].currentHobbyIndex = index;
    filterCommunityId = nil;
    filterBuildId = nil;
    filterFloorId = nil;
    filterRoomId = nil;
    [sameHobbyDataManager clear];
    [self sendGetSameHobbyPeopleRequest];
    
}

- (void)editFoldableView:(EditFoldableView *)editView changeToState:(FoldableEditType)newType
{
    if(newType == editSingle){
        self.buttonAddHobby.hidden = NO;
        self.buttonAddMyHobby.hidden = NO;
    }
    else if(newType == editMultiplay){
        self.buttonAddHobby.hidden = YES;
        self.buttonAddMyHobby.hidden = YES;
    }
}

#pragma mark - Popup View Delegate

- (int)numberOfItemInPopupView:(PopupView *)popupView
{
    return [currentHobbies.hobbies count];
}

- (NSString *)popupView:(PopupView *)popupView titleAtIndex:(int)index
{
    HobbyParameter *hobby = [currentHobbies.hobbies objectAtIndex:index];
    
    return [NSString stringWithFormat:@"%@",hobby.hobbyName];
}


- (void)popupView:(PopupView *)popupView didSelectAtIndex:(int)index
{
    
}

- (float)widthOfBorderInPopupView:(PopupView *)view
{
    return 2;
}

- (UIColor *)ColorOfBorderInPopupView:(PopupView *)view;
{
    return [UIColor blackColor];
}

- (CGPoint)titleOffsetInPopupView:(PopupView *)view
{
    return CGPointMake(20, 0);
}

- (float)maxOfHeightInPopupView:(PopupView *)view
{
    return self.view.bounds.size.height - 40;
}

- (float)widthOfItemInPopupView:(PopupView *)view
{
    return 90;
}

- (float)columnDistanceInPopupView:(PopupView *)view
{
    return 15;
}

- (float)marginOfLeftInPopupView:(PopupView *)view
{
    return 0;
}

- (float)marginOfRightInPopupView:(PopupView *)view
{
    return 0;
}

- (float)heightOfHeadInPopupView:(PopupView *)view
{
    return 60;
}

- (float)heightOfFootInPopupView:(PopupView *)view
{
    return 50;
}

- (float)widthOfContentInPopupView:(PopupView *)view
{
    return 300;
}

- (UIView *)viewOfHeadInPopupView:(PopupView *)view
{
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
    head.backgroundColor = [UIColor blackColor];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 40)];
    title.text = @"添加爱好";
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    [head addSubview:title];
    return head;
}

- (UIView *)viewOfFootInPopupView:(PopupView *)view
{
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    foot.backgroundColor = [UIColor grayColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    [button setTitle:@"添加爱好" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightGrayColor];
    [button addTarget:self action:@selector(touchAddMyHobby:) forControlEvents:UIControlEventTouchUpInside];
    [foot addSubview:button];
    button.center = foot.center;
    return foot;
}
#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    [[CommonUtilities instance] hideNetworkConnecting];
    switch (currentFunction) {
        case hobbyGetMyHobbies:{
            GetMyHobbiesResponseParameter *param = (GetMyHobbiesResponseParameter *)response;
            [UserInformation instance].hobbies = param.hobbies;
            [self.hobbiesView reloadData];
            if(!isInitial){
                isInitial = YES;
                [self getMore:self.buttonGetMore];
            }
        }
            break;
        case hobbyGetSamePeople:{
            currentSameHobbyPeopleResponse = response;
            [sameHobbyDataManager populateData:currentSameHobbyPeopleResponse.sameHobbyPeoples];
            if([[sameHobbyDataManager allData] count] > 0){
                HobbyPeopleParameter *param = [[sameHobbyDataManager allData] objectAtIndex:0];
                self.labelPeopleCount.text = [NSString stringWithFormat:TOTAL_DESCRIPTION_FORMAT, param.totalPeopleNumber];
            }
            [self.tableInformations reloadData];
            CGFloat height = MAX(self.tableInformations.contentSize.height, self.tableInformations.frame.size.height);
            if(refreshHeaderView == nil){
                EGORefreshTableHeaderView *view =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, height, self.tableInformations.bounds.size.width, self.tableInformations.bounds.size.height)];
                view.delegate = self;
                [self.tableInformations addSubview:view];
                refreshHeaderView = view;
            }
            else{
                CGRect newFrame = refreshHeaderView.frame;
                newFrame.origin.y = height;
                refreshHeaderView.frame = newFrame;
                [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformations];
                isReloading = NO;
            }
            
            if(filterRoomId == nil){
                if(filterFloorId != nil){
                    [self constructRoomOptions];
                }
                else if(filterBuildId != nil){
                    [self constructFloorOptions];
                }
                else if(filterCommunityId != nil){
                    [self constructBuildOptions];
                }
            }
        }
            break;
        case hobyyGetHobbies:{
            currentHobbies = response;
            addHobbyIndex = 0;
            [self filterHobbies];
            [addMyHobbyView reloadData];
            self.viewMask.hidden = NO;
            addMyHobbyView.hidden = NO;
            [addMyHobbyView showCenterInView:self.viewMask];
        }
            break;
        case hobbyAddMyHobby:{
            if(addHobbyIndex == [addMyHobbyView.selections count]){
                [self sendGetMyHobbyRequest];
                [self showErrorMessage:@"添加成功"];
            }
            else{
                [self sendAddMyHobbyRequest];
            }
            break;
        }
        case hobbyAddHobby:{
            [self sendGetMyHobbyRequest];
            [self showErrorMessage:@"添加成功"];
        }
            break;
        case hobbyDeleteHobby:{
            if(deleteHobbyIndex == [self.hobbiesView.selections count]){
                [self.hobbiesView changeState];
                self.buttonAddHobby.hidden = NO;
                self.buttonAddMyHobby.hidden = NO;
                [self sendGetMyHobbyRequest];
            }
            else{
                [self sendDeleteHobbyRequest];
            }
            break;
        }
    }
}

- (void)ProcessServerFail:(ServerFailInformation *)failInfo
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [self.tableInformations reloadData];
    
    if(currentFunction == hobbyAddMyHobby){
        if(addHobbyIndex == [addMyHobbyView.selections count]){
            [self sendGetMyHobbyRequest];
        }
        else{
            [self sendAddMyHobbyRequest];
        }
    }
    if(currentFunction == hobbyDeleteHobby){
        if(deleteHobbyIndex == [self.hobbiesView.selections count]){
            [self.hobbiesView changeState];
            self.buttonAddHobby.hidden = NO;
            self.buttonAddMyHobby.hidden = NO;
            [self sendGetMyHobbyRequest];
        }
        else{
            [self sendDeleteHobbyRequest];
        }
    }
    if(currentFunction == hobbyGetMyHobbies){
        [self.hobbiesView reloadData];
    }
    if(currentFunction == hobbyGetSamePeople){
        [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformations];
        isReloading = NO;
    }
    /*
    else{
        if(addHobbyIndex == [self.addMyHobbyView.selections count]){
            [self sendGetMyHobbyRequest];
        }
        else{
            [self sendAddMyHobbyRequest];
        }
    }
     */
    NSLog(@"%@",failInfo.message);
    [self showErrorMessage:failInfo.message];
}

- (void)ProcessCommunicationError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
    if(currentFunction == hobbyAddMyHobby){
        if(addHobbyIndex == [addMyHobbyView.selections count]){
            [self sendGetMyHobbyRequest];
        }
        else{
            [self sendAddMyHobbyRequest];
        }
    }
    if(currentFunction == hobbyGetSamePeople){
        [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformations];
        isReloading = NO;
    }
    NSLog(@"%@",error.localizedDescription);
    [self showErrorMessage:error.localizedDescription];
}

#pragma mark - EGORefreshTableHeaderDelegate Methods
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    isReloading = YES;
    [self sendGetSameHobbyPeopleRequest];
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
    if([segue.destinationViewController isKindOfClass:[HobbyMessageViewController class]]){
        HobbyMessageViewController *dest =  (HobbyMessageViewController *)segue.destinationViewController;
        dest.currentPeople = [[sameHobbyDataManager allData] objectAtIndex:currentSelectIndex];
    }
}


@end
