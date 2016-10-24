//
//  JHConstants_Version.h
//  JHKit
//
//  Created by muma on 16/10/4.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#ifndef JHConstants_Version_h
#define JHConstants_Version_h

// Current App Version
#ifndef kAppVersion
    #define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#endif

#ifndef kAppBuild
    #define kAppBuild [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#endif

// IOS Version
#ifndef iOSVersion
    #define iOSVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
#endif

#ifndef iOS6
    #define iOS6 (iOSVersion >= 6.0 && iOSVersion < 7.0)
#endif

#ifndef iOS6_OR_LATER
    #define iOS6_OR_LATER iOSVersion >= 6.0
#endif

#ifndef iOS7
    #define iOS7 (iOSVersion >= 7.0 && iOSVersion < 8.0)
#endif

#ifndef iOS7_OR_LATER
    #define iOS7_OR_LATER iOSVersion >= 7.0
#endif

#ifndef iOS8
    #define iOS8 (iOSVersion >= 8.0 && iOSVersion < 9.0)
#endif

#ifndef iOS8_OR_LATER
    #define iOS8_OR_LATER iOSVersion >= 8.0
#endif

#ifndef iOS9
    #define iOS9 (iOSVersion >= 9.0 && iOSVersion < 10.0)
#endif

#ifndef iOS9_OR_LATER
    #define iOS9_OR_LATER iOSVersion >= 9.0
#endif

#ifndef iOS10
    #define iOS10 (iOSVersion >= 10.0 && iOSVersion < 11.0)
#endif

#ifndef iOS10_OR_LATER
    #define iOS10_OR_LATER iOSVersion >= 10.0
#endif

#endif /* JHConstants_Version_h */
