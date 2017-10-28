//
//  CommunicationManager.m
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommunicationManager.h"
#import "NSURLRequest+RequestBuilder.h"
#import "RequestParameter.h"
#import "ResponseParameter.h"
#import "LoginResponseParameter.h"
#import "SendCodeResponseParameter.h"
#import "RegisterResponseParameter.h"
#import "GetMyCommunitiesResponseParameter.h"
#import "GetUtilitiesResponseParameter.h"
#import "GetParkingResponseParameter.h"
#import "GetExpressResponseParameter.h"
#import "GetComplaintResponseParameter.h"
#import "GetRepairResponseParameter.h"
#import "ComplaintParameter.h"
#import "RepairParameter.h"
#import "GetRentResponseParameter.h"
#import "HouseDetailResponseParameter.h"
#import "GetMyRentResponseParameter.h"
#import "GetNotificationResponseParameter.h"
#import "GetMyInfoResponseParameter.h"
#import "UtilitiesDetailResponseParameter.h"
#import "ParkingDetailResponseParameter.h"
#import "GetCommunityResponseParameter.h"
#import "GetMyUtilitiesResponseParameter.h"
#import "GetMyParkingResponseParameter.h"
#import "GetCommunityRoomResponseParameter.h"
#import "GetVoteListResponseParameter.h"
#import "GetMyHobbiesResponseParameter.h"
#import "GetHobbyMessageResponseParameter.h"
#import "GetSameHobbyResponseParameter.h"
#import "GetHobbiesResponseParameter.h"
#import "GetAllHobbyMessageResponseParameter.h"
#import "GetNeighboursResponseParameter.h"
#import "GetNeighbourMessagesResponseParameter.h"
#import "GetAllNeighbourMessagesResponseParameter.h"
#import "GetGroupsResponseParameter.h"
#import "GroupDetailResponseParameter.h"
#import "GetAddressesResponseParameter.h"
#import "GetUnreadNotificationResponseParameter.h"
#import "GetShopsResponseParameter.h"
#import "ShopDetailResponseParameter.h"
#import "GetNewsCategoryResponseParameter.h"
#import "GetNewsResponseParameter.h"
#import "ConfirmOrderResponseParameter.h"
#import "AddOrderResponseParameter.h"
#import "GetOrdersResponseParameter.h"
#import "OrderDetailResponseParameter.h"
#import "GetMoneyLogResponseParameter.h"
#import "ComplaintDetailResponseParameter.h"
#import "RepairDetailResponseParameter.h"
#import "CommunityDetailResponseParameter.h"
#import "GetAdminMessageResponseParameter.h"
#import "GetAdvertisementsResponseParameter.h"
#import "StringResponse.h"

#define HOST_URL                            @"http://demo.deepinfo.cn/zy/mobile/index.php"
//#define HOST_URL                            @"http://www.100mlife.cn/app_interface/index.php"
#define API_LOGIN_URL                       @"/Demand/login"
#define API_LOGOUT_URL                      @"/Index/logout"
#define API_VERIFY_PHONE_URL                @"/Demand/sendCode"
#define API_SEND_CODE_URL                   @"http://www.xiaohuangquan.com/app_code.php"
#define API_REGISTER_URL                    @"/Demand/register"
#define API_SEND_EMAIL_URL                  @"/Demand/sendMail"
#define API_GET_MY_COMMUNITY_URL            @"/Index/myCommList"
#define API_GET_UTILITIES_URL               @"/Index/getCostList"
#define API_GET_PARKINGS_URL                @"/Index/getCostList"
#define API_GET_EXPRESS_URL                 @"/Index/getKd"
#define API_GET_COMPLAINT_URL               @"/Index/getComplaintList"
#define API_GET_REPAIR_URL                  @"/Index/getComplaintList"
#define API_GET_COMPLAINT_DETAIL_URL        @"/Index/getComplaintInfo"
#define API_GET_REPAIR_DETAIL_URL           @"/Index/getComplaintInfo"
#define API_ADD_COMPLAINT_URL               @"/Index/addComplaint"
#define API_ADD_REPAIR_URL                  @"/Index/addComplaint"
#define API_DELETE_COMPLAINT_URL            @"/Index/delComplaint"
#define API_DELETE_REPAIR_URL               @"/Index/delComplaint"
#define API_GET_RENT_URL                    @"/Index/rentHouseList"
#define API_GET_HOUSE_DETAIL_URL            @"/Index/rentHouseInfo"
#define API_GET_MY_RENT_URL                 @"/Index/myRentHouse"
#define API_EDIT_RENT_URL                   @"/Index/editRentHouse"
#define API_ADD_RENT_URL                    @"/Index/addRentHouse"
#define API_DELETE_RENT_URL                 @"/Index/delRentHouse"
#define API_GET_NOTIFICATION_URL            @"/Index/pushMsg"
#define API_READ_NOTIFICATION_URL           @"/Index/changeMsg"
#define API_GET_MY_INFO_URL                 @"/Index/myInfo"
#define API_EDIT_MY_INFO_URL                @"/Index/editMyInfo"
#define API_ADD_EWM_URL                     @"/Index/addewn"
#define API_ADD_HOUSE_URL                   @"/Index/addHouse"
#define API_DELETE_HOUSE_URL                @"/Index/delMyHouse"
#define API_FETCH_EXPRESS_URL               @"/Index/changeKd"
#define API_GET_UTILITIES_DETAIL_URL        @"/Index/getCostInfo"
#define API_GET_PARKING_DETAIL_URL          @"/Index/getCostInfo"
#define API_GET_ALL_COMMUNITIES_URL         @"/Demand/getCity"
#define API_GET_ALL_ROOMS_URL               @"/Demand/getBuild"
#define API_GET_MY_UTILITIES_URL            @"/Index/getPayList"
#define API_GET_MY_PARKINGS_URL             @"/Index/getPayList"
#define API_GET_VOTES_URL                   @"/Index/voteList"
#define API_ADD_VOTE_URL                    @"/Index/addVote"
#define API_GET_MY_HOBBIES_URL              @"/Index/getHobby"
#define API_GET_SAME_HOBBY_URL              @"/Index/sameHobby"
#define API_GET_HOBBY_MESSAGE_URL           @"/Index/hobbyMsg"
#define API_SEND_HOBBY_MESSAGE_URL          @"/Index/sendHobbyMsg"
#define API_GET_HOBBIES_URL                 @"/Index/hobbyList"
#define API_ADD_HOBBY_URL                   @"/Index/addHobby"
#define API_DELETE_HOBBY_URL                @"/Index/delHobby"
#define API_GET_ALL_HOBBY_MESSAGE_URL       @"/Index/sameHobbyList"
#define API_GET_NEIGHBOURS_URL              @"/Index/neighbourList"
#define API_GET_NEIGHBOUR_MESSAGE_URL       @"/Index/neighbourMsg"
#define API_GET_ALL_NEIGHBOUR_MESSAGE_URL   @"/Index/neighbourMsgList"
#define API_SEND_NEIGHBOUR_MESSAGE_URL      @"/Index/sendnbMsg"
#define API_GET_GROUPS_URL                  @"/Index/groupList"
#define API_GET_GROUP_DETAIL_URL            @"/Index/groupInfo"
#define API_EDIT_PASSWORD_URL               @"/Index/editpwd"
#define API_GET_ADDRESSES_URL               @"/Index/addressList"
#define API_ADD_ADDRESS_URL                 @"/Index/addAddress"
#define API_EDIT_ADDRESS_URL                @"/Index/editAddress"
#define API_GET_UNREAD_NOTIFICATIONS_URL    @"/Index/getMsg"
#define API_PAY_URL                         @"/Index/payment"
#define API_GET_SHOPS_URL                   @"/Demand/shoplist"
#define API_GET_SHOP_DETAIL_URL             @"/Demand/shopInfo"
#define API_GET_NEWS_CATEGORY_URL           @"/Index/getNewspaperCategorys"
#define API_GET_NEWS_URL                    @"/Index/getNewspaperArticles"
#define API_CONFIRM_ORDER_URL               @"/Index/orderConfirm"
#define API_ADD_ORDER_URL                   @"/Index/addOrder"
#define API_GET_ORDERS_URL                  @"/Index/myOrderList"
#define API_GET_ORDER_DETAIL_URL            @"/Index/myOrderInfo"
#define API_DELETE_ORDER_URL                @"/Index/delOrder"
#define API_EDIT_ORDER_URL                  @"/Index/editOrder"
#define API_GET_MONEY_LOG_URL               @"/Index/moneyLog"
#define API_EDIT_AVATAR_URL                 @"/Index/editAvatar"
#define API_GET_COMMUNITY_DETAIL_URL        @"/Demand/getCommunityInfo"
#define API_GET_ADMIN_MESSAGE_URL           @"/Index/adminMsg"
#define API_GET_ADVERTISEMENT_URL           @"/Demand/getCommAdver"

#define RESPONSE_STATUS             @"status"
#define RESPONSE_MESSAGE            @"msg"
#define RESPONSE_DATA               @"data"


static CommunicationManager *s_Sigleton;

@interface CommunicationManager ()

- (id<ResponseParameter>)constructResponse;
- (void)communitionServer:(id<RequestParameter>)request api:(NSString *)apiUrl withDelegate:(id<CommunicationDelegate>)delegate;
- (void)communitionServer:(id<RequestParameter>)request url:(NSString *)apiUrl withDelegate:(id<CommunicationDelegate>)delegate method:(MethodType)methodType;
- (NSDictionary *)trimKeys:(NSDictionary *)dict;

@end


@implementation CommunicationManager

+ (CommunicationManager *)instance
{
    if(s_Sigleton == nil){
        s_Sigleton = [[CommunicationManager alloc] init];
    }
    return s_Sigleton;
}
#pragma mark - Public Method

- (void)login:(LoginRequestParameter *)request withDelegate:(id<CommunicationDelegate>) delegate
{
    currentMethod = CMLogin;
    [self communitionServer:request api:API_LOGIN_URL withDelegate:delegate];
}

- (void)sendCode:(SendCodeRequestParameter *)request withUrl:(NSString *)url withDelegate:(id<CommunicationDelegate>) delegate
{
    currentMethod = CMSendCode;
    NSString *u = [NSString stringWithFormat:@"%@%@",url, request.phoneNumber];
    [self communitionServer:nil url:u withDelegate:delegate method:MethodGet];
}

- (void)verifyPhone:(VerifyPhoneRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMPhoneVerify;
    [self communitionServer:request api:API_VERIFY_PHONE_URL withDelegate:delegate];
}

- (void)registerUser:(RegisterRequestParameter *)request withDelegate:(id<CommunicationDelegate>) delegate
{
    currentMethod = CMRegister;
    [self communitionServer:request api:API_REGISTER_URL withDelegate:delegate];
}

- (void)sendEmail:(SendEmailRequestParameter *)request withDelegate:(id<CommunicationDelegate>) delegate
{
    currentMethod = CMSendEmail;
    [self communitionServer:request api:API_SEND_EMAIL_URL withDelegate:delegate];
}

- (void)logout:(id<CommunicationDelegate>) delegate
{
    currentMethod = CMLogout;
    [self communitionServer:nil api:API_LOGOUT_URL withDelegate:delegate];
}

- (void)getMyCommunities:(GetMyCommunitiesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMCommunities;
    [self communitionServer:request api:API_GET_MY_COMMUNITY_URL withDelegate:delegate];
}

- (void)addCommunityEWM:(AddEWMRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMCommunityEWMAdd;
    [self communitionServer:request api:API_ADD_EWM_URL withDelegate:delegate];
}

- (void)bindCommunity:(BindCommunityRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMCommunityAdd;
    [self communitionServer:request api:API_ADD_HOUSE_URL withDelegate:delegate];
}

- (void)unbindCommunity:(UnbindCommunityRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMCommunityDelete;
    [self communitionServer:request api:API_DELETE_HOUSE_URL withDelegate:delegate];
}

- (void)getUtilities:(GetUtilitiesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMUtilities;
    [self communitionServer:request api:API_GET_UTILITIES_URL withDelegate:delegate];
}

- (void)getUtilitiesDetail:(GetUtilitiesDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMUtilitiesDetail;
    [self communitionServer:request api:API_GET_UTILITIES_DETAIL_URL withDelegate:delegate];
}

- (void)getParking:(GetParkingRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMParking;
    [self communitionServer:request api:API_GET_PARKINGS_URL withDelegate:delegate];
}

- (void)getParkingDetail:(GetParkingDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMParkingDetail;
    [self communitionServer:request api:API_GET_PARKING_DETAIL_URL withDelegate:delegate];
}

- (void)getExpress:(GetExpressRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMExpress;
    [self communitionServer:request api:API_GET_EXPRESS_URL withDelegate:delegate];
}

- (void)fetchExpress:(FetchExpressRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMExpressFetch;
    [self communitionServer:request api:API_FETCH_EXPRESS_URL withDelegate:delegate];
}

- (void)getComplaint:(GetComplaintRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMComplaint;
    [self communitionServer:request api:API_GET_COMPLAINT_URL withDelegate:delegate];
}

- (void)getRepair:(GetRepairRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMRepair;
    [self communitionServer:request api:API_GET_REPAIR_URL withDelegate:delegate];
}

- (void)getComplaintDetail:(ComplaintDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMComplaintDetail;
    [self communitionServer:request api:API_GET_COMPLAINT_DETAIL_URL withDelegate:delegate];
}

- (void)getRepairDetail:(RepairDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMRepairDetail;
    [self communitionServer:request api:API_GET_REPAIR_DETAIL_URL withDelegate:delegate];
}

- (void)addComplaint:(AddComplaintRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMComplaintAdd;
    [self communitionServer:request api:API_ADD_COMPLAINT_URL withDelegate:delegate];
}

- (void)addRepair:(AddRepairRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMRepairAdd;
    [self communitionServer:request api:API_ADD_REPAIR_URL withDelegate:delegate];
}

- (void)deleteComplaint:(DeleteComplaintRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMComplaintDelete;
    [self communitionServer:request api:API_DELETE_COMPLAINT_URL withDelegate:delegate];
}

- (void)deleteRepair:(DeleteRepairRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMRepairDelete;
    [self communitionServer:request api:API_DELETE_REPAIR_URL withDelegate:delegate];
}

- (void)getRent:(GetRentRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMRent;
    [self communitionServer:request api:API_GET_RENT_URL withDelegate:delegate];
}

- (void)getHouseDetail:(GetHouseDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMHouseDetail;
    [self communitionServer:request api:API_GET_HOUSE_DETAIL_URL withDelegate:delegate];
}

- (void)getMyRent:(GetMyRentRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMMyRent;
    [self communitionServer:request api:API_GET_MY_RENT_URL withDelegate:delegate];
}

- (void)editRent:(EditRentRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMRentEdit;
    [self communitionServer:request api:API_EDIT_RENT_URL withDelegate:delegate];
}

- (void)addRent:(AddRentRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMRentAdd;
    [self communitionServer:request api:API_ADD_RENT_URL withDelegate:delegate];
}

- (void)deleteRent:(DeleteRentRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMRentDelete;
    [self communitionServer:request api:API_DELETE_RENT_URL withDelegate:delegate];
}

- (void)getNotification:(GetNotificationRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMNotification;
    [self communitionServer:request api:API_GET_NOTIFICATION_URL withDelegate:delegate];
}

- (void)readNotification:(ReadNotificationRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMNotificationRead;
    [self communitionServer:request api:API_READ_NOTIFICATION_URL withDelegate:delegate];
}

- (void)getMyInfo:(GetMyInfoRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMMyInfo;
    [self communitionServer:request api:API_GET_MY_INFO_URL withDelegate:delegate];
}

- (void)getMoneyLog:(GetMoneyLogRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMMyMoney;
    [self communitionServer:request api:API_GET_MONEY_LOG_URL withDelegate:delegate];
}

- (void)editMyInfo:(EditMyInfoRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMMyInfoEdit;
    [self communitionServer:request api:API_EDIT_MY_INFO_URL withDelegate:delegate];
}

- (void)editPassword:(EditPasswordReqeustParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMMyPasswordEdit;
    [self communitionServer:request api:API_EDIT_PASSWORD_URL withDelegate:delegate];
}

- (void)getAddresses:(GetAddressesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMMyAddresses;
    [self communitionServer:request api:API_GET_ADDRESSES_URL withDelegate:delegate];
}

- (void)addAddress:(AddAddressRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMMyAddressAdd;
    [self communitionServer:request api:API_ADD_ADDRESS_URL withDelegate:delegate];
}

- (void)editAddress:(EditAddressRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMMyAddressEdit;
    [self communitionServer:request api:API_EDIT_ADDRESS_URL withDelegate:delegate];
}

- (void)getAllCommunities:(GetCommunityRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMAllCommunities;
    [self communitionServer:request api:API_GET_ALL_COMMUNITIES_URL withDelegate:delegate];
}

- (void)getAllRooms:(GetRoomRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMAllRooms;
    [self communitionServer:request api:API_GET_ALL_ROOMS_URL withDelegate:delegate];
}

- (void)getMyUtilities:(GetMyUtilitiesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMMyUtilities;
    [self communitionServer:request api:API_GET_MY_UTILITIES_URL withDelegate:delegate];
}

- (void)getMyParkings:(GetMyParkingRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMMyParkings;
    [self communitionServer:request api:API_GET_MY_PARKINGS_URL withDelegate:delegate];
}

- (void)getVotes:(GetVoteListRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMVote;
    [self communitionServer:request api:API_GET_VOTES_URL withDelegate:delegate];
}

- (void)vote:(AddVoteRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMVoteAdd;
    [self communitionServer:request api:API_ADD_VOTE_URL withDelegate:delegate];
}

- (void)getMyHobbies:(GetMyHobbiesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMMyHobbies;
    [self communitionServer:request api:API_GET_MY_HOBBIES_URL withDelegate:delegate];
}

- (void)getSameHobbyPeople:(GetSameHobbyPeopleRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMSameHobby;
    [self communitionServer:request api:API_GET_SAME_HOBBY_URL withDelegate:delegate];
}

- (void)getHobbyMessages:(GetHobbyMessageRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMHobbyMessage;
    [self communitionServer:request api:API_GET_HOBBY_MESSAGE_URL withDelegate:delegate];
}

- (void)sendHobbyMessage:(SendHobbyMessageRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMHobbyMessageSend;
    [self communitionServer:request api:API_SEND_HOBBY_MESSAGE_URL withDelegate:delegate];
}

- (void)getHobbies:(GetHobbiesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMHobbies;
    [self communitionServer:request api:API_GET_HOBBIES_URL withDelegate:delegate];
}

- (void)addHobby:(AddHobbyRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMHobbyAdd;
    [self communitionServer:request api:API_ADD_HOBBY_URL withDelegate:delegate];
}

- (void)deleteHobby:(DeleteHobbyRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMHobbyDelete;
    [self communitionServer:request api:API_DELETE_HOBBY_URL withDelegate:delegate];
}

- (void)getAllHobbyMessages:(GetAllHobbyMessagesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMAllHobbyMessages;
    [self communitionServer:request api:API_GET_ALL_HOBBY_MESSAGE_URL withDelegate:delegate];
}

- (void)getNeighbours:(GetNeighboursRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMNeighbours;
    [self communitionServer:request api:API_GET_NEIGHBOURS_URL withDelegate:delegate];
}

- (void)getNeighbourMessages:(GetNeighbourMessagesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMNeighbourMessages;
    [self communitionServer:request api:API_GET_NEIGHBOUR_MESSAGE_URL withDelegate:delegate];
}

- (void)getAllNeighbourMessages:(GetAllNeighbourMessagesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMAllNeighbourMessages;
    [self communitionServer:request api:API_GET_ALL_NEIGHBOUR_MESSAGE_URL withDelegate:delegate];
}

- (void)sendNeighbourMessage:(SendNeighbourMessageRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMNeighbourMessageSend;
    [self communitionServer:request api:API_SEND_NEIGHBOUR_MESSAGE_URL withDelegate:delegate];
}

- (void)getGroups:(GetGroupsRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMGroups;
    [self communitionServer:request api:API_GET_GROUPS_URL withDelegate:delegate];
}

- (void)getGroupDetail:(GroupDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMGroupDetail;
    [self communitionServer:request api:API_GET_GROUP_DETAIL_URL withDelegate:delegate];
}

- (void)getReserves:(GetReservesRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMReserves;
    [self communitionServer:request api:API_GET_GROUPS_URL withDelegate:delegate];
}

- (void)getReserveDetail:(ReserveDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMReserveDetail;
    [self communitionServer:request api:API_GET_GROUP_DETAIL_URL withDelegate:delegate];
}

- (void)getUnreadNotifications:(GetUnreadNotificationRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMAllUnreadNotification;
    [self communitionServer:request api:API_GET_UNREAD_NOTIFICATIONS_URL withDelegate:delegate];
}

- (void)payUtilities:(UtilitiesPayRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMPayUtilities;
    [self communitionServer:request api:API_PAY_URL withDelegate:delegate];
}

- (void)payParkings:(ParkingPayRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMPayParkings;
    [self communitionServer:request api:API_PAY_URL withDelegate:delegate];
}

- (void)payOrder:(OrderPayRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMPayOrder;
    [self communitionServer:request api:API_PAY_URL withDelegate:delegate];
}

- (void)getShops:(GetShopsRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMShops;
    [self communitionServer:request api:API_GET_SHOPS_URL withDelegate:delegate];
}

- (void)getShopDetail:(ShopDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMShopDetail;
    [self communitionServer:request api:API_GET_SHOP_DETAIL_URL withDelegate:delegate];
}

- (void)getNewsCategories:(GetNewsCategoryRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMNewsCategory;
    [self communitionServer:request api:API_GET_NEWS_CATEGORY_URL withDelegate:delegate];
}

- (void)getNews:(GetNewsRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMNews;
    [self communitionServer:request api:API_GET_NEWS_URL withDelegate:delegate];
}

- (void)confirmOrder:(ConfirmOrderRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMOrderConfirm;
    [self communitionServer:request api:API_CONFIRM_ORDER_URL withDelegate:delegate];
}

-  (void)addGroupOrder:(AddGroupOrderRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMOrderAdd;
    [self communitionServer:request api:API_ADD_ORDER_URL withDelegate:delegate];
}

- (void)addReserveOrder:(AddReserveOrderRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMOrderAdd;
    [self communitionServer:request api:API_ADD_ORDER_URL withDelegate:delegate];
}

- (void)getOrders:(GetOrdersRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMOrders;
    [self communitionServer:request api:API_GET_ORDERS_URL withDelegate:delegate];
}

- (void)getOrderDetail:(OrderDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMOrderDetail;
    [self communitionServer:request api:API_GET_ORDER_DETAIL_URL withDelegate:delegate];
}

- (void)deleteOrder:(DeleteOrderRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMOrderDelete;
    [self communitionServer:request api:API_DELETE_ORDER_URL withDelegate:delegate];
}

- (void)editOrder:(EditOrderRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMOrderEdit;
    [self communitionServer:request api:API_EDIT_ORDER_URL withDelegate:delegate];
}

- (void)editAvatar:(EditAvatarRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMAvatarEdit;
    [self communitionServer:request api:API_EDIT_AVATAR_URL withDelegate:delegate];
}

- (void)getCommunityDetail:(CommunityDetailRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMCommunityDetail;
    [self communitionServer:request api:API_GET_COMMUNITY_DETAIL_URL withDelegate:delegate];
}

- (void)getAdminMessages:(GetAdminMessageRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMAdminMessages;
    [self communitionServer:request api:API_GET_ADMIN_MESSAGE_URL withDelegate:delegate];
}

- (void)getAdvertisement:(GetAdvertisementsRequestParameter *)request withDelegate:(id<CommunicationDelegate>)delegate
{
    currentMethod = CMAdvertisement;
    [self communitionServer:request api:API_GET_ADVERTISEMENT_URL withDelegate:delegate];
}
#pragma mark - PrivateMethod
- (id<ResponseParameter>)constructResponse
{
    switch (currentMethod) {
        case CMLogin:
            return  [[LoginResponseParameter alloc] init];
        case CMSendCode:
            return [[SendCodeResponseParameter alloc] init];
        case CMPhoneVerify:
            return [[StringResponse alloc] init];
        case CMRegister:
            return [[RegisterResponseParameter alloc] init];
        case CMSendEmail:
            return nil;
        case CMLogout:
            return nil;
        case CMCommunities:
            return [[GetMyCommunitiesResponseParameter alloc] init];
        case CMCommunityEWMAdd:
            return nil;
        case CMCommunityAdd:
            return nil;
        case CMCommunityDelete:
            return nil;
        case CMUtilities:
            return [[GetUtilitiesResponseParameter alloc] init];
        case CMUtilitiesDetail:
            return [[UtilitiesDetailResponseParameter alloc] init];
        case CMParking:
            return [[GetParkingResponseParameter alloc] init];
        case CMParkingDetail:
            return [[ParkingDetailResponseParameter alloc] init];
        case CMExpress:
            return [[GetExpressResponseParameter alloc] init];
        case CMExpressFetch:
            return nil;
        case CMComplaint:
            return [[GetComplaintResponseParameter alloc] init];
        case CMRepair:
            return [[GetRepairResponseParameter alloc] init];
        case CMComplaintDetail:
            return [[ComplaintDetailResponseParameter alloc] init];
        case CMRepairDetail:
            return [[RepairDetailResponseParameter alloc] init];
        case CMComplaintAdd:
            return nil;
        case CMRepairAdd:
            return nil;
        case CMComplaintDelete:
            return nil;
        case CMRepairDelete:
            return nil;
        case CMRent:
            return [[GetRentResponseParameter alloc] init];
        case CMHouseDetail:
            return [[HouseDetailResponseParameter alloc] init];
        case CMMyRent:
            return [[GetMyRentResponseParameter alloc] init];
        case CMRentEdit:
            return nil;
        case CMRentDelete:
            return nil;
        case CMRentAdd:
            return nil;
        case CMNotification:
            return [[GetNotificationResponseParameter alloc] init];
        case CMNotificationRead:
            return nil;
        case CMMyInfo:
            return [[GetMyInfoResponseParameter alloc] init];
        case CMMyInfoEdit:
            return nil;
        case CMMyPasswordEdit:
            return nil;
        case CMMyAddresses:
            return [[GetAddressesResponseParameter alloc] init];
        case CMMyAddressAdd:
            return nil;
        case CMMyAddressEdit:
            return nil;
        case CMAllCommunities:
            return [[GetCommunityResponseParameter alloc] init];
        case CMAllRooms:
            return [[GetCommunityRoomResponseParameter alloc] init];
        case CMMyUtilities:
            return [[GetMyUtilitiesResponseParameter alloc] init];
        case CMMyParkings:
            return [[GetMyParkingResponseParameter alloc] init];
        case CMVote:
            return [[GetVoteListResponseParameter alloc] init];
        case CMVoteAdd:
            return nil;
        case CMMyHobbies:
            return [[GetMyHobbiesResponseParameter alloc] init];
        case CMSameHobby:
            return [[GetSameHobbyResponseParameter alloc] init];
        case CMHobbyMessage:
            return [[GetHobbyMessageResponseParameter alloc] init];
        case CMHobbyMessageSend:
            return nil;
        case CMHobbies:
            return [[GetHobbiesResponseParameter alloc] init];
        case CMHobbyAdd:
            return nil;
        case CMHobbyDelete:
            return nil;
        case CMAllHobbyMessages:
            return [[GetAllHobbyMessageResponseParameter alloc] init];
        case CMNeighbours:
            return [[GetNeighboursResponseParameter alloc] init];
        case CMNeighbourMessages:
            return [[GetNeighbourMessagesResponseParameter alloc] init];
        case CMAllNeighbourMessages:
            return [[GetAllNeighbourMessagesResponseParameter alloc] init];
        case CMNeighbourMessageSend:
            return nil;
        case CMGroups:
            return [[GetGroupsResponseParameter alloc] init];
        case CMGroupDetail:
            return [[GroupDetailResponseParameter alloc] init];
        case CMReserves:
            return [[GetGroupsResponseParameter alloc] init];
        case CMReserveDetail:
            return [[GroupDetailResponseParameter alloc] init];
        case CMAllUnreadNotification:
            return [[GetUnreadNotificationResponseParameter alloc] init];
        case CMPayUtilities:
            return [[StringResponse alloc] init];
        case CMPayParkings:
            return [[StringResponse alloc] init];
        case CMPayOrder:
            return [[StringResponse alloc] init];
        case CMShops:
            return [[GetShopsResponseParameter alloc] init];
        case CMShopDetail:
            return [[ShopDetailResponseParameter alloc] init];
        case CMNewsCategory:
            return [[GetNewsCategoryResponseParameter alloc] init];
        case CMNews:
            return [[GetNewsResponseParameter alloc] init];
        case CMOrderConfirm:
            return [[ConfirmOrderResponseParameter alloc] init];
        case CMOrderAdd:
            return [[AddOrderResponseParameter alloc] init];
        case CMOrders:
            return [[GetOrdersResponseParameter alloc] init];
        case CMOrderDetail:
            return [[OrderDetailResponseParameter alloc] init];
        case CMOrderDelete:
            return nil;
        case CMOrderEdit:
            return nil;
        case CMMyMoney:
            return [[GetMoneyLogResponseParameter alloc] init];
        case CMAvatarEdit:
            return [[StringResponse alloc] init];
        case CMCommunityDetail:
            return [[CommunityDetailResponseParameter alloc] init];
        case CMAdminMessages:
            return [[GetAdminMessageResponseParameter alloc] init];
        case CMAdvertisement:
            return [[GetAdvertisementsResponseParameter alloc] init];
    }
}

- (void)communitionServer:(id<RequestParameter>)request api:(NSString *)apiUrl withDelegate:(id<CommunicationDelegate>)delegate
{
    NSString *url = [NSString stringWithFormat:@"%@%@", HOST_URL,apiUrl];
    [self communitionServer:request url:url withDelegate:delegate method:MethodPost];
}

- (void)communitionServer:(id<RequestParameter>)request url:(NSString *)apiUrl withDelegate:(id<CommunicationDelegate>)delegate method:(MethodType)methodType;
{
    if(request == nil){
        currentRequest = [NSURLRequest requestAsWebViewWithMethod:methodType url:apiUrl parameters:nil];
    }
    else{
        currentRequest = [NSURLRequest requestAsWebViewWithMethod:methodType url:apiUrl parameters:[request convertToRequest]];
    }
    currentDelegate = delegate;
    [NSURLConnection connectionWithRequest:currentRequest delegate:self];
}

- (NSDictionary *)trimKeys:(NSDictionary *)dict
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    for(NSString *key in [dict allKeys]){
        NSString *newKey = [key stringByReplacingOccurrencesOfString:@" " withString:@""];
        [result setObject:[dict objectForKey:key] forKey:newKey];
    }
    
    return result;
}

#pragma mark - Connection Data Delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    NSString *rt = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"====================================");
    NSLog(@"%@", rt);
    rt = [rt stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    rt = [rt stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [rt dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    response = [self trimKeys:response];
    if(error != nil){
        NSLog(@"the format is error!");
    }
    else{
        if(currentDelegate != nil){
            if([response.allKeys containsObject:RESPONSE_STATUS]){
                int status = [[response objectForKey:RESPONSE_STATUS] intValue];
                if(status == 0){
                    id data = [response objectForKey:RESPONSE_DATA];
                    id<ResponseParameter> result = [self constructResponse];
                    if(data != [NSNull null]){
                        if([data isKindOfClass:[NSString class]]){
                            [result initialFromStringResponse:data];
                        }
                        else if([data isKindOfClass:[NSDictionary class]]){
                            [result initialFromDictionaryResponse:data];
                        }
                        else{
                            [result initialFromArrayResponse:data];
                        }
                    }
                    [currentDelegate ProcessServerResponse:result];
                }
                else if(status == 1){
                    ServerFailInformation *info = [[ServerFailInformation alloc] init];
                    info.isUnlogin = NO;
                    info.message = response[RESPONSE_MESSAGE];
                    [currentDelegate ProcessServerFail:info];
                }
                else if(status == 99){
                    ServerFailInformation *info = [[ServerFailInformation alloc] init];
                    info.isUnlogin = YES;
                    [currentDelegate ProcessServerFail:info];
                }
            }
            else{
                int error = [[response objectForKey:@"error"] intValue];
                if(error > 0){
                    ServerFailInformation *info = [[ServerFailInformation alloc] init];
                    info.isUnlogin = NO;
                    info.message = response[@"content"];
                    [currentDelegate ProcessServerFail:info];
                }
                else{
                    SendCodeResponseParameter *result = [self constructResponse];
                    result.code = [response objectForKey:@"tel_code"];
                    [currentDelegate ProcessServerResponse:result];
                }
            }
        }
    }
}

#pragma mark - Connection Delegate
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(currentDelegate != nil){
        [currentDelegate ProcessCommunicationError:error];
    }
}

@end
