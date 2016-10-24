//
//  UIImageView+JHWebImage.m
//  JHKit
//
//  Created by muma on 16/10/6.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "UIImageView+JHKit.h"
#import "SDWebImageManager.h"

@implementation UIImageView (JHWebImage)

- (void)setImageWithURL:(nullable NSURL *)url
       placeholderImage:(nullable UIImage *)placeholder
                options:(SDWebImageOptions)options {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options];
}

- (void)setImageWithURL:(nullable NSURL *)url
       placeholderImage:(nullable UIImage *)placeholder
                options:(SDWebImageOptions)options
              completed:(nullable SDExternalCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options completed:completedBlock];
}

- (void)setImageWithURL:(nullable NSURL *)url
       placeholderImage:(nullable UIImage *)placeholder
                options:(SDWebImageOptions)options
               progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
              completed:(nullable SDExternalCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:progressBlock completed:completedBlock];
}

@end
