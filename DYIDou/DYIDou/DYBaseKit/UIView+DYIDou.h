//
//  UIView+DYIDou.h
//  DYIDou
//
//  Created by ByteDance on 2023/9/19.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (DYIDou)
@property (nonatomic, assign) CGFloat dy_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic, assign) CGFloat dy_top;         ///< Shortcut for frame.origin.y
@property (nonatomic, assign) CGFloat dy_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic, assign) CGFloat dy_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic, assign) CGFloat dy_width;       ///< Shortcut for frame.size.width.
@property (nonatomic, assign) CGFloat dy_height;      ///< Shortcut for frame.size.height.
@property (nonatomic, assign) CGFloat dy_centerX;     ///< Shortcut for center.x
@property (nonatomic, assign) CGFloat dy_centerY;     ///< Shortcut for center.y
@property (nonatomic, assign) CGPoint dy_origin;      ///< Shortcut for frame.origin.
@property (nonatomic, assign) CGSize  dy_size;        ///< Shortcut for frame.size.
+ (UIWindow *)dy_currentWindow;
@end

NS_ASSUME_NONNULL_END
