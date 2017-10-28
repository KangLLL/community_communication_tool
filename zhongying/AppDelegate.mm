//
//  AppDelegate.m
//  zhongying
//
//  Created by lik on 14-3-18.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AppDelegate.h"
#import "RegionInformation.h"
#import "DistrictInformation.h"
#import "NSDate+DateCompare.h"
#import "UserInformation.h"
#import "CommonConsts.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "CommonUtilities.h"
#import "BMapKit.h"
#import "MobClick.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[MobClick startWithAppkey:@"535e0f9c56240b17710ed015" reportPolicy:SENDWIFIONLY channelId:@"xiaohuangquan"];
    //[MobClick checkUpdate];
    
    // Override point for customization after application launch.
    [application setStatusBarHidden:NO];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        
        [application setStatusBarStyle:UIStatusBarStyleLightContent];
        //[application setStatusBarStyle:UIStatusBarStyleDefault];
        self.window.clipsToBounds =YES;
        self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
        
        self.window.bounds = CGRectMake(0,20,self.window.frame.size.width, self.window.frame.size.height);
    }
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:
                           @"city2" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if(error == nil){
        NSMutableArray *array = [NSMutableArray array];
        NSArray *regions = [dict objectForKey:@"RECORDS"];
        for (NSDictionary *dt in regions) {
            RegionInformation *info = [[RegionInformation alloc] initWithDict:dt];
            [array addObject:info];
        }
        [DistrictInformation instance].regions = array;
        [[DistrictInformation instance] initialRegions];
    }
    
    BMKMapManager *mapManager = [[BMKMapManager alloc]init];
    
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    
    BOOL ret = [mapManager start:@"iH9lGLt9brOtrzFDulqhnnIo" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID_KEY];
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_PASSWORD_KEY];
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_NAME_KEY];
    
    [UserInformation instance].userId = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_KEY];
    //[UserInformation instance].nickName = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NICK_NAME_KEY];
    [UserInformation instance].password = [[NSUserDefaults standardUserDefaults] objectForKey:USER_PASSWORD_KEY];
    [UserInformation instance].phone = [[NSUserDefaults standardUserDefaults] objectForKey:USER_PHONE_KEY];
    [UserInformation instance].name = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME_KEY];
    [UserInformation instance].avatarPath = [[NSUserDefaults standardUserDefaults] objectForKey:AVATAR_PATH_KEY];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Ali pay

//独立客户端回调函数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	
	[self parse:url application:application];
	return YES;
}

- (void)parse:(NSURL *)url application:(UIApplication *)application {
    
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            //            NSString* key = @"签约帐户后获取到的支付宝公钥";
            //			id<DataVerifier> verifier;
            //            verifier = CreateRSADataVerifier(key);
            //
            //			if ([verifier verifyString:result.resultString withSign:result.signString])
            //            {
            //                //验证签名成功，交易结果无篡改
            //			}
            
            [[CommonUtilities instance] showGlobeMessage:result.resultString];
        }
        else
        {
            [[CommonUtilities instance] showGlobeMessage:result.statusMessage];
            //交易失败
        }
    }
    else
    {
        [[CommonUtilities instance] showGlobeMessage:result.statusMessage];
        //失败
    }
    
}

- (AlixPayResult *)resultFromURL:(NSURL *)url {
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return [[AlixPayResult alloc] initWithString:query];
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
	AlixPayResult * result = nil;
	
	if (url != nil && [[url host] compare:@"safepay"] == 0) {
		result = [self resultFromURL:url];
	}
    
	return result;
}



@end
