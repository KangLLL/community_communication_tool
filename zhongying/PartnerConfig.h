//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088211259297417"
//收款支付宝账号
#define SellerID @"9304565@qq.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"4l91799ruuq25nsvep5org6uct433ena"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAOXF3zWqO4iqJYx5V2lKrPv3CE6bW5DmbjRrnGW7WhygJwi7lWUfYwSNYS3WYfydaciE89O2/qj2vDK23u6PWkxA3lbhpB2fIsvD0xIkCjWyZudDVosS/Dhek6Y8CEGjDy9xr4yYvsA41m4k6v5Ls+UJtqOy2lznNVZGHjiVSLj5AgMBAAECgYEAoB9nsLdEK7Ye2qkI8FhY+nIpuNXtVqourJs9b2vDnWVCLoTC1Kit0VNRIKdgu7FbMaDtZmIFT+w6NMFZ1DfUPTNc6I0Sn/9mjdIDqx7wVO4VcieuALg7uF06kJfk9DQ6+ZUcAAAcP5VDnj2FP3htg7eRasu+5TKdJuyIGjxsqTECQQD50qJA81bHy2n4+jiJDx5gFfGDEGRJFb3Gx1TPEHp92w8MNoC/p7taNjIT6o6U3Tlot8/RB9iF0EYEzetyt6bdAkEA63RS0h9s001rjbrLKafhjCkxz60xD9dDQfV2Rymhhu5gCd+Mx9op9nKFQQ8SZ4vEEUwIez3H1PUbDX+BQX3izQJBAMADyXoqjpTaIAWiLToLSMmJlCusuagC8e6K3wCYJc3+RT6Z1bN5dGMOLMdqDVUWBD4cqbp8UUvonSisLT/rMHECQQDnEkDZgAewE5HTBRevKNf8Us1Ur/avQiX6jGfojN296yELb33dAKkf+OH3qE/6mLrx8rl8IXSE9Yr4I0L5wA6dAkA4xo9rWsA/Tn2U4qLwJI/83iP5+khUvBthRIQRN9i9P8lGfGdNektc0a1aATcjiiOikrfGS171fbhqqt4GFKPy"


//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDlxd81qjuIqiWMeVdpSqz79whOm1uQ5m40a5xlu1ocoCcIu5VlH2MEjWEt1mH8nWnIhPPTtv6o9rwytt7uj1pMQN5W4aQdnyLLw9MSJAo1smbnQ1aLEvw4XpOmPAhBow8vca+MmL7AONZuJOr+S7PlCbajstpc5zVWRh44lUi4+QIDAQAB"

#endif
