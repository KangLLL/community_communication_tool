//
//  RegisterRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "RegisterRequestParameter.h"

@implementation RegisterRequestParameter

@synthesize phone,password,recommandUserId;

- (NSDictionary *)convertToRequest
{
    if(recommandUserId != nil){
        return [NSDictionary dictionaryWithObjectsAndKeys:self.phone,@"tel",self.password,@"password",self.recommandUserId,@"tid",nil];
    }
    else{
        return [NSDictionary dictionaryWithObjectsAndKeys:self.phone,@"tel",self.password,@"password",nil];
    }
}

@end
