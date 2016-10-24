//
//  JHStructType.h
//  JHKit
//
//  Created by muma on 16/10/3.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#ifndef JHStructType_h
#define JHStructType_h
#import <UIKit/UIKit.h>

struct JHRadius {
    CGFloat ltRadius;
    CGFloat rtRadius;
    CGFloat lbRadius;
    CGFloat rbRadius;
};
typedef struct JHRadius JHRadius;

CG_INLINE JHRadius
JHRadiusMake(CGFloat lt, CGFloat lb, CGFloat rt, CGFloat rb)
{
    JHRadius radius;
    radius.ltRadius = lt;
    radius.lbRadius = lb;
    radius.rtRadius = rt;
    radius.rbRadius = rb;
    return radius;
}

#endif /* JHStructType_h */
