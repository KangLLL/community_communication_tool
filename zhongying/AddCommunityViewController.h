//
//  AddCommunityViewController.h
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "InputViewController.h"
#import "CommunicationDelegate.h"
#import "RegionInformation.h"
#import "GetCommunityResponseParameter.h"
#import "GetCommunityRoomResponseParameter.h"
#import "CommunityInfoParameter.h"
#import "BuildParameter.h"
#import "FloorParameter.h"
#import "RoomParameter.h"

typedef enum{
    addSelectProvince,
    addSelectCity,
    addSelectDistrict,
    addSelectCommunity,
    addSelectBuild,
    addSelectFloor,
    addSelectRoom,
    addSelectName,
    addBind
}SelectionType;

@interface AddCommunityViewController : InputViewController<CommunicationDelegate, UITableViewDelegate, UITableViewDataSource>{
    SelectionType currentSelection;
    
    RegionInformation *currentProvince;
    RegionInformation *currentCity;
    RegionInformation *currentDistrict;
    
    GetCommunityResponseParameter *currentCommunityResponse;
    GetCommunityRoomResponseParameter *currentRoomResponse;
    
    CommunityInfoParameter *currentCommunity;
    BuildParameter *currentBuild;
    FloorParameter *currentFloor;
    RoomParameter *currentRoom;
    
    UITableView *tableOptions;
    float initialConst;
}

@property (strong) IBOutlet UIView *viewMask;

@property (strong) IBOutlet UITextField *textProvince;
@property (strong) IBOutlet UITextField *textCity;
@property (strong) IBOutlet UITextField *textDisctrict;
@property (strong) IBOutlet UITextField *textCommunity;
@property (strong) IBOutlet UITextField *textBuild;
@property (strong) IBOutlet UITextField *textFloor;
@property (strong) IBOutlet UITextField *textRoom;
@property (strong) IBOutlet UITextField *textOwnerName;

@property (strong) IBOutlet NSLayoutConstraint *constraint;

- (IBAction)reset:(id)sender;
- (IBAction)addBind:(id)sender;

@end
