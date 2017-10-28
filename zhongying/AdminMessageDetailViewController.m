//
//  AdminMessageDetailViewController.m
//  zhongying
//
//  Created by lk on 14-5-27.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AdminMessageDetailViewController.h"
#import "UserInformation.h"
#import "CommonUtilities.h"
#import "ReadNotificationRequestParameter.h"

#define CONTENT_TOP_MARGIN              4
#define CONTENT_LEFT_MARGIN             2
#define CONTENT_WIDTH                   306
#define CONTENT_BOTTOM_MARGIN           4
#define CONTENT_RIGHT_MARGIN            2

#define NOTIFICATION_TIME_TEXT_FORMAT   @"通知时间:%@"

@interface AdminMessageDetailViewController ()

- (void)sendReadNotification;

@end

@implementation AdminMessageDetailViewController

@synthesize labelTime, labelTitle, scrollContent, adminMessage;

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
    self.labelTime.text = [NSString stringWithFormat:NOTIFICATION_TIME_TEXT_FORMAT,self.adminMessage.time];
    self.labelTitle.text = self.adminMessage.title;
    
    UILabel *content = [[UILabel alloc] init];
    UIFont *font = [UIFont systemFontOfSize:11];
    content.font = font;
    content.numberOfLines = 0;
    content.text = self.adminMessage.content;
    content.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize contentSize = [self.adminMessage.content sizeWithFont:font constrainedToSize:CGSizeMake(CONTENT_WIDTH, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    content.frame = CGRectMake(CONTENT_LEFT_MARGIN, CONTENT_RIGHT_MARGIN, contentSize.width, contentSize.height);
    
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CONTENT_WIDTH + CONTENT_LEFT_MARGIN + CONTENT_RIGHT_MARGIN, contentSize.height + CONTENT_TOP_MARGIN + CONTENT_BOTTOM_MARGIN)];
    
    //background.backgroundColor = [UIColor lightGrayColor];
    //background.layer.borderColor = [UIColor blackColor].CGColor;
    //background.layer.borderWidth = 1;
    
    [self.scrollContent addSubview:background];
    [self.scrollContent addSubview:content];
    
    self.scrollContent.contentSize = CGSizeMake(0, background.frame.size.height);
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    if(self.adminMessage.messageStatus == messageUnreaded){
        [self sendReadNotification];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)sendReadNotification
{
    ReadNotificationRequestParameter *request = [[ReadNotificationRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.messageId = self.adminMessage.messageId;
    
    [[CommunicationManager instance] readNotification:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}


#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
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
