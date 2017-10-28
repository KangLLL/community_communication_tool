//
//  CommunityDetailViewController.m
//  zhongying
//
//  Created by lk on 14-5-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommunityDetailViewController.h"
#import "UserInformation.h"
#import "CommonUtilities.h"
#import "CommonConsts.h"
#import "CommunityDetailRequestParameter.h"
#import "CommunityDetailResponseParameter.h"

@interface CommunityDetailViewController ()

- (void)sendGetDetailRequest;

@end

@implementation CommunityDetailViewController

@synthesize labelBuildCompany, labelBuildTime, labelComplaintPhone, labelFinishTime, labelName, labelPropertyAdress, labelPropertyPhone, labelPropertyPrice, labelTitle, imagePhoto, webDescription,communityView,buttonGetMore;

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
    
    photoDownloader = [[ImageDownloader alloc] init];
    photoInitialHeight = self.photoHeight.constant;
    
    self.communityView.selectItemImage = [UIImage imageNamed:COMMUNITY_DEFAULT_SELECT_IMAGE_NAME];
    self.communityView.unselectItemImage = [UIImage imageNamed:COMMUNITY_DEFAULT_UNSELECT_IMAGE_NAME];
    
    [self.communityView reloadData];
    [self getMore:self.buttonGetMore];
    
    [self.communityView setSelectIndex:[UserInformation instance].currentCommunityIndex];
    
    self.labelTitle.text = [UserInformation instance].currentCommunity.communityName;
    self.labelName.text = [UserInformation instance].currentCommunity.communityName;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self sendGetDetailRequest];
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
    if(self.communityView.isFolded){
        [self.communityView unfoldView];
        [button setTitle:GET_MORE_COMMUNITY_BUTTON_UNFOLD_TITLE forState:UIControlStateNormal];
        [button setSelected:YES];
    }
    else{
        [self.communityView foldView];
        [button setTitle:GET_MORE_COMMUNITY_BUTTON_FOLD_TITLE forState:UIControlStateNormal];
        [button setSelected:NO];
    }
}

#pragma mark - Private Methods

- (void)sendGetDetailRequest
{
    [photoDownloader stopDownload];
    
    CommunityDetailRequestParameter *request = [[CommunityDetailRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.communityId = [UserInformation instance].currentCommunity.communityId;
    
    [[CommunicationManager instance] getCommunityDetail:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    CommunityDetailResponseParameter *result = (CommunityDetailResponseParameter *)response;
    self.labelTitle.text = result.communityName;
    self.labelPropertyPrice.text = result.propertyPrice;
    self.labelPropertyPhone.text = result.propertyPhone;
    self.labelPropertyAdress.text = result.propertyAddress;
    self.labelName.text = result.communityName;
    self.labelFinishTime.text = result.finishTime;
    self.labelComplaintPhone.text = result.complaintPhone;
    self.labelBuildTime.text = result.buildTime;
    self.labelBuildCompany.text = result.buildCompany;
    
    [self.webDescription loadHTMLString:result.description baseURL:nil];
    
    if(result.communityPhotoUrl == nil || [result.communityPhotoUrl length] == 0){
        self.photoHeight.constant = 0;
    }
    else{
        self.photoHeight.constant = photoInitialHeight;
        [photoDownloader downloadImage:result.communityPhotoUrl withDelegate:self];
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

#pragma mark - Image Download Delegate
- (void)imageDownloaderDownload:(ImageDownloader *)downloader downloadFinished:(NSData *)result
{
    UIImage *photo = [UIImage imageWithData:result];
    self.imagePhoto.image = photo;
}

- (void)imageDownloaderDownload:(ImageDownloader *)downloader encounterError:(NSError *)error
{
    [self showErrorMessage:error.localizedDescription];
    self.photoHeight.constant = 0;
}

#pragma mark - Foldable View Delegate

- (int)numberOfItemInView
{
    return [[UserInformation instance].communities count];
}

- (NSString *)foldableView:(FoldableView *)foldableView titleAtIndex:(int)index
{
    CommunityInformation *comm = [[UserInformation instance] getCommunity:index];
    return comm.communityName;
}

- (void)foldableView:(FoldableView *)foldableView didSelectAtIndex:(int)index
{
    [UserInformation instance].currentCommunityIndex = index;
    [self sendGetDetailRequest];
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
