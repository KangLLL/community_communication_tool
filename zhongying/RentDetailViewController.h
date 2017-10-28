//
//  RentDetailViewController.h
//  zhongying
//
//  Created by lk on 14-4-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "HouseDetailResponseParameter.h"
#import "UploadDownloadImageView.h"

@interface RentDetailViewController : ZhongYingBaseViewController<CommunicationDelegate>{
    NSArray *payTypeDescriptions;
    NSArray *rentTypeDescriptions;
}

@property (strong) IBOutlet UILabel *labelTitle;
@property (strong) IBOutlet UILabel *labelName;
@property (strong) IBOutlet UILabel *labelPhone;
@property (strong) IBOutlet UILabel *labelCommunity;
@property (strong) IBOutlet UILabel *labelRentType;
@property (strong) IBOutlet UILabel *labelPayType;
@property (strong) IBOutlet UILabel *labelHouse;
@property (strong) IBOutlet UILabel *labelFloor;
@property (strong) IBOutlet UILabel *labelMoney;
@property (strong) IBOutlet UILabel *labelTime;
@property (strong) IBOutlet UILabel *labelDescription;

@property (strong) IBOutlet NSLayoutConstraint *contentBottomConstraint;
@property (strong) HouseParameter *currentHouse;
@property (strong) IBOutlet UploadDownloadImageView *uploadView;

- (IBAction)dial:(id)sender;

@end
