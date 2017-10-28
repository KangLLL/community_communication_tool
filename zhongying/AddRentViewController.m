//
//  AddRentViewController.m
//  zhongying
//
//  Created by LI K on 16/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import "AddRentViewController.h"
#import "CommonConsts.h"
#import "UserInformation.h"
#import "CommonUtilities.h"
#import "CommonHelper.h"
#import "OptionCell.h"
#import "AddRentRequestParameter.h"
#import "EditRentRequestParameter.h"
#import "HouseDetailResponseParameter.h"
#import "AppDelegate.h"

#define PHOTO_IMAGE_HEIGHT      60

@interface AddRentViewController ()
- (void)constructSelectionTable;
- (void)showSelectionTable;
- (void)clearFocus;

- (void)sendAddRentRequest;
- (void)sendEditRentRequest;
- (void)sendGetHouseDetailRequest;
- (BOOL)validateInput;

- (void)restoreWindow;
@end

@implementation AddRentViewController

@synthesize textArea, textTing, textCommunity, textTitle, textDescription, textFloor, textMoney, textName, textPayType, textPhone, textPhoto, textRentType, textShi, textTotalFloor, textWei, scrollContent, bottomConstraint, viewMask, contentBottomConstraint, currentHouse, uploadView;

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
    [self registerTextField:self.textName];
    [self registerTextField:self.textPhone];
    [self registerTextField:self.textShi];
    [self registerTextField:self.textTing];
    [self registerTextField:self.textWei];
    [self registerTextField:self.textArea];
    [self registerTextField:self.textFloor];
    [self registerTextField:self.textTotalFloor];
    [self registerTextField:self.textMoney];
    [self registerTextField:self.textTitle];
    [self registerTextField:self.textDescription];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    window = appDelegate.window;
    windowFrame = appDelegate.window.frame;
    windowBounds = appDelegate.window.bounds;
    
    payTypeDescriptions = [NSArray arrayWithObjects:@"押一付三",@"押一付一",@"半年付",@"年付",@"面议", nil];
    rentTypeDescriptions = [NSArray arrayWithObjects:@"整租",@"合租",@"短期出租",@"出售", nil];
    
    keyboardHeight = 0;
    initialBottomConst = self.bottomConstraint.constant;
    initialContentConst = self.contentBottomConstraint.constant;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    if(self.currentHouse != nil && currentResponse == nil){
        [self sendGetHouseDetailRequest];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text Field Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == self.textCommunity){
        currentSelection = addRentCommunity;
        [self showSelectionTable];
        [self clearFocus];
        return NO;
    }
    if(textField == self.textPayType){
        currentSelection = addRentPayType;
        [self showSelectionTable];
        [self clearFocus];
        return NO;
    }
    if(textField == self.textRentType){
        currentSelection = addRentRentType;
        [self showSelectionTable];
        [self clearFocus];
        return NO;
    }
    if(textField == self.textPhoto){
        if([self.uploadView canUploadMore]){
            currentSelection = addRentPhoto;
            [self showSelectionTable];
            [self clearFocus];
        }
        else{
            [self showErrorMessage:@"最多上传3张图片"];
        }
        return NO;
    }

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    focusController = textField;
    if(keyboardHeight > 0){
        CGPoint newOffset = CGPointMake(0, [CommonHelper getRelatedOriginal:textField withParent:self.scrollContent].y - self.scrollContent.frame.size.height + textField.frame.size.height);
        if(newOffset.y > self.scrollContent.contentOffset.y){
            self.scrollContent.contentOffset = newOffset;
        }
    }
}

#pragma mark - Table View Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (currentSelection) {
        case addRentCommunity:
            return [[UserInformation instance].communities count];
        case addRentPayType:
            return [payTypeDescriptions count];
        case addRentRentType:
            return [rentTypeDescriptions count];
        case addRentPhoto:
            return 2;
            
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionCell *cell = [tableView dequeueReusableCellWithIdentifier:OPTION_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    switch (currentSelection) {
        case addRentCommunity:{
            [cell setOptionString:[[UserInformation instance] getCommunity:indexPath.row].communityName];
        }
            break;
        case addRentPayType:{
            [cell setOptionString:[payTypeDescriptions objectAtIndex:indexPath.row]];
        }
            break;
        case addRentRentType:{
            [cell setOptionString:[rentTypeDescriptions objectAtIndex:indexPath.row]];
        }
            break;
        case addRentPhoto:{
            if(indexPath.row == 0){
                [cell setOptionString:PHOTO_FROM_ALBUM_TEXT];
            }
            else{
                [cell setOptionString:PHOTO_FROM_CAMARE_TEXT];
            }
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
        case addRentCommunity:{
            titleText = @"    选择小区";
        }
            break;
        case addRentPayType:{
            titleText = @"    选择付款类型";
        }
            break;
        case addRentRentType:{
            titleText = @"    租赁方式";
        }
            break;
        case addRentPhoto:{
            titleText = @"    选择上传图片";
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
        case addRentCommunity:{
            selectCommunity = [[UserInformation instance] getCommunity:indexPath.row];
            self.textCommunity.text = selectCommunity.communityName;
        }
            break;
        case addRentPayType:{
            //selectPayType = (RentPayType)indexPath.row;
            self.textPayType.text = [payTypeDescriptions objectAtIndex:indexPath.row];
        }
            break;
        case addRentRentType:{
            //selectRentType = (RentType)indexPath.row;
            self.textRentType.text = [rentTypeDescriptions objectAtIndex:indexPath.row];
        }
            break;
        case addRentPhoto:{
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = indexPath.row == 0 ?UIImagePickerControllerSourceTypePhotoLibrary :UIImagePickerControllerSourceTypeCamera;
            imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            imagePicker.allowsEditing = YES;
            
            [self presentViewController:imagePicker animated:YES completion:^{
                /*
                if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7){
                    
                    window.frame =  CGRectMake(0,0,windowFrame.size.width,windowFrame.size.height + 20);
                    window.bounds = CGRectMake(0,0,windowFrame.size.width, windowFrame.size.height);
                }
                 */
            }];
             
        }
            break;
    }
    
    tableOptions.hidden = YES;
    self.viewMask.hidden = YES;
}

#pragma mark - Button Actions
- (IBAction)addRent:(id)sender
{
    if(self.currentHouse == nil){
        [self sendAddRentRequest];
    }
    else{
        [self sendEditRentRequest];
    }
}

- (IBAction)returnToList:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Keyboard

- (void)keyboardWillShow
{
    [UIView animateWithDuration:0.25f animations:^{
        self.bottomConstraint.constant = initialBottomConst + keyboardHeight;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        UIScrollView *container = [CommonHelper getParentScrollView:focusController];
        float newY = [CommonHelper getRelatedOriginal:focusController withParent:container].y - container.frame.size.height + focusController.frame.size.height;
        if(newY > container.contentOffset.y){
            container.contentOffset = CGPointMake(0, newY);
        }
    }];
}

- (void)keyboardWillHide
{
    [UIView animateWithDuration:0.25f animations:^{
        self.bottomConstraint.constant = initialBottomConst;
        [self.view layoutIfNeeded];
    }];
}


#pragma mark - Private Methods
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

- (void)clearFocus
{
    [self.textArea resignFirstResponder];
    [self.textCommunity resignFirstResponder];
    [self.textDescription resignFirstResponder];
    [self.textFloor resignFirstResponder];
    [self.textMoney resignFirstResponder];
    [self.textName resignFirstResponder];
    [self.textPayType resignFirstResponder];
    [self.textPhone resignFirstResponder];
    [self.textPhoto resignFirstResponder];
    [self.textRentType resignFirstResponder];
    [self.textShi resignFirstResponder];
    [self.textTing resignFirstResponder];
    [self.textTitle resignFirstResponder];
    [self.textTotalFloor resignFirstResponder];
    [self.textWei resignFirstResponder];
}

- (void)sendGetHouseDetailRequest
{
    GetHouseDetailRequestParameter *request = [[GetHouseDetailRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.messageId = self.currentHouse.messageId;
    [[CommunicationManager instance] getHouseDetail:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendAddRentRequest
{
    [self resignFocus];
    if([self validateInput]){
        AddRentRequestParameter *request = [[AddRentRequestParameter alloc] init];
        request.contactName = self.textName.text;
        request.contactPhone = self.textPhone.text;
        request.communityId = selectCommunity.communityId;
        request.communityName = selectCommunity.communityName;
        request.rentType = self.textRentType.text;
        request.payType = self.textPayType.text;
        request.title = self.textTitle.text;
        request.price = [self.textMoney.text floatValue];
        request.size = self.textArea.text;
        request.totalRoom = [self.textShi.text intValue];
        request.totalLobby = [self.textTing.text intValue];
        request.totalToilet = [self.textWei.text intValue];
        request.floorNo = self.textFloor.text;
        request.totalFloor = self.textTotalFloor.text;
        request.description = self.textDescription.text;
        request.userId = [UserInformation instance].userId;
        request.password = [UserInformation instance].password;
        request.images = [self.uploadView getUploadImageInformations];
        
        [[CommunicationManager instance] addRent:request withDelegate:self];
        [[CommonUtilities instance] showNetworkConnecting:self];
    }
}

- (void)sendEditRentRequest
{
    [self resignFocus];
    if([self validateInput]){
        EditRentRequestParameter *request = [[EditRentRequestParameter alloc] init];
        request.messageId = self.currentHouse.messageId;
        request.contactName = self.textName.text;
        request.contactPhone = self.textPhone.text;
        request.communityId = selectCommunity.communityId;
        request.communityName = selectCommunity.communityName;
        request.rentType = self.textRentType.text;
        request.payType = self.textPayType.text;
        request.title = self.textTitle.text;
        request.price = [self.textMoney.text floatValue];
        request.size = self.textArea.text;
        request.totalRoom = [self.textShi.text intValue];
        request.totalLobby = [self.textTing.text intValue];
        request.totalToilet = [self.textWei.text intValue];
        request.floorNo = self.textFloor.text;
        request.totalFloor = self.textTotalFloor.text;
        request.description = self.textDescription.text;
        request.userId = [UserInformation instance].userId;
        request.password = [UserInformation instance].password;
        
        if([self.uploadView getUploadImageInformations] != nil){
            request.images = [self.uploadView getUploadImageInformations];
        }
        
        [[CommunicationManager instance] editRent:request withDelegate:self];
        [[CommonUtilities instance] showNetworkConnecting:self];
    }
}

- (BOOL)validateInput
{
    if([self.textName.text length] == 0){
        [self showErrorMessage:@"请输入联系人"];
        return NO;
    }
    if([self.textPhone.text length] != 11){
        [self showErrorMessage:@"请输入有效的手机号"];
        return NO;
    }
    if([self.textShi.text length] == 0){
        [self showErrorMessage:@"请输入室"];
        return NO;
    }
    if([self.textTing.text length] == 0){
        [self showErrorMessage:@"请输入厅"];
        return NO;
    }
    if([self.textWei.text length] == 0){
        [self showErrorMessage:@"请输入卫"];
        return NO;
    }
    if([self.textArea.text length] == 0){
        [self showErrorMessage:@"请输入面积"];
        return NO;
    }
    if([self.textFloor.text length] == 0){
        [self showErrorMessage:@"请输入楼层"];
        return NO;
    }
    if([self.textTotalFloor.text length] == 0){
        [self showErrorMessage:@"请输入总楼层"];
        return NO;
    }
    if([self.textMoney.text length] == 0){
        [self showErrorMessage:@"请输入价格"];
        return NO;
    }
    if([self.textTitle.text length] == 0){
        [self showErrorMessage:@"请输入题目"];
        return NO;
    }
    if([self.textDescription.text length] == 0){
        [self showErrorMessage:@"请输入描述"];
        return NO;
    }
    if(selectCommunity == nil){
        [self showErrorMessage:@"请选择小区"];
        return NO;
    }
    if([self.textPayType.text length] == 0){
        [self showErrorMessage:@"请选择付款类型"];
        return NO;
    }
    if([self.textRentType.text length] == 0){
        [self showErrorMessage:@"请选择租赁类型"];
        return NO;
    }
    return YES;
}

#pragma mark - Image Picker Controller Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image= [info objectForKey:UIImagePickerControllerOriginalImage];
    //self.textPhoto.text = [[info objectForKey:UIImagePickerControllerReferenceURL] absoluteString];
    
    image = [CommonHelper processUploadImage:image];
    [self.uploadView uploadLocalImage:image];
    
    if(self.contentBottomConstraint.constant == initialContentConst){
        self.uploadView.hidden = NO;
        self.contentBottomConstraint.constant += 96;
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    [self restoreWindow];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    [self restoreWindow];
}

- (void)restoreWindow
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        window.frame = windowFrame;
        window.bounds = windowBounds;
    }
}

#pragma mark - Navigation Controller Delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([navigationController isKindOfClass:[UIImagePickerController class]]){
        [self restoreWindow];
    }
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    if([response isKindOfClass:[HouseDetailResponseParameter class]]){
        currentResponse = response;
        HouseDetailResponseParameter *param = response;
        self.textName.text = param.contactName;
        self.textPhone.text = param.contactPhone;
        self.textArea.text = param.size;
        selectCommunity = [[UserInformation instance] currentCommunity];
        self.textCommunity.text = [[UserInformation instance] currentCommunity].communityName;
        self.textDescription.text = param.description;
        self.textFloor.text = param.floorNo;
        self.textMoney.text = param.price;
        self.textPayType.text = param.payType;
        self.textRentType.text = param.rentType;
        self.textShi.text = [NSString stringWithFormat:@"%d",param.totalRoom];
        self.textTing.text = [NSString stringWithFormat:@"%d",param.totalLobby];
        self.textTitle.text = param.tile;
        self.textTotalFloor.text = param.totalFloor;
        self.textWei.text = [NSString stringWithFormat:@"%d",param.totalToilet];
        
        NSMutableArray *array = [NSMutableArray array];
        if(param.image1 != nil)
        {
            [array addObject:param.image1];
            if(param.image2 != nil){
                [array addObject:param.image2];
                if(param.image3 != nil){
                    [array addObject:param.image3];
                }
            }
        }
        if([array count] > 0){
            self.uploadView.hidden = NO;
            [self.uploadView downloadServerImage:array];
            if(self.contentBottomConstraint.constant == initialContentConst){
                self.contentBottomConstraint.constant += 96;
            }
        }
    }
    else{
        if(self.currentHouse == nil){
            [[CommonUtilities instance] showGlobeMessage:@"添加成功"];
        }
        else{
            [[CommonUtilities instance] showGlobeMessage:@"修改成功"];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
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
