//
//  UIImageView+JHWebImage.h
//  JHKit
//
//  Created by muma on 16/10/6.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (JHWebImage)

- (void)setImageWithURL:(nullable NSURL *)url
       placeholderImage:(nullable UIImage *)placeholder
                options:(SDWebImageOptions)options;

- (void)setImageWithURL:(nullable NSURL *)url
       placeholderImage:(nullable UIImage *)placeholder
                options:(SDWebImageOptions)options
              completed:(nullable SDExternalCompletionBlock)completedBlock;

- (void)setImageWithURL:(nullable NSURL *)url
       placeholderImage:(nullable UIImage *)placeholder
                options:(SDWebImageOptions)options
               progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
              completed:(nullable SDExternalCompletionBlock)completedBlock;
@end
