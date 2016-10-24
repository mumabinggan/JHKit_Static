//
//  JHRequest.m
//  JHKit
//
//  Created by muma on 16/10/7.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHRequest.h"

static NSTimeInterval kREQUEST_TIMEOUT_INTERVAL = 30;

@implementation JHRequest
{
    BOOL _showsLoadingView;
    BOOL _showsRetryView;
}

- (id)init {
    self = [super init];
    if (self) {
        _showsLoadingView = YES;
        _showsRetryView = YES;
    }
    return self;
}

- (NSString *)url {
    return [NSString stringWithFormat:@"%@://%@:%@%@%@", [self scheme], [self host], [self port], [self path], [self api]];
}

- (NSString *)scheme {
    return @"http";
}

- (NSString *)host {
    return @"";
}

- (NSString *)port {
    return @"";
}

- (NSString *)path {
    return @"";
}

- (NSString *)api {
    return @"";
}

- (void) setShowsLoadingView:(BOOL)showsLoadingView {
    _showsLoadingView = showsLoadingView;
}

- (BOOL) showsLoadingView {
    return _showsLoadingView;
}

- (void) setShowRetryView:(BOOL)showsRetryView {
    _showsRetryView = showsRetryView;
}

- (BOOL) showsRetryView {
    return _showsRetryView;
}

- (NSDictionary *)parameters {
    return self.dictionary;
}

- (NSTimeInterval)timeoutInterval {
    return kREQUEST_TIMEOUT_INTERVAL;
}

- (NSDictionary *)headers {
    return @{
             @"Accept" : @"application/json",
             @"Content-Type" : @"application/json",
             @"Data-Type" : @"json",
             @"Accept-Encoding" : @"gzip",
             @"Content-Encoding" : @"gzip",
             };
}

- (NSSet *)acceptContentTypes {
    return [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
}

- (BOOL)enableResponseObject {
    return NO;
}

+ (NSArray *)ignoredProperties {
    return @[@"showsLoadingView", @"showsRetryView"];
}

@end

@implementation JHRequestHeaderPart

@end

@implementation JHRequestPart

@end

@implementation JHRequestFileURLPart

@end

@implementation JHRequestFormDataPart

@end

@implementation JHRequestFileDataPart

@end

@implementation JHRequestInputStreamPart

@end
