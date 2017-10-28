//
//  GroupDetailViewController.h
//  zhongying
//
//  Created by lk on 14-4-20.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "DownloadCacher.h"
#import "GroupParameter.h"
#import "GroupViewController.h"
#import "GroupDetailResponseParameter.h"
#import "GroupAttributeCell.h"
#import "GroupDetailContentCell.h"

@interface GroupDetailViewController : ZhongYingBaseViewController<UITableViewDataSource, UITableViewDelegate, CommunicationDelegate, AttributeSelectionChangeDelegate>{
    GroupDetailResponseParameter *currentResponse;
    DownloadCacher *cacher;
    
    int quantity;
    UILabel *labelQuantity;
    
    GroupAttributeCell *cellAttribute;
    UILabel *labelGroupPrice;
    GroupDetailContentCell *contentCell;
    
    BOOL isConfirming;
}

@property (strong) IBOutlet UITableView *tableInformations;
@property (strong) GroupViewController *groupList;
@property (strong) NSString *groupId;

- (IBAction)addQuantity:(id)sender;
- (IBAction)subQuantity:(id)sender;
- (IBAction)displayProductDetail:(id)sender;
- (IBAction)buy:(id)sender;
- (IBAction)showOtherGroup:(id)sender;
@end
