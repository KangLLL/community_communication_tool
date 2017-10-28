//
//  ComplaintRepairDetailViewController.m
//  zhongying
//
//  Created by lk on 14-4-26.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ComplaintRepairDetailViewController.h"
#import "RepairDetailRequestParameter.h"
#import "ComplaintDetailRequestParameter.h"
#import "CommonUtilities.h"
#import "UserInformation.h"

@interface ComplaintRepairDetailViewController ()

- (void)sendGetRepairDetailRequest;
- (void)sendGetComplaintDetailRequest;

@end

@implementation ComplaintRepairDetailViewController

@synthesize iamgeUnhandle, imageHandle, labelComment, labelContent, labelName, labelTime, labelTitle, labelTypeTitle, repair, complaint, bottomConstraints, viewImages, imageView1, imageView2, imageView3, activityView1, activityView2, activityView3;

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
    if(self.complaint != nil){
        self.labelTypeTitle.text = @"投诉详细";
    }
    else{
        self.labelTypeTitle.text = @"故障详细";
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    if(self.complaint != nil){
        [self sendGetComplaintDetailRequest];
    }
    else{
        [self sendGetRepairDetailRequest];
    }
}

#pragma mark - Private Delegate

- (void)sendGetComplaintDetailRequest
{
    ComplaintDetailRequestParameter *request = [[ComplaintDetailRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.messageId = self.complaint.messageId;
    
    [[CommunicationManager instance] getComplaintDetail:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendGetRepairDetailRequest
{
    RepairDetailRequestParameter *request = [[RepairDetailRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.messageId = self.repair.messageId;
    
    [[CommunicationManager instance] getRepairDetail:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}


#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    [[CommonUtilities instance] hideNetworkConnecting];
    if(self.complaint != nil){
        currentComplaint = response;
        self.labelComment.text = currentComplaint.comment;
        self.labelContent.text = currentComplaint.content;
        self.labelName.text = [NSString stringWithFormat:@"%@(%@-%@-%@)",[[UserInformation instance] currentCommunity].communityName, currentComplaint.buildNo, currentComplaint.floorNo, currentComplaint.roomNo];
        self.labelTime.text =currentComplaint.time;
        self.labelTitle.text = currentComplaint.messageTitle;
        
        BOOL isHaveImage = NO;
        if(currentComplaint.image1Url != nil && [currentComplaint.image1Url length] > 0){
            isHaveImage = YES;
            ImageDownloader *downloader = [[ImageDownloader alloc] init];
            [downloader downloadImage:currentComplaint.image1Url withDelegate:self];
            [self.activityView1 startAnimating];
        }
        else{
            self.imageView1.hidden = YES;
            self.activityView1.hidden = YES;
        }
        if(currentComplaint.image2Url != nil && [currentComplaint.image2Url length] > 0){
            isHaveImage = YES;
            ImageDownloader *downloader = [[ImageDownloader alloc] init];
            [downloader downloadImage:currentComplaint.image2Url withDelegate:self];
            [self.activityView2 startAnimating];
        }
        else{
            self.imageView2.hidden = YES;
            self.activityView2.hidden = YES;
        }
        if(currentComplaint.image3Url != nil && [currentComplaint.image3Url length] > 0){
            isHaveImage = YES;
            ImageDownloader *downloader = [[ImageDownloader alloc] init];
            [downloader downloadImage:currentComplaint.image3Url withDelegate:self];
            [self.activityView3 startAnimating];
        }
        else{
            self.imageView3.hidden = YES;
            self.activityView3.hidden = YES;
        }
        if(isHaveImage){
            self.viewImages.hidden = NO;
            self.bottomConstraints.constant += 98;
        }
    }
    else{
        currentRepair = response;
        self.labelComment.text = currentRepair.comment;
        self.labelContent.text = currentRepair.content;
        self.labelName.text = [NSString stringWithFormat:@"%@(%@-%@-%@)",[[UserInformation instance] currentCommunity].communityName, currentRepair.buildNo, currentRepair.floorNo, currentRepair.roomNo];
        self.labelTime.text =currentRepair.time;
        self.labelTitle.text = currentRepair.messageTitle;
        
        BOOL isHaveImage = NO;
        if(currentRepair.image1Url != nil && [currentRepair.image1Url length] > 0){
            isHaveImage = YES;
            ImageDownloader *downloader = [[ImageDownloader alloc] init];
            [downloader downloadImage:currentRepair.image1Url withDelegate:self];
            [self.activityView1 startAnimating];
        }
        else{
            self.imageView1.hidden = YES;
            self.activityView1.hidden = YES;
        }
        if(currentRepair.image2Url != nil && [currentRepair.image2Url length] > 0){
            isHaveImage = YES;
            ImageDownloader *downloader = [[ImageDownloader alloc] init];
            [downloader downloadImage:currentRepair.image2Url withDelegate:self];
            [self.activityView2 startAnimating];
        }
        else{
            self.imageView2.hidden = YES;
            self.activityView2.hidden = YES;
        }
        if(currentRepair.image3Url != nil && [currentRepair.image3Url length] > 0){
            isHaveImage = YES;
            ImageDownloader *downloader = [[ImageDownloader alloc] init];
            [downloader downloadImage:currentRepair.image3Url withDelegate:self];
            [self.activityView3 startAnimating];
        }else{
            self.imageView3.hidden = YES;
            self.activityView3.hidden = YES;
        }
        if(isHaveImage){
            self.viewImages.hidden = NO;
            self.bottomConstraints.constant += 98;
        }
    }
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

#pragma mark - Image Downloader Delegate

- (void)imageDownloaderDownload:(ImageDownloader *)downloader downloadFinished:(NSData *)result
{
    NSString *image = [downloader getUrl];
    if(currentComplaint != nil){
        if([image isEqualToString:currentComplaint.image1Url]){
            self.imageView1.image = [UIImage imageWithData:result];
            self.activityView1.hidden = YES;
        }
        else if([image isEqualToString:currentComplaint.image2Url]){
            self.imageView2.image = [UIImage imageWithData:result];
            self.activityView2.hidden = YES;
        }
        else{
            self.imageView3.image = [UIImage imageWithData:result];
            self.activityView3.hidden = YES;
        }
    }
    else{
        if([image isEqualToString:currentRepair.image1Url]){
            self.imageView1.image = [UIImage imageWithData:result];
            self.activityView1.hidden = YES;
        }
        else if([image isEqualToString:currentRepair.image2Url]){
            self.imageView2.image = [UIImage imageWithData:result];
            self.activityView2.hidden = YES;
        }
        else{
            self.imageView3.image = [UIImage imageWithData:result];
            self.activityView3.hidden = YES;
        }

    }
}

-(void)imageDownloaderDownload:(ImageDownloader *)downloader encounterError:(NSError *)error
{
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
