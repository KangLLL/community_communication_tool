//
//  CommonEnum.h
//  zhongying
//
//  Created by lik on 14-4-3.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#ifndef zhongying_CommonEnum_h
#define zhongying_CommonEnum_h

typedef enum{
    payZhiFuBao = 99,
    payYinLian = 20,
    payYuE = 11,
    payZhiFuBaoWeb = 10
}PayType;

typedef enum{
    editSingle,
    editMultiplay
}FoldableEditType;

typedef enum{
    addressSelectProvince,
    addressSelectCity,
    addressSelectDistrict
}AddressSelectType;

typedef enum{
    rentZhengZu,
    rentHeZu,
    rentDuanZu,
    rentSale
}RentType;


typedef enum{
    rentPayYa1Fu3,
    rentPayYa1Fu1,
    rentPayBanNian,
    rentPayNian,
    rentMianYi
}RentPayType;

typedef enum{
    sexUnknown,
    sexMale,
    sexFemale
}SexType;

typedef enum{
    attributeSingle = 1,
    attributeMultiply = 2
}AttributeSelectType;

typedef enum{
    orderAddress,
    orderPay,
    orderShip
}OrderEditType;


typedef enum{
    messageNotHandle = 0,
    //messageHandle
    messageConfirm = 2,
    messageProcess = 3,
    messageComplete = 4
}MessageResponseType;

typedef enum{
    messageUnreaded,
    messageReaded
}MessageReadStatus;
#endif
