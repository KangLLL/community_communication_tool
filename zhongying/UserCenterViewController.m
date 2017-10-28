//
//  UserCenterViewController.m
//  zhongying
//
//  Created by lik on 14-3-28.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UserInformation.h"
#import "UserCenterHeadCell.h"
#import "CommunicationManager.h"
#import "CommonUtilities.h"
#import "HomeViewController.h"
#import "CommonConsts.h"
#import "LoginViewController.h"
#import "OptionCell.h"
#import "EditAvatarRequestParameter.h"
#import "StringResponse.h"
#import "AppDelegate.h"

#define HEAD_CELL_REUSE_IDENTIFIER      @"Head"
#define FUNCTION_CELL_REUSE_IDENTIFIER  @"Function"
#define LOG_OUT_CELL_REUSE_IDENTIFIER   @"Logout"
#define LOG_IN_SEGUE_IDENTIFIER         @"Login"
#define MY_COMMUNITIES_SEGUE_IDENTIFIER @"Community"
#define MONEY_SEGUE_IDENTIFIER          @"Money"
#define ABOUT_SEGUE_IDENTIFIER          @"About"
#define PASSWORD_SEGUE_IDENTIFIER       @"Password"
#define ADDRESS_SEGUE_IDENTIFIER        @"Address"
#define RECORD_SEGUE_IDENTIFIER         @"Record"
#define MESSAGE_SEGUE_IDENTIFIER        @"Message"
#define MY_INFORMATION_SEGUE_IDENTIFIER @"Self"
#define ORDER_SEGUE_IDENTIFIER          @"Order"

@interface UserCenterViewController ()

- (void)logInFirst;
- (void)toSegue:(NSString *)suegeIdentifier;

- (void)constructSelectionTable;
- (void)showSelectionTable;
- (void)hideSelectionTable;

- (void)sendEditAvatarRequest;
- (void)getAvatar;

- (void)restoreWindow;

@end

@implementation UserCenterViewController

@synthesize tableItems, viewMask;

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
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSelectionTable)];
    [self.viewMask addGestureRecognizer:tapGesture];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    window = appDelegate.window;
    windowFrame = appDelegate.window.frame;
    windowBounds = appDelegate.window.bounds;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableItems reloadData];
    if([UserInformation instance].avatarPath != nil && [UserInformation instance].avatar == nil){
        [self getAvatar];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == tableOptions){
        return 2;
    }
    else{
        if([UserInformation instance].name == nil){
            return 11;
        }
        else{
            return 12;
        };
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableOptions){
        OptionCell *cell = [tableView dequeueReusableCellWithIdentifier:OPTION_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        if(indexPath.row == 0){
            [cell setOptionString:PHOTO_FROM_ALBUM_TEXT];
        }
        else{
            [cell setOptionString:PHOTO_FROM_CAMARE_TEXT];
        }
        return cell;
    }
    else{
        if(indexPath.row == 0){
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: HEAD_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
            UserCenterHeadCell *headCell = (UserCenterHeadCell *)cell;
            if([UserInformation instance].name != nil){
                headCell.imageAvatar.image = [UserInformation instance].avatar;
                headCell.activityView.hidden = imageAvatar.image != nil;
                if(imageAvatar.image == nil){
                    [headCell.activityView startAnimating];
                }
                headCell.labelName.text = [UserInformation instance].name;
            }
            else{
                headCell.labelName.text = @"请登录";
                headCell.activityView.hidden = YES;
            }
            imageAvatar = headCell.imageAvatar;
            activityView = headCell.activityView;
            return cell;
        }
        else if(indexPath.row == 11){
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LOG_OUT_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
            return cell;
        }
        else{
            int index = indexPath.row;
            if(index > 8){
                index ++;
            }
            NSString *reusableCellWithIdentifier = [NSString stringWithFormat:@"%@%d",FUNCTION_CELL_REUSE_IDENTIFIER, index];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableCellWithIdentifier forIndexPath:indexPath];
            return cell;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableOptions){
        return 44;
    }
    else{
        if(indexPath.row  == 0){
            return 80;
        }
        else{
            return 44;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == tableOptions){
        return 44;
    }
    else{
        return 0;
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == tableOptions){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableOptions.bounds.size.width, 44)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 44)];
        NSString *titleText = @"    设置头像";
        label.text = titleText;
        view.backgroundColor = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [view addSubview:label];
        
        return view;
    }
    else{
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableOptions){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = indexPath.row == 0 ?UIImagePickerControllerSourceTypePhotoLibrary :UIImagePickerControllerSourceTypeCamera;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:^{
        }];
        [self hideSelectionTable];
    }
    else
    {
        if(indexPath.row == 0){
            if([UserInformation instance].userId == nil){
                [self logInFirst];
            }
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
        }
        else if(indexPath.row == 1){
            if([UserInformation instance].name == nil){
                [self logInFirst];
            }
            else{
                [self toSegue:MY_COMMUNITIES_SEGUE_IDENTIFIER];
            }
        }
        else if(indexPath.row == 2){
            if([UserInformation instance].name == nil){
                [self logInFirst];
            }
            else{
                [self toSegue:ORDER_SEGUE_IDENTIFIER];
            }
        }
        else if(indexPath.row == 3){
            if([UserInformation instance].name == nil){
                [self logInFirst];
            }
            else{
                [self toSegue:RECORD_SEGUE_IDENTIFIER];
            }
        }
        else if(indexPath.row == 4){
            if([UserInformation instance].name == nil){
                [self logInFirst];
            }
            else{
                [self toSegue:MY_INFORMATION_SEGUE_IDENTIFIER];
            }
        }
        else if(indexPath.row == 5){
            if([UserInformation instance].name == nil){
                [self logInFirst];
            }
            else{
                [self toSegue:MESSAGE_SEGUE_IDENTIFIER];
            }
        }
        else if(indexPath.row == 6){
            [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
            [self showErrorMessage:@"功能暂未开放"];
        }
        else if (indexPath.row == 7){
            if([UserInformation instance].name == nil){
                [self logInFirst];
            }
            else{
                [self toSegue:MONEY_SEGUE_IDENTIFIER];
            }
        }
        else if (indexPath.row == 8){
            if([UserInformation instance].name == nil){
                [self logInFirst];
            }
            else{
                [self toSegue:ADDRESS_SEGUE_IDENTIFIER];
            }
        }
        /*
        else if(indexPath.row == 9){
            [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
            [self showErrorMessage:@"功能暂未开放"];
        }
         */
        else if(indexPath.row == 9){
            if([UserInformation instance].name == nil){
                [self logInFirst];
            }
            else{
                [self toSegue:PASSWORD_SEGUE_IDENTIFIER];
            }
        }
        else if(indexPath.row == 10){
            [self toSegue:ABOUT_SEGUE_IDENTIFIER];
        }
        else if(indexPath.row == 11){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"确定退出？"
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"确定",nil];
            
            [alert show];
        }
    }
}

#pragma mark - Button Action

- (IBAction)editAvatar:(id)sender
{
    if([UserInformation instance].userId == nil){
        [self logInFirst];
    }
    else{
        [self showSelectionTable];
    }
}

#pragma mark - Private Methods

- (void)logInFirst
{
    [[CommonUtilities instance] showGlobeMessage:LOG_IN_TIPS];
    [self toSegue:LOG_IN_SEGUE_IDENTIFIER];
}

- (void)toSegue:(NSString *)suegeIdentifier
{
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:suegeIdentifier sender:nil];
    self.hidesBottomBarWhenPushed = NO;
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
    self.viewMask.hidden = YES;
}

- (void)sendEditAvatarRequest
{
    ImageInformation *newAvatar = [[ImageInformation alloc] init];
    newAvatar.imageData =  UIImageJPEGRepresentation(localAvatar, 0.5);
    newAvatar.fileName = @"avatar.jpg";
    EditAvatarRequestParameter *request = [[EditAvatarRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.theNewAvatar = newAvatar;

    [[CommunicationManager instance] editAvatar:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)getAvatar
{
    avatarDownloader = [[ImageDownloader alloc] init];
    [avatarDownloader downloadImage:[UserInformation instance].avatarPath withDelegate:self];
    [UserInformation instance].avatar = nil;
    activityView.hidden = NO;
    imageAvatar.image = nil;
    [activityView startAnimating];
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

#pragma mark - Image Download Delegate
- (void)imageDownloaderDownload:(ImageDownloader *)downloader downloadFinished:(NSData *)result
{
    [UserInformation instance].avatar = [[UIImage alloc] initWithData:result];
    imageAvatar.image = [UserInformation instance].avatar;
    activityView.hidden = YES;
}

- (void)imageDownloaderDownload:(ImageDownloader *)downloader encounterError:(NSError *)error
{
    [self showErrorMessage:error.localizedDescription];
    activityView.hidden = YES;
}

#pragma mark - Image Picker Controller Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image= [info objectForKey:UIImagePickerControllerOriginalImage];
    localAvatar = image;
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    [self sendEditAvatarRequest];
    [self restoreWindow];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    [self restoreWindow];
}

#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex > 0){
        [[UserInformation instance] clear];
        [self.tableItems reloadData];
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
    StringResponse *s = response;
    [UserInformation instance].avatarPath = s.response;
    [[NSUserDefaults standardUserDefaults] setObject:s.response forKey:AVATAR_PATH_KEY];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    [avatarDownloader stopDownload];
    [self getAvatar];
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ((UIViewController *)segue.destinationViewController).hidesBottomBarWhenPushed = YES;
    
    if ([segue.destinationViewController isKindOfClass:[LoginViewController class]]){
        LoginViewController *controller = (LoginViewController *)segue.destinationViewController;
        controller.backController = self;
    }
}


@end
