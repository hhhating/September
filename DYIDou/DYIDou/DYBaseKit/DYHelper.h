//
//  DYHelper.h
//  DYIDou
//
//  Created by ByteDance on 2023/9/19.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYHelper : NSObject
+ (UIEdgeInsets)safeAreaInsets;
@end

NS_ASSUME_NONNULL_END

//  {zh} 刘海屏判断  {en} Notch screen judgment
FOUNDATION_STATIC_INLINE BOOL DYIsIphoneXseries(void) {
    BOOL isIPhoneX = NO;
    if (@available(iOS 11.0, *)) {
        isIPhoneX = [DYHelper safeAreaInsets].bottom > 0.0;
    }
    return isIPhoneX;
}

/**  {zh} 底部横条高度  *  {en} Bottom bar height */
FOUNDATION_STATIC_INLINE CGFloat DYHomeIndicatorHeight(void) {
    return DYIsIphoneXseries() ? 34 : 0;
}
