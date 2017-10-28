//
//  HobbyMessageListViewController.h
//  zhongying
//
//  Created by LI K on 15/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "GetAllHobbyMessageResponseParameter.h"


@interface HobbyMessageListViewController : ZhongYingBaseViewController<UITableViewDataSource, UITableViewDelegate, CommunicationDelegate>{
    GetAllHobbyMessageResponseParameter *currentResponse;
    int currentSelectIndex;
}

@property (strong) IBOutlet UITableView *tableInformations;

@end
