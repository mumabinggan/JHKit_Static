//
//  JHConstants_OpenUrl.h
//  JHKit
//
//  Created by muma on 16/10/4.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#ifndef JHConstants_OpenUrl_h
#define JHConstants_OpenUrl_h

#define kOpenURL(url) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]]
#define kCanOpenURL(url) [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]

#define canTel                 kCanOpenURL(@"tel:")
#define tel(phoneNumber)       kOpenURL(([NSString stringWithFormat:@"tel:%@",phoneNumber]))
#define telprompt(phoneNumber) kOpenURL(([NSString stringWithFormat:@"telprompt:%@",phoneNumber]))

#endif /* JHConstants_OpenUrl_h */
