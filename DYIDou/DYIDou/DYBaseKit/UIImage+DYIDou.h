//
//  UIImage+DYIDou.h
//  DYIDou
//
//  Created by ByteDance on 2023/9/19.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (DYIDou)
+ (UIImage *)dy_imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)dy_imageWithClipImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
