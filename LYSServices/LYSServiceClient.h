//
//  LYSServiceClient.h
//  LYSNetwork
//
//  Created by 刘永生 on 2017/2/20.
//  Copyright © 2017年 刘永生. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "Api.h"


typedef NS_ENUM(NSUInteger, LYSServiceHttpMethod) {
    LYSServiceHttpMethodGET,
    LYSServiceHttpMethodPOST
};


@interface LYSServiceClient : AFHTTPSessionManager

+ (instancetype)sharedClient;


+ (void)changeBaseUrl:(NSString *)baseUrl;

+ (NSURLSessionDataTask *)servicePath:(NSString *)urlPath
                               params:(NSDictionary *)params
                           httpMethod:(LYSServiceHttpMethod)httpMethod
                              success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                              failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;


+ (NSURLSessionDataTask *)servicePath:(NSString *)urlPath
                               params:(NSDictionary *)params
                           httpMethod:(LYSServiceHttpMethod)httpMethod
                              timeout:(NSTimeInterval)timeout
                              success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                              failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;




@end
