//
//  JHConstants_Color.h
//  JHKit
//
//  Created by muma on 16/10/4.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#ifndef JHConstants_Color_h
#define JHConstants_Color_h

#ifndef kRGB
#define kRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#endif

#ifndef kRGBA
#define kRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#endif

#define kHRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kHRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define kWhiteColor kRGB(255.0, 255.0, 255.0)
#define kBlackColor kRGB(0, 0, 0)
#define kBlueColor  kRGB(0, 0, 255)
#define kRedColor   kRGB(255, 0, 0)
#define kGreenColor kRGB(0, 255, 0)
#define kGrayColor  kRGB(128, 128, 128)
#define kLightGrayColor   kRGB(211, 211, 211)
#define kCyanColor  kRGB(0, 255, 255)
#define kYellowColor kRGB(255, 255, 0)
#define kPinkColor  kRGB(255, 0, 255)
#define kClearColor [UIColor clearColor]
#define kRandomColor (kRGB(arc4random()%255, arc4random()%255, arc4random()%255))
#define kRandomColorA(alpha) (kRGBA(arc4random()%255, arc4random()%255, arc4random()%255, alpha))

#endif /* JHConstants_Color_h */
