//
//  DYHelper.m
//  DYIDou
//
//  Created by ByteDance on 2023/9/19.
//

#import "DYHelper.h"
#import "UIView+DYIDou.h"
@implementation DYHelper
+ (UIEdgeInsets)safeAreaInsets {
    if (@available(iOS 11.0, *)) {
        return [UIView dy_currentWindow].safeAreaInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}
@end
