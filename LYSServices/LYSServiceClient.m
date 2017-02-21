//
//  LYSServiceClient.m
//  LYSNetwork
//
//  Created by 刘永生 on 2017/2/20.
//  Copyright © 2017年 刘永生. All rights reserved.
//

#import "LYSServiceClient.h"

static LYSServiceClient *_sharedClient = nil;

@implementation LYSServiceClient

+ (instancetype)sharedClient {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[LYSServiceClient alloc] initWithBaseURL:[NSURL URLWithString:API_BASEURL]];
        
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
    });
    
    return _sharedClient;
}

+ (void)changeBaseUrl:(NSString *)baseUrl {
    
    _sharedClient = nil;
    _sharedClient = [[LYSServiceClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
}


+ (void)cookie {
    
    [[LYSServiceClient sharedClient].requestSerializer setValue:@"cookieName=cookieValue"
                                             forHTTPHeaderField:@"Cookie"];
    
}


+ (NSURLSessionDataTask *)servicePath:(NSString *)urlPath
                               params:(NSDictionary *)params
                           httpMethod:(LYSServiceHttpMethod)httpMethod
                              success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success
                              failure:(void (^)(NSURLSessionDataTask * _Nonnull task, NSError *error))failure {
    
    return [self servicePath:urlPath
                      params:params
                  httpMethod:httpMethod
                     timeout:15
                     success:success
                     failure:failure];
    
}

/**
 请求数据

 @param urlPath 路径
 @param params 参数
 @param httpMethod GET/POST
 @param timeout 超时时间
 @param success 请求成功
 @param failure 请求失败
 @return 请求体
 */
+ (NSURLSessionDataTask *)servicePath:(NSString *)urlPath
                               params:(NSDictionary *)params
                           httpMethod:(LYSServiceHttpMethod)httpMethod
                              timeout:(NSTimeInterval)timeout
                              success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success
                              failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    
    [LYSServiceClient sharedClient].requestSerializer.timeoutInterval = timeout;
    
    
    if (httpMethod == LYSServiceHttpMethodGET) {
        return [[LYSServiceClient sharedClient] serviceGET:urlPath
                                                parameters:params
                                                  progress:nil
                                                   success:success
                                                   failure:failure];
    }
    
    if (httpMethod == LYSServiceHttpMethodPOST) {
        return [[LYSServiceClient sharedClient] servicePOST:urlPath
                                                 parameters:params
                                                   progress:nil
                                                    success:success
                                                    failure:failure];
    }

    return nil;
    
    
}


- (NSURLSessionDataTask *)serviceGET:(NSString *)URLString
                   parameters:(id)parameters
                     progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    
    return [[LYSServiceClient sharedClient] GET:URLString
                                     parameters:parameters
                                       progress:downloadProgress
                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                            
                                            if (success) {
                                                success(task,responseObject);
                                            }
                                            
                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                            
                                            if (failure) {
                                                failure(task,error);
                                            }
                                            
                                        }];
    
}

- (NSURLSessionDataTask *)servicePOST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    
    return [[LYSServiceClient sharedClient] GET:URLString
                                     parameters:parameters
                                       progress:uploadProgress
                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                            
                                            if (success) {
                                                success(task,responseObject);
                                            }
                                            
                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                            
                                            if (failure) {
                                                failure(task,error);
                                            }
                                            
                                        }];
    
}



@end
