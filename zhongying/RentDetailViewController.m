//
//  RentDetailViewController.m
//  zhongying
//
//  Created by lk on 14-4-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "RentDetailViewController.h"
#import "UserInformation.h"
#import "CommonUtilities.h"
#import "GetHouseDetailRequestParameter.h"
#import "HouseDetailResponseParameter.h"

@interface RentDetailViewController ()

- (void)sendGetHouseDetailRequest;

@end

@implementation RentDetailViewController

@synthesize labelCommunity, labelDescription, labelFloor, labelHouse, labelMoney, labelName, labelPayType, labelPhone, labelRentType, labelTime, labelTitle, contentBottomConstraint, currentHouse, uploadView;

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
    
    //payTypeDescriptions = [NSArray arrayWithObjects:@"压一付三",@"压一付一",@"半年付",@"年付",@"面议", nil];
    //rentTypeDescriptions = [NSArray arrayWithObjects:@"整租",@"合租",@"短期出租",@"出售", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self sendGetHouseDetailRequest];
}

#pragma mark - Button Actions
- (IBAction)dial:(id)sender
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.labelPhone.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

#pragma mark - Private Methods

- (void)sendGetHouseDetailRequest
{
    GetHouseDetailRequestParameter *request = [[GetHouseDetailRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.messageId = self.currentHouse.messageId;
    [[CommunicationManager instance] getHouseDetail:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    HouseDetailResponseParameter *param = response;
    self.labelTitle.text = param.tile;
    self.labelTime.text = param.time;
    self.labelName.text = param.contactName;
    NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:param.contactPhone];
    NSDictionary *attributes = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInt:1]};
    NSRange range = [param.contactPhone rangeOfString:param.contactPhone];
    [styledText setAttributes:attributes range:range];
    self.labelPhone.attributedText = styledText;
    
    self.labelCommunity.text = [[UserInformation instance] currentCommunity].communityName;
    self.labelTime.text = param.time;
    self.labelMoney.text = [param.rentType isEqualToString:@"出售"] ? [NSString stringWithFormat:@"%@万元",param.price] : [NSString stringWithFormat:@"%@元", param.price];
    self.labelPayType.text = param.payType;
    self.labelRentType.text = param.rentType;

    self.labelHouse.text = [NSString stringWithFormat:@"%d室%d厅%d卫共%@平方米",param.totalRoom,param.totalLobby,param.totalToilet, param.size];
    self.labelFloor.text = [NSString stringWithFormat:@"第%@层 共%@层",param.floorNo, param.totalFloor];
    
    CGSize textSize = [param.debugDescription sizeWithFont:self.labelDescription.font constrainedToSize:CGSizeMake(self.labelDescription.frame.size.width, self.labelDescription.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect newFrame = self.labelDescription.frame;
    newFrame.size.height = textSize.height;
    self.labelDescription.text = param.description;
    self.labelDescription.frame =newFrame;
    
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
        [self.uploadView downloadServerImage:array];
        self.contentBottomConstraint.constant += 96;
    }
    else{
        self.uploadView.hidden = YES;
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
