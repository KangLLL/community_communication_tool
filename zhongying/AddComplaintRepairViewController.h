//
//  AddRepairViewController.h
//  zhongying
//
//  Created by lik on 14-4-5.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "InputViewController.h"
#import "SelectFoldableView.h"
#import "CommunicationDelegate.h"
#import "UploadDownloadImageView.h"

@interface AddComplaintRepairViewController : InputViewController<UITextViewDelegate,FoldableViewDataDelegate,FoldableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CommunicationDelegate, UITableViewDataSource, UITableViewDelegate>{
    UIView *focusController;
    
    UITableView *tableOptions;
    NSInteger currentSelectRoom;
    
    int currentImageCount;
    
    CGRect windowFrame;
    CGRect windowBounds;
    UIWindow *window;
}

@property (strong) IBOutlet SelectFoldableView *communitiesView;
@property (strong) IBOutlet NSLayoutConstraint *bottomConstrains;
@property (strong) IBOutlet NSLayoutConstraint *photoConstrain;

@property (strong) IBOutlet UILabel *labelCommunity;
@property (strong) IBOutlet UITextField *textName;
@property (strong) IBOutlet UITextField *textPhone;
@property (strong) IBOutlet UITextField *textTitle;
@property (strong) IBOutlet UITextView *textContent;

@property (strong) IBOutlet UIImageView *imagePhoto1;
@property (strong) IBOutlet UIImageView *imagePhoto2;
@property (strong) IBOutlet UIImageView *imagePhoto3;
@property (strong) IBOutlet UIView *viewContent;

@property (strong) IBOutlet UILabel *labelHeadTitle;
@property (strong) IBOutlet UILabel *labelTips;
@property (strong) IBOutlet UILabel *labelContentPlaceholder;

@property (strong) IBOutlet UIView *viewMask;
@property (strong) IBOutlet UILabel *labelRoomNo;

@property (assign) BOOL isComplaint;

- (IBAction)getMore:(id)sender;
- (IBAction)selectRoom:(id)sender;
- (IBAction)getCameraPhoto:(id)sender;
- (IBAction)getAlbumPhoto:(id)sender;

- (IBAction)addRepair:(id)sender;

@end
