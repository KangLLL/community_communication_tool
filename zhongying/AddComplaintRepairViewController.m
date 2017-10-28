//
//  AddRepairViewController.m
//  zhongying
//
//  Created by lik on 14-4-5.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddComplaintRepairViewController.h"
#import "UserInformation.h"
#import "CommonConsts.h"
#import "CommonHelper.h"
#import "AddRepairRequestParameter.h"
#import "ImageInformation.h"
#import "CommunicationManager.h"
#import "CommonUtilities.h"
#import "CommunityInfoParameter.h"
#import "OptionCell.h"
#import "RoomInformation.h"
#import "AppDelegate.h"

#define REPAIR_IMAGE_NAME                       @"repair.jpg"

#define PHOTO_IMAGE_HEIGHT                      90

@interface AddComplaintRepairViewController ()
- (void)dismissKeyboard;

- (void)constructSelectionTable;
- (void)showSelectionTable;

- (void)updateRoomControlStatus;

- (void)restoreWindow;

@end

@implementation AddComplaintRepairViewController

@synthesize communitiesView, textContent, textName, textPhone, textTitle, photoConstrain, viewContent, labelHeadTitle, labelTips, labelContentPlaceholder;

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
    self.communitiesView.selectItemImage = [UIImage imageNamed:COMMUNITY_DEFAULT_SELECT_IMAGE_NAME];
    self.communitiesView.unselectItemImage = [UIImage imageNamed:COMMUNITY_DEFAULT_UNSELECT_IMAGE_NAME];
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, TEXT_VIEW_ACCESSOR_VIEW_HEIGHT)];
    [topView setBarStyle:UIBarStyleBlackOpaque];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyboard)];
    
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    
    [topView setItems:buttonsArray];
    [self.textContent setInputAccessoryView:topView];
    
    self.labelCommunity.text = [NSString stringWithFormat:@"[%@]", [[UserInformation instance] currentCommunity].communityName];
    
    viewContent.layer.borderColor = [UIColor grayColor].CGColor;
    viewContent.layer.borderWidth = 1;
    
    [communitiesView reloadData];
    [communitiesView setSelectIndex:[UserInformation instance].currentCommunityIndex];
    
    [self registerTextField:self.textName];
    [self registerTextField:self.textPhone];
    [self registerTextField:self.textTitle];
    [self registerTextField:self.textContent];
    
    if(self.isComplaint){
        self.labelHeadTitle.text = @"添加投诉";
        self.labelTips.text = @"目前您投诉的小区为:";
        self.labelContentPlaceholder.text = @"请描述需要投诉的内容";
        self.textTitle.placeholder = @"投诉标题";
    }
    
    self.textPhone.text = [UserInformation instance].phone;
    [self updateRoomControlStatus];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    window = appDelegate.window;
    windowFrame = appDelegate.window.frame;
    windowBounds = appDelegate.window.bounds;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(keyboardHeight > 0){
        UIScrollView *container = [CommonHelper getParentScrollView:textField];
        float newY = [CommonHelper getRelatedOriginal:textField withParent:container].y - container.frame.size.height + textField.frame.size.height;
        if(newY > container.contentOffset.y){
            container.contentOffset = CGPointMake(0, newY);
        }
    }
    focusController = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Text View Delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    focusController = textView;
    if(keyboardHeight > 0){
        UIScrollView *container = [CommonHelper getParentScrollView:textView];
        float newY = [CommonHelper getRelatedOriginal:textView withParent:container].y - container.frame.size.height + textView.frame.size.height;
        if(newY > container.contentOffset.y){
            container.contentOffset = CGPointMake(0, newY);
        }
    }
    return YES;
}


- (void)textViewDidChange:(UITextView *)textView
{
    UIScrollView *container = [CommonHelper getParentScrollView:textView];
    float newY = [CommonHelper getRelatedOriginal:textView withParent:container].y - container.frame.size.height + textView.frame.size.height;
    if(newY > container.contentOffset.y){
        container.contentOffset = CGPointMake(0, newY);
    }
}

#pragma mark - FoldableView Delegate

- (int)numberOfItemInView
{
    return [[UserInformation instance].communities count];
}

- (NSString *)foldableView:(FoldableView *)foldableView titleAtIndex:(int)index
{
    return [[UserInformation instance] getCommunity:index].communityName;
}

- (void)foldableView:(FoldableView *)foldableView didSelectAtIndex:(int)index
{
    [UserInformation instance].currentCommunityIndex = index;
    self.labelCommunity.text = [NSString stringWithFormat:@"[%@]", [[UserInformation instance] currentCommunity].communityName];
    currentSelectRoom = 0;
    [self updateRoomControlStatus];
}

#pragma mark - Button Actions

- (IBAction)getMore:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if(self.communitiesView.isFolded){
        [self.communitiesView unfoldView];
        [button setTitle:GET_MORE_COMMUNITY_BUTTON_UNFOLD_TITLE forState:UIControlStateNormal];
        [button setSelected:YES];
    }
    else{
        [self.communitiesView foldView];
        [button setTitle:GET_MORE_COMMUNITY_BUTTON_FOLD_TITLE forState:UIControlStateNormal];
        [button setSelected:NO];
    }
}

- (IBAction)selectRoom:(id)sender
{
    [self showSelectionTable];
}

- (IBAction)getCameraPhoto:(id)sender
{
    if(currentImageCount == 3){
        [self showErrorMessage:@"最多上传3张图片"];
    }
    else{
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:^{
        }];
    }
}

- (IBAction)getAlbumPhoto:(id)sender
{
    if(currentImageCount == 3){
        [self showErrorMessage:@"最多上传3张图片"];
    }
    else{
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:^{
        }];
    }
}

- (IBAction)addRepair:(id)sender
{
    if([self.textName.text length] == 0){
        [self showErrorMessage:@"请输入联系人"];
    }
    else if([self.textPhone.text length] != 11){
        [self showErrorMessage:@"请输入正确的联系电话"];
    }
    else if([self.textTitle.text length] == 0){
        [self showErrorMessage:@"请输入标题"];
    }
    else if([self.textContent.text length] == 0){
        [self showErrorMessage:@"请输入内容"];
    }
    else{
        
        RoomInformation *room = [[[UserInformation instance] currentCommunity].rooms objectAtIndex:currentSelectRoom];
        
        if(self.isComplaint){
            AddComplaintRequestParameter *request = [[AddComplaintRequestParameter alloc] init];
            request.userId = [UserInformation instance].userId;
            request.communityId = [[UserInformation instance] currentCommunity].communityId;
            request.password = [UserInformation instance].password;
            request.title = self.textTitle.text;
            request.content = self.textContent.text;
            request.telephone = self.textPhone.text;
            request.buildNo = room.buildNo;
            request.floorNo = room.floorNo;
            request.roomNo = room.roomNo;
            request.userName = self.textName.text;
            
            if(self.imagePhoto1.image != nil){
                ImageInformation *image = [[ImageInformation alloc] init];
                image.imageData = UIImageJPEGRepresentation(self.imagePhoto1.image, 0.5);
                image.fileName = @"1.jpg";
                [request.images addObject:image];
            }
            if(self.imagePhoto2.image != nil){
                ImageInformation *image = [[ImageInformation alloc] init];
                image.imageData = UIImageJPEGRepresentation(self.imagePhoto2.image, 0.5);
                image.fileName = @"2.jpg";
                [request.images addObject:image];
            }
            if(self.imagePhoto3.image != nil){
                ImageInformation *image = [[ImageInformation alloc] init];
                image.imageData = UIImageJPEGRepresentation(self.imagePhoto3.image, 0.5);
                image.fileName = @"3.jpg";
                [request.images addObject:image];
            }
            
            [[CommunicationManager instance] addComplaint:request withDelegate:self];
        }
        else{
            AddRepairRequestParameter *request = [[AddRepairRequestParameter alloc] init];
            request.userId = [UserInformation instance].userId;
            request.communityId = [[UserInformation instance] currentCommunity].communityId;
            request.password = [UserInformation instance].password;
            request.title = self.textTitle.text;
            request.content = self.textContent.text;
            request.telephone = self.textPhone.text;
            request.buildNo = room.buildNo;
            request.floorNo = room.floorNo;
            request.roomNo = room.roomNo;
            request.userName = self.textName.text;
            
            if(self.imagePhoto1.image != nil){
                ImageInformation *image = [[ImageInformation alloc] init];
                image.imageData = UIImageJPEGRepresentation(self.imagePhoto1.image, 0.5);
                image.fileName = @"1.jpg";
                [request.images addObject:image];
            }
            if(self.imagePhoto2.image != nil){
                ImageInformation *image = [[ImageInformation alloc] init];
                image.imageData = UIImageJPEGRepresentation(self.imagePhoto2.image, 0.5);
                image.fileName = @"2.jpg";
                [request.images addObject:image];
            }
            if(self.imagePhoto3.image != nil){
                ImageInformation *image = [[ImageInformation alloc] init];
                image.imageData = UIImageJPEGRepresentation(self.imagePhoto3.image, 0.5);
                image.fileName = @"3.jpg";
                [request.images addObject:image];
            }
            
            [[CommunicationManager instance] addRepair:request withDelegate:self];
        }
        [[CommonUtilities instance] showNetworkConnecting:self];
    }
}

#pragma mark - Image Picker Controller Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image= [info objectForKey:UIImagePickerControllerOriginalImage];
    image = [CommonHelper processUploadImage:image];
    if(currentImageCount == 0){
        self.imagePhoto1.image = image;
        self.photoConstrain.constant = PHOTO_IMAGE_HEIGHT;
    }
    else if(currentImageCount == 1){
        self.imagePhoto2.image = image;
    }
    else if(currentImageCount == 2){
        self.imagePhoto3.image = image;
    }
    currentImageCount ++;
    
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
    [[CommonUtilities instance] hideNetworkConnecting];
    [self.navigationController popViewControllerAnimated:YES];
    [[CommonUtilities instance] showGlobeMessage:@"添加成功"];
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


#pragma mark - Table Delegate
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[UserInformation instance] currentCommunity].rooms count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionCell *cell = [tableView dequeueReusableCellWithIdentifier:OPTION_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    RoomInformation *room = [[[UserInformation instance] currentCommunity].rooms objectAtIndex:indexPath.row];
    [cell setOptionString:[NSString stringWithFormat:ROOM_NO_FORMAT,room.buildNo, room.floorNo, room.roomNo]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentSelectRoom = indexPath.row;
    [self updateRoomControlStatus];
    tableOptions.hidden = YES;
    self.viewMask.hidden = YES;
}

#pragma mark - Keyboard
- (void)keyboardWillShow
{
    [UIView animateWithDuration:0.25f animations:^{
        self.bottomConstrains.constant = keyboardHeight;
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
        self.bottomConstrains.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - Private Methods
- (void)dismissKeyboard
{
    [self.textContent resignFirstResponder];
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

- (void)updateRoomControlStatus
{
    RoomInformation *room = [[[UserInformation instance] currentCommunity].rooms objectAtIndex:currentSelectRoom];
    self.labelRoomNo.text = [NSString stringWithFormat:ROOM_NO_FORMAT,room.buildNo, room.floorNo, room.roomNo];
    self.textName.text = room.ownerName;
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
@end
