//
//  JHConstants_Device.h
//  JHKit
//
//  Created by muma on 16/10/4.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#ifndef JHConstants_Device_h
#define JHConstants_Device_h

#define kMainScreenScale (UIScreen.mainScreen().scale)

#ifndef kDeviceWidth
    #define kDeviceWidth ([[UIScreen mainScreen] bounds].size.width)
#endif

#ifndef kDeviceHeight
    #define kDeviceHeight ([[UIScreen mainScreen] bounds].size.height)
#endif

#ifndef kAppFrame
    #define kAppFrame [[UIScreen mainScreen] applicationFrame]
#endif

#ifndef kAppBounds
    #define kAppBounds [[UIScreen mainScreen] bounds]
#endif

#ifndef kDeviceWidthScaleTo35Inch
    #define kDeviceWidthScaleTo35Inch (kDeviceWidth/320.0)
#endif

#ifndef kDeviceHeightScaleTo35Inch
    #define kDeviceHeightScaleTo35Inch (kDeviceHeight/480.0)
#endif

#ifndef kDeviceWidthScaleTo47Inch
    #define kDeviceWidthScaleTo47Inch (kDeviceWidth/375.0)
#endif

#ifndef kDeviceHeightScaleTo47Inch
    #define kDeviceHeightScaleTo47Inch (kDeviceHeight/667.0)
#endif

#define kAppAdaptHeight(height) (height*kDeviceWidthScaleToiPhone6)
#define kAppAdaptWidth(width) (width*kDeviceWidthScaleToiPhone6)

#define kAppSepratorLineHeight (1.0 / [UIScreen mainScreen].scale)

#endif /* JHConstants_Device_h */
