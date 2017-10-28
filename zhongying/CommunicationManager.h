//
//  CommunicationManager.h
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunicationDelegate.h"
#import "LoginRequestParameter.h"
#import "RegisterRequestParameter.h"
#import "SendCodeRequestParameter.h"
#import "SendEmailRequestParameter.h"
#import "GetMyCommunitiesRequestParameter.h"
#import "GetUtilitiesRequestParameter.h"
#import "GetParkingRequestParameter.h"
#import "GetExpressRequestParameter.h"
#import "GetComplaintRequestParameter.h"
#import "GetRepairRequestParameter.h"
#import "AddComplaintRequestParameter.h"
#import "AddRepairRequestParameter.h"
#import "GetRentRequestParameter.h"
#import "GetHouseDetailRequestParameter.h"
#import "GetMyRentRequestParameter.h"
#import "EditRentRequestParameter.h"
#import "AddRentRequestParameter.h"
#import "DeleteRentRequestParameter.h"
#import "GetNotificationRequestParameter.h"
#import "ReadNotificationRequestParameter.h"
#import "GetMyInfoRequestParameter.h"
#import "EditMyInfoRequestParameter.h"
#import "AddEWMRequestParameter.h"
#import "BindCommunityRequestParameter.h"
#import "UnbindCommunityRequestParameter.h"
#import "FetchExpressRequestParameter.h"
#import "UtilitiesDetailResponseParameter.h"
#import "GetUtilitiesDetailRequestParameter.h"
#import "GetParkingDetailRequestParameter.h"
#import "GetCommunityRequestParameter.h"
#import "GetRoomRequestParameter.h"
#import "GetMyUtilitiesRequestParameter.h"
#import "GetMyParkingRequestParameter.h"
#import "GetVoteListRequestParameter.h"
#import "AddVoteRequestParameter.h"
#import "GetMyHobbiesRequestParameter.h"
#import "GetSameHobbyPeopleRequestParameter.h"
#import "GetHobbyMessageRequestParameter.h"
#import "SendHobbyMessageRequestParameter.h"
#import "GetHobbiesRequestParameter.h"
#import "AddHobbyRequestParameter.h"
#import "DeleteHobbyRequestParameter.h"
#import "GetAllHobbyMessagesRequestParameter.h"
#import "GetNeighboursRequestParameter.h"
#import "GetNeighbourMessagesRequestParameter.h"
#import "GetAllNeighbourMessagesRequestParameter.h"
#import "SendNeighbourMessageRequestParameter.h"
#import "GetGroupsRequestParameter.h"
#import "EditPasswordReqeustParameter.h"
#import "GetAddressesRequestParameter.h"
#import "AddAddressRequestParameter.h"
#import "EditAddressRequestParameter.h"
#import "GetUnreadNotificationRequestParameter.h"
#import "UtilitiesPayRequestParameter.h"
#import "ParkingPayRequestParameter.h"
#import "GroupDetailRequestParameter.h"
#import "GetShopsRequestParameter.h"
#import "ShopDetailRequestParameter.h"
#import "GetNewsCategoryRequestParameter.h"
#import "GetNewsRequestParameter.h"
#import "ConfirmOrderRequestParameter.h"
#import "AddGroupOrderRequestParameter.h"
#import "AddReserveOrderRequestParameter.h"
#import "GetOrdersRequestParameter.h"
#import "OrderDetailRequestParameter.h"
#import "DeleteOrderRequestParameter.h"
#import "EditOrderRequestParameter.h"
#import "GetReservesRequestParameter.h"
#import "ReserveDetailRequestParameter.h"
#import "GetMoneyLogRequestParameter.h"
#import "DeleteComplaintRequestParameter.h"
#import "DeleteRepairRequestParameter.h"
#import "ComplaintDetailRequestParameter.h"
#import "RepairDetailRequestParameter.h"
#import "OrderPayRequestParameter.h"
#import "VerifyPhoneRequestParameter.h"
#import "EditAvatarRequestParameter.h"
#import "CommunityDetailRequestParameter.h"
#import "GetAdminMessageRequestParameter.h"
#import "GetAdvertisementsRequestParameter.h"

typedef enum{
    CMLogin,
    CMSendCode,
    CMSendEmail,
    CMRegister,
    CMLogout,
    CMCommunities,
    CMCommunityEWMAdd,
    CMCommunityAdd,
    CMCommunityDelete,
    CMUtilities,
    CMUtilitiesDetail,
    CMParking,
    CMParkingDetail,
    CMExpress,
    CMExpressFetch,
    CMComplaint,
    CMRepair,
    CMComplaintDetail,
    CMRepairDetail,
    CMComplaintAdd,
    CMRepairAdd,
    CMComplaintDelete,
    CMRepairDelete,
    CMRent,
    CMHouseDetail,
    CMMyRent,
    CMRentEdit,
    CMRentAdd,
    CMRentDelete,
    CMNotification,
    CMNotificationRead,
    CMMyInfo,
    CMMyMoney,
    CMMyInfoEdit,
    CMMyPasswordEdit,
    CMMyAddresses,
    CMMyAddressAdd,
    CMMyAddressEdit,
    CMAllCommunities,
    CMAllRooms,
    CMMyUtilities,
    CMMyParkings,
    CMVote,
    CMVoteAdd,
    CMMyHobbies,
    CMSameHobby,
    CMHobbyMessage,
    CMHobbyMessageSend,
    CMHobbies,
    CMHobbyAdd,
    CMHobbyDelete,
    CMAllHobbyMessages,
    CMNeighbours,
    CMNeighbourMessages,
    CMAllNeighbourMessages,
    CMNeighbourMessageSend,
    CMGroups,
    CMGroupDetail,
    CMReserves,
    CMReserveDetail,
    CMAllUnreadNotification,
    CMPayUtilities,
    CMPayParkings,
    CMPayOrder,
    CMShops,
    CMShopDetail,
    CMNewsCategory,
    CMNews,
    CMOrderConfirm,
    CMOrderAdd,
    CMOrders,
    CMOrderDetail,
    CMOrderDelete,
    CMOrderEdit,
    CMPhoneVerify,
    CMAvatarEdit,
    CMCommunityDetail,
    CMAdminMessages,
    CMAdvertisement
}CommunicationMethod;

@interface CommunicationManager : NSObject<NSURLConnectionDataDelegate, NSURLConnectionDelegate>{
    NSURLRequest *currentRequest;
    id<CommunicationDelegate> currentDelegate;
    CommunicationMethod currentMethod;
    NSMutableData *responseData;
}

+ (CommunicationManager *)instance;

- (void)login:(LoginRequestParameter *)request withDelegate:(id<CommunicationDelegate>) delegate;
- (void)sendCode:(SendCodeRequestParameter *)request withUrl:(NSString *)url withDelegate:(id<CommunicationDelegate>) delegate;
- (void)verifyPhone:(VerifyPhoneRequestParameter *)request withDelegate:(id<CommunicationDelegate>) delegate;
- (void)registerUser:(RegisterRequestParameter *)request withDelegate:(id<CommunicationDelegate>) delegate;
- (void)sendEmail:(SendEmailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)logout:(id<CommunicationDelegate>)delegate;

- (void)getMyCommunities:(GetMyCommunitiesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)addCommunityEWM:(AddEWMRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)bindCommunity:(BindCommunityRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)unbindCommunity:(UnbindCommunityRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getUtilities:(GetUtilitiesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getUtilitiesDetail:(GetUtilitiesDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getParking:(GetParkingRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getParkingDetail:(GetParkingDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getExpress:(GetExpressRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)fetchExpress:(FetchExpressRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getComplaint:(GetComplaintRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getRepair:(GetRepairRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getComplaintDetail:(ComplaintDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getRepairDetail:(RepairDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)addComplaint:(AddComplaintRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)addRepair:(AddRepairRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)deleteComplaint:(DeleteComplaintRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)deleteRepair:(DeleteRepairRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getRent:(GetRentRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getHouseDetail:(GetHouseDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getMyRent:(GetMyRentRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)editRent:(EditRentRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)addRent:(AddRentRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)deleteRent:(DeleteRentRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getNotification:(GetNotificationRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)readNotification:(ReadNotificationRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getMyInfo:(GetMyInfoRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getMoneyLog:(GetMoneyLogRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)editMyInfo:(EditMyInfoRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)editPassword:(EditPasswordReqeustParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getAddresses:(GetAddressesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)addAddress:(AddAddressRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)editAddress:(EditAddressRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getAllCommunities:(GetCommunityRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getAllRooms:(GetRoomRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getMyUtilities:(GetMyUtilitiesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getMyParkings:(GetMyParkingRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getVotes:(GetVoteListRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)vote:(AddVoteRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getMyHobbies:(GetMyHobbiesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getSameHobbyPeople:(GetSameHobbyPeopleRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getHobbyMessages:(GetHobbyMessageRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)sendHobbyMessage:(SendHobbyMessageRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getHobbies:(GetHobbiesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)addHobby:(AddHobbyRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)deleteHobby:(DeleteHobbyRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getAllHobbyMessages:(GetAllHobbyMessagesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getNeighbours:(GetNeighboursRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getNeighbourMessages:(GetNeighbourMessagesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getAllNeighbourMessages:(GetAllNeighbourMessagesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)sendNeighbourMessage:(SendNeighbourMessageRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getGroups:(GetGroupsRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getGroupDetail:(GroupDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getReserves:(GetReservesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getReserveDetail:(ReserveDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getUnreadNotifications:(GetUnreadNotificationRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)payUtilities:(UtilitiesPayRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)payParkings:(ParkingPayRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)payOrder:(OrderPayRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getShops:(GetShopsRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getShopDetail:(ShopDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getNewsCategories:(GetNewsCategoryRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getNews:(GetNewsRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)confirmOrder:(ConfirmOrderRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)addGroupOrder:(AddGroupOrderRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)addReserveOrder:(AddReserveOrderRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getOrders:(GetOrdersRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getOrderDetail:(OrderDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)deleteOrder:(DeleteOrderRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)editOrder:(EditOrderRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)editAvatar:(EditAvatarRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getCommunityDetail:(CommunityDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getAdminMessages:(GetAdminMessageRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
- (void)getAdvertisement:(GetAdvertisementsRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate;
@end
