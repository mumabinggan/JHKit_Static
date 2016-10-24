//
//  JHRequest.h
//  JHKit
//
//  Created by muma on 16/10/7.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHObject.h"

@interface JHRequest : JHObject

@property (nonatomic, assign) BOOL showsLoadingView;

@property (nonatomic, strong) NSString *loadingMessage; // only used when showsLoadingView is set to YES

@property (nonatomic, assign) BOOL showsRetryView;

@property (nonatomic, strong) NSString *retryMessage; // only used when showsRetryView is set to YES

- (NSTimeInterval)timeoutInterval;

- (NSString *)scheme; // eg. http, https, default : "http"

- (NSString *)host; // eg. www.example.com, default ""

- (NSString *)port; // eg. 80, 443 etc. default "80"

- (NSString *)path; // eg. app/ default ""

- (NSString *)api; // eg. getUser.rest etc. default : ""

- (NSString *)url; // no need to override, except your url is not format with: scheme://domain/path/api

- (NSDictionary *)headers; // http headers,

- (NSDictionary *)parameters; // no need to override except you have a specify realization

- (NSSet *)acceptContentTypes; // default: [NSSet setWithObjects: @"application/json", @"text/html", @"text/plain", nil];

- (BOOL)enableResponseObject; // return true if you want to get origin response object, else return false default: return false

@end

@interface JHRequestHeaderPart : JHObject

@property (nonatomic, strong) NSDictionary *headrs;

@property (nonatomic, strong) NSData *body;

@end

@interface JHRequestPart : JHObject

@property (nonatomic, strong) NSString *name;

@end

@interface JHRequestFileURLPart : JHRequestPart

@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) NSString *fileName;

@property (nonatomic, strong) NSString *mimeType;

@end

@interface JHRequestFormDataPart : JHRequestPart

@property (nonatomic, strong) NSData *data;

@end

@interface JHRequestFileDataPart : JHRequestFormDataPart

@property (nonatomic, strong) NSString *fileName;

@property (nonatomic, strong) NSString *mimeType;

@end

@interface JHRequestInputStreamPart : JHRequestPart

@property (nonatomic, strong) NSInputStream *stream;

@property (nonatomic, strong) NSString *fileName;

@property (nonatomic, assign) long long length;

@property (nonatomic, strong) NSString *mimeType;

@end
