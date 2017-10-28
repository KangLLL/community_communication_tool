//
//  NeighbourMessageListViewController.h
//  zhongying
//
//  Created by LI K on 15/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "GetAllNeighbourMessagesResponseParameter.h"

@interface NeighbourMessageListViewController : ZhongYingBaseViewController<UITableViewDataSource, UITableViewDelegate, CommunicationDelegate>{
    GetAllNeighbourMessagesResponseParameter *currentResponse;
    int currentSelectIndex;
}

@property (strong) IBOutlet UITableView *tableInformations;


@end
