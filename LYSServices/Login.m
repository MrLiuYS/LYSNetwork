//
//  Login.m
//  LYSNetwork
//
//  Created by 刘永生 on 2017/2/20.
//  Copyright © 2017年 刘永生. All rights reserved.
//

#import "Login.h"

#import "LYSServiceClient.h"


@implementation Login


+ (NSURLSessionDataTask *)loginAccount:(NSString *)account
                              password:(NSString *)password
                              success:(void (^)(NSURLSessionDataTask * task, NSError *error))success
                              failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    
    return [LYSServiceClient servicePath:API_LOGIN
                                  params:@{API_LOGIN_ACCOUNT: account,
                                           API_LOGIN_PASSWORD:password}
                              httpMethod:LYSServiceHttpMethodPOST
                                 success:success
                                 failure:failure];
    
}


@end
