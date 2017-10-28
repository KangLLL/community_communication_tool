//
//  OrderDetailViewController.h
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "OrderDetailResponseParameter.h"
#import "CommonEnum.h"
#import "AddressesViewController.h"
#import "OrderParameter.h"
#import "ZhiFuBaoWebViewController.h"

typedef enum{
    orderGetMode,
    orderEditMode,
    orderDeleteMode
}OrderMode;

@interface OrderDetailViewController : ZhongYingBaseViewController<CommunicationDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>{
    OrderDetailResponseParameter *currentResponse;
    
    NSString *initialAddressId;
    NSString *initialPayId;
    NSString *initialShipId;
    
    NSString *currentSelectAddressId;
    NSString *currentSelectPayId;
    NSString *currentSelectShipId;
    
    UITableView *tableOptions;
    OrderEditType editType;
    OrderMode currentMode;
    
    BOOL isInitial;
    BOOL isEditable;
    NSInteger currentSelectProduct;
    
    AddressesViewController *selectAddressController;
    float initialHeight;
    
    ZhiFuBaoWebViewController *payWeb;
    NSString *payUrl;
}

@property (strong) IBOutlet UILabel *labelReceiverName;
@property (strong) IBOutlet UILabel *labelPhone;
@property (strong) IBOutlet UILabel *labelAddress;
@property (strong) IBOutlet UILabel *labelPayType;
@property (strong) IBOutlet UILabel *labelPayPrice;
@property (strong) IBOutlet UILabel *labelShipType;
@property (strong) IBOutlet UILabel *labelShipPrice;
@property (strong) IBOutlet UILabel *labelInsurePrice;
@property (strong) IBOutlet UILabel *labelSummaryProductPrice;
@property (strong) IBOutlet UILabel *labelOrderPrice;
@property (strong) IBOutlet UILabel *labelSnNo;
@property (strong) IBOutlet UILabel *labelStatus;

@property (strong) IBOutlet UIView *viewMask;
@property (strong) IBOutlet NSLayoutConstraint *attributeHeight;
@property (strong) IBOutlet NSLayoutConstraint *productHeight;
@property (strong) IBOutlet UITableView *tableProducts;
@property (strong) IBOutlet NSLayoutConstraint *bottom;

@property (strong) IBOutlet UIButton *buttonPay;
@property (strong) IBOutlet UIButton *buttonCancel;
@property (strong) IBOutlet UIButton *buttonModify;

//@property (strong) OrderParameter *order;
@property (strong) NSString *orderId;
@property (strong) UIViewController *finishController;

- (IBAction)selectPay:(id)sender;
- (IBAction)selectShip:(id)sender;
- (IBAction)selectAddress:(id)sender;
- (IBAction)selectDetail:(id)sender;
- (IBAction)editOrder:(id)sender;
- (IBAction)deleteOrder:(id)sender;
- (IBAction)payOrder:(id)sender;

@end
