//
//  AddVoteRequest.m
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddVoteRequestParameter.h"

@implementation AddVoteRequestParameter

@synthesize userId, answer, voteId, password;

- (NSDictionary *)convertToRequest
{
    NSMutableString *temp = [NSMutableString string];
    
    for (NSString *o in self.answer) {
        if([temp length] > 0){
            [temp appendString:@","];
        }
        [temp appendString:o];
    }
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.userId,@"uid",self.password,@"password",self.voteId,@"vote_id",temp,@"answer",nil];
    return parameters;
}

@end
