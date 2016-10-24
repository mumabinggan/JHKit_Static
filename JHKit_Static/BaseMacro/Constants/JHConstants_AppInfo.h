//
//  JHConstants_AppInfo.h
//  JHKit
//
//  Created by muma on 16/10/4.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#ifndef JHConstants_AppInfo_h
#define JHConstants_AppInfo_h

#ifndef kAppName
    #define kAppName [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"]
#endif

#endif /* JHConstants_AppInfo_h */
