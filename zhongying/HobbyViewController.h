//
//  HobbyViewController.h
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "EditFoldableView.h"
#import "CommunicationDelegate.h"
#import "GetMyHobbiesResponseParameter.h"
#import "GetSameHobbyResponseParameter.h"
#import "MultiplySelectPopupView.h"
#import "GetHobbiesResponseParameter.h"
#import "EGORefreshTableHeaderView.h"
#import "PageDataManager.h"

typedef enum{
    hobbyGetMyHobbies,
    hobbyGetSamePeople,
    hobyyGetHobbies,
    hobbyAddMyHobby,
    hobbyAddHobby,
    hobbyDeleteHobby
}HobbyFunction;

typedef enum{
    hobbyPeopleFilterCommunity,
    hobbyPeopleFilterBuild,
    hobbyPeopleFilterFloor,
    hobbyPeopleFilterRoom
}HobbyPeopleFilterType;

@interface HobbyViewController : ZhongYingBaseViewController<FoldableViewDataDelegate, EditFoldableViewDelegate, UITableViewDataSource, UITableViewDelegate, CommunicationDelegate, PopupViewDataDelegate, PopupViewDelegate,UITextFieldDelegate,EGORefreshTableHeaderDelegate>{
    GetSameHobbyResponseParameter *currentSameHobbyPeopleResponse;
    GetHobbiesResponseParameter *currentHobbies;
    int currentSelectIndex;
    
    HobbyFunction currentFunction;
    int addHobbyIndex;
    int deleteHobbyIndex;
    
    BOOL isInitial;
    MultiplySelectPopupView *addMyHobbyView;
    
    HobbyPeopleFilterType currentFilterType;
    NSMutableArray *arrayBuild;
    NSMutableArray *arrayFloor;
    NSMutableArray *arrayRoom;
    UITableView *tableOptions;
    NSString *filterCommunityId;
    NSString *filterBuildId;
    NSString *filterFloorId;
    NSString *filterRoomId;
    
    EGORefreshTableHeaderView *refreshHeaderView;
    PageDataManager *sameHobbyDataManager;
    BOOL isReloading;
}

@property (strong) IBOutlet UITableView *tableInformations;
@property (strong) IBOutlet EditFoldableView *hobbiesView;
@property (strong) IBOutlet UILabel *labelPeopleCount;

@property (strong) IBOutlet UIButton *buttonAddMyHobby;
@property (strong) IBOutlet UIButton *buttonAddHobby;
@property (strong) IBOutlet UIButton *buttonDeleteHobby;

@property (strong) IBOutlet UIButton *buttonGetMore;

//@property (strong) IBOutlet NSLayoutConstraint *tableHeight;
//@property (strong) IBOutlet MultiplySelectPopupView *addMyHobbyView;
@property (strong) IBOutlet UIView *viewMask;

@property (strong) IBOutlet NSLayoutConstraint *textBottomSpace;
@property (strong) IBOutlet UITextField *textHobbyName;

- (IBAction)getMore:(id)sender;
- (IBAction)addMyHobby:(id)sender;
- (IBAction)addNewHobby:(id)sender;
- (IBAction)deleteHobby:(id)sender;
- (IBAction)sendMessage:(id)sender;

- (IBAction)filterCommunity:(id)sender;
- (IBAction)filterBuild:(id)sender;
- (IBAction)filterFloor:(id)sender;
- (IBAction)filterRoom:(id)sender;
@end
