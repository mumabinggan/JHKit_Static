//
//  JHNetworkManager.m
//  JHKit
//
//  Created by muma on 2016/10/16.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHNetworkManager.h"
#import "JHRequest.h"
#import "JHResponse.h"
#import "NSString+JHKit.h"
#import "UIKit+AFNetworking.h"

@implementation JHNetworkManager
{
    NSMutableDictionary *_url2Tasks;
    AFHTTPSessionManager *_sessionManager;
}

static JHNetworkManager *_sharedInstance = nil;


+ (JHNetworkManager *)sharedManager {
    @synchronized([JHNetworkManager class]) {
        if (!_sharedInstance) {
            _sharedInstance = [[self alloc] init];
        }
        if (_sharedInstance) {
            [_sharedInstance prepareNetworkManager];
        }
        return _sharedInstance;
    }
    return nil;
}

+ (id)alloc {
    @synchronized([JHNetworkManager class]) {
        NSAssert(_sharedInstance == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedInstance = [super alloc];
        return _sharedInstance;
    }
    return nil;
}

- (void)prepareNetworkManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    if (!_url2Tasks) {
        _url2Tasks = [NSMutableDictionary dictionary];
    }
}

- (void)get:(JHRequest *)request forResponseClass:(Class)clazz success:(void (^)(JHResponse *))success failure:(void (^)(NSError *))failure {
    [self get:request forResponseClass:clazz progress:nil success:success failure:failure];
}

- (void)post:(JHRequest *)request forResponseClass:(Class)clazz success:(void (^)(JHResponse *))success failure:(void (^)(NSError *))failure {
    [self post:request forResponseClass:clazz progress:nil success:success failure:failure];
}

- (void)get:(JHRequest *)request forResponseClass:(Class)clazz progress:(void (^)(NSProgress *))progress success:(void (^)(JHResponse *))success failure:(void (^)(NSError *))failure {
    
    [self prepareHttpHeaders:request];
    
    __weak typeof(self) weakSelf = self;
    
    [_url2Tasks setObject:
     [_sessionManager GET:request.url parameters:request.parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            JHResponse *response = [[clazz alloc] initWithDictionary:responseObject];
            if (response && request.enableResponseObject) {
                [response setValue:responseObject forKey:@"responseObject"];
            }
            success(response);
            [weakSelf handleRequestSuccess:request];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        [weakSelf handleRequestFailure:request];
    }] forKey:request.url];
}

- (void)handleRequestSuccess:(JHRequest *)request {
    [_url2Tasks removeObjectForKey:request.url];
}

- (void)handleRequestFailure:(JHRequest *)request {
    [_url2Tasks removeObjectForKey:request.url];
}

- (void)post:(JHRequest *)request forResponseClass:(Class)clazz progress:(void (^)(NSProgress *))progress success:(void (^)(JHResponse *))success failure:(void (^)(NSError *))failure {
    
    [self prepareHttpHeaders:request];
    
    __weak typeof(self) weakSelf = self;
    
    [_url2Tasks setObject:
     [_sessionManager POST:request.url parameters:request.parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            JHResponse *response = [[clazz alloc] initWithDictionary:responseObject];
            if (response && request.enableResponseObject) {
                [response setValue:responseObject forKey:@"responseObject"];
            }
            success(response);
            [weakSelf handleRequestFailure:request];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        [weakSelf handleRequestFailure:request];
    }] forKey:request.url];
}

- (void)post:(JHRequest *)request forResponseClass:(Class)clazz progress:(void (^)(NSProgress *))progress parts:(NSArray *)parts success:(void (^)(JHResponse *))success failure:(void (^)(NSError *))failure {
    
    [self prepareHttpHeaders:request];
    
    __weak typeof(self) weakSelf = self;
    
    [_url2Tasks setObject:
     [_sessionManager POST:request.url parameters:request.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [weakSelf prepareFormData:formData parts:parts];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            JHResponse *response = [[clazz alloc] initWithDictionary:responseObject];
            if (response && request.enableResponseObject) {
                [response setValue:responseObject forKey:@"responseObject"];
            }
            success(response);
            [weakSelf handleRequestFailure:request];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        [weakSelf handleRequestFailure:request];
    }] forKey:request.url];
}

- (void)prepareFormData:(id<AFMultipartFormData>  _Nonnull)formData parts:(NSArray *)parts {
    for (id p in parts) {
        if ([p isKindOfClass:[JHRequestFileURLPart class]]) {
            JHRequestFileURLPart *part = (JHRequestFileURLPart *)p;
            if (part.url && ![NSString isNullOrEmpty:part.name]) {
                if (![NSString isNullOrEmpty:part.fileName] && ![NSString isNullOrEmpty:part.mimeType]) {
                    [formData appendPartWithFileURL:part.url name:part.name fileName:part.fileName mimeType:part.mimeType error:nil];
                }
                else {
                    [formData appendPartWithFileURL:part.url name:part.name error:nil];
                }
            }
        }
        else if ([p isKindOfClass:[JHRequestFileDataPart class]]) {
            JHRequestFileDataPart *part = (JHRequestFileDataPart *)p;
            if (part.data && ![NSString isNullOrEmpty:part.name] && ![NSString isNullOrEmpty:part.fileName] && ![NSString isNullOrEmpty:part.mimeType]) {
                [formData appendPartWithFileData:part.data name:part.name fileName:part.fileName mimeType:part.mimeType];
            }
        }
        else if ([p isKindOfClass:[JHRequestFormDataPart class]]) {
            JHRequestFormDataPart *part = (JHRequestFormDataPart *)p;
            if (part.data && ![NSString isNullOrEmpty:part.name]) {
                [formData appendPartWithFormData:part.data name:part.name];
            }
        }
        else if ([p isKindOfClass:[JHRequestInputStreamPart class]]) {
            JHRequestInputStreamPart *part = (JHRequestInputStreamPart *)p;
            if (part.stream && ![NSString isNullOrEmpty:part.name] && ![NSString isNullOrEmpty:part.fileName] && ![NSString isNullOrEmpty:part.mimeType]) {
                [formData appendPartWithInputStream:part.stream name:part.name fileName:part.fileName length:part.length mimeType:part.mimeType];
            }
        }
        else if ([p isKindOfClass:[JHRequestHeaderPart class]]) {
            JHRequestHeaderPart *part = (JHRequestHeaderPart *)p;
            if (part.body) {
                [formData appendPartWithHeaders:part.headrs body:part.body];
            }
        }
    }
}

- (void)prepareHttpHeaders:(JHRequest *)request {
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    
    [requestSerializer setTimeoutInterval:[request timeoutInterval]];
    
    NSDictionary *headers = [request headers];
    if (headers) {
        for (NSInteger i = 0, n = headers.allKeys.count; i < n; ++ i) {
            NSString *key = [headers.allKeys objectAtIndex:i];
            [requestSerializer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
        }
    }
    
    if (request.acceptContentTypes) {
        [responseSerializer setAcceptableContentTypes:request.acceptContentTypes];
    }
    
    _sessionManager.requestSerializer = requestSerializer;
    _sessionManager.responseSerializer = responseSerializer;
}

- (void)abort:(NSString *)url {
    NSURLSessionDataTask *task = [_url2Tasks objectForKey:url];
    if (task) {
        [task cancel];
        [_url2Tasks removeObjectForKey:url];
    }
}

@end
