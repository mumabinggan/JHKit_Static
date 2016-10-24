//
//  JHNetworkManager.h
//  JHKit
//
//  Created by muma on 2016/10/16.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHObject.h"

@class JHRequest, JHResponse;

@interface JHNetworkManager : NSObject

+ (JHNetworkManager *)sharedManager;

- (void)get:(JHRequest *)request forResponseClass:(Class)clazz
    success:(void (^)(JHResponse *response))success
    failure:(void (^)(NSError *error))failure;

- (void)post:(JHRequest *)request forResponseClass:(Class)clazz
     success:(void (^)(JHResponse *response))success
     failure:(void (^)(NSError *error))failure;

- (void)get:(JHRequest *)request forResponseClass:(Class)clazz
   progress:(void (^)(NSProgress *downloadProgress))progress
    success:(void (^)(JHResponse *response))success
    failure:(void (^)(NSError *error))failure;

- (void)post:(JHRequest *)request forResponseClass:(Class)clazz
    progress:(void (^)(NSProgress *uploadProgress))progress
     success:(void (^)(JHResponse *response))success
     failure:(void (^)(NSError *error))failure;

- (void)post:(JHRequest *)request forResponseClass:(Class)clazz
    progress:(void (^)(NSProgress *uploadProgress))progress
       parts:(NSArray *)parts
     success:(void (^)(JHResponse *response))success
     failure:(void (^)(NSError *error))failure;

- (void)abort:(NSString *)url;

@end
