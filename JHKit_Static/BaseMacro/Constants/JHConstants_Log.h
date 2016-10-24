//
//  JHConstants_Log.h
//  JHKit
//
//  Created by muma on 16/10/7.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#ifndef JHConstants_Log_h
#define JHConstants_Log_h

#ifdef APP_DEBUG
    #define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
    #define DLogFrame(rect) DLog(@"x:%f, y: %f, w: %f, h: %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#else
    #define DLog(...)
    #define DLogFrame(rect)
#endif

#endif /* JHConstants_Log_h */
