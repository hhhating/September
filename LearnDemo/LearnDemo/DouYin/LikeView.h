//
//  LikeView.h
//  LearnDemo
//
//  Created by ByteDance on 2023/9/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LikeView : UIView

@property (nonatomic, strong) UIImageView *likeBefore;
@property (nonatomic, strong) UIImageView *likeAfter;
@property (nonatomic, assign) CGFloat likeDuration;
@property (nonatomic, assign) UIColor *likeColor;

@end

NS_ASSUME_NONNULL_END
