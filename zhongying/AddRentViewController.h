//
//  AddRentViewController.h
//  zhongying
//
//  Created by LI K on 16/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import "InputViewController.h"
#import "CommunicationManager.h"
#import "AddRentRequestParameter.h"
#import "CommunityInformation.h"
#import "MyHouseParameter.h"
#import "ImageInformation.h"
#import "ImageDownloader.h"
#import "UploadDownloadImageView.h"
#import "HouseDetailResponseParameter.h"

typedef enum{
    addRentCommunity,
    addRentPayType,
    addRentRentType,
    addRentPhoto
}AddRentSelectionType;


@interface AddRentViewController : InputViewController<UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CommunicationDelegate>{
    UITableView *tableOptions;
    AddRentSelectionType currentSelection;
    NSArray *payTypeDescriptions;
    NSArray *rentTypeDescriptions;
    
    CommunityInformation *selectCommunity;
    //RentPayType selectPayType;
    //RentType selectRentType;
    
    UIView *focusController;
    float initialBottomConst;
    float initialContentConst;
    
    CGRect windowFrame;
    CGRect windowBounds;
    UIWindow *window;
    
    HouseDetailResponseParameter *currentResponse;
}

@property (strong) IBOutlet UITextField *textName;
@property (strong) IBOutlet UITextField *textPhone;
@property (strong) IBOutlet UITextField *textCommunity;
@property (strong) IBOutlet UITextField *textPayType;
@property (strong) IBOutlet UITextField *textRentType;
@property (strong) IBOutlet UITextField *textShi;
@property (strong) IBOutlet UITextField *textTing;
@property (strong) IBOutlet UITextField *textWei;
@property (strong) IBOutlet UITextField *textArea;
@property (strong) IBOutlet UITextField *textFloor;
@property (strong) IBOutlet UITextField *textTotalFloor;
@property (strong) IBOutlet UITextField *textMoney;
@property (strong) IBOutlet UITextField *textTitle;
@property (strong) IBOutlet UITextField *textDescription;
@property (strong) IBOutlet UITextField *textPhoto;

@property (strong) IBOutlet UIScrollView *scrollContent;
@property (strong) IBOutlet UIView *viewMask;

@property (strong) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (strong) IBOutlet NSLayoutConstraint *contentBottomConstraint;

@property (strong) IBOutlet UploadDownloadImageView *uploadView;

@property (strong) MyHouseParameter *currentHouse;

- (IBAction)addRent:(id)sender;
- (IBAction)returnToList:(id)sender;

@end
