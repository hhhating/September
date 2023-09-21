//
//  DYLikeView.m
//  DYIDou
//
//  Created by ByteDance on 2023/9/19.
//

#import "DYLikeView.h"
static const NSInteger kFavoriteViewLikeBeforeTag  = 0x01;
static const NSInteger kFavoriteViewLikeAfterTag   = 0x02;
@implementation DYLikeView

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, 100, 90)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        _likeBefore = [[UIImageView alloc] initWithFrame:frame];
        _likeBefore.contentMode = UIViewContentModeCenter;
        _likeBefore.image = [UIImage imageNamed:@"like_before"];
        // 交互互动的功能，允许响应触摸事件
        _likeBefore.userInteractionEnabled = YES;
        _likeBefore.tag = kFavoriteViewLikeBeforeTag;
        [_likeBefore addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
        [self addSubview:_likeBefore];
        
        _likeAfter = [[UIImageView alloc] initWithFrame:frame];
        _likeAfter.contentMode = UIViewContentModeCenter;
        _likeAfter.image = [UIImage imageNamed:@"like_after"];
        _likeAfter.userInteractionEnabled = YES;
        _likeAfter.tag = kFavoriteViewLikeAfterTag;
        [_likeAfter setHidden:YES];
        [_likeAfter addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
        [self addSubview:_likeAfter];
    }
    return self;
}

#pragma mark - getter
- (void)handleGesture:(UITapGestureRecognizer *)sender {
    switch(sender.view.tag) {
        case kFavoriteViewLikeBeforeTag: {
            [self startLikeAnimation:YES];
            break;
        }
        case kFavoriteViewLikeAfterTag: {
            [self startLikeAnimation:NO];
            break;
        }
    }
}

- (void)startLikeAnimation:(BOOL)isLike {
    // 在开始执行动画时关闭交互功能，以防止重复点击
    _likeBefore.userInteractionEnabled = NO;
    _likeAfter.userInteractionEnabled = NO;
    if (isLike) {
        CGFloat length = 30;
        // 支持外界改变动画时长，默认 0.5s
        CGFloat duration = self.likeDuration > 0 ? self.likeDuration : 0.5f;
        for (int i = 0; i < 6; i++) {
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            layer.position = _likeBefore.center;
            // 支持外界改变喜欢颜色，默认红色
            layer.fillColor = self.likeColor == nil ? [UIColor redColor].CGColor : self.likeColor.CGColor;
            
            // 开始路径：startPath 包含完整的三角形路径
            UIBezierPath *startPath = [UIBezierPath bezierPath];
            [startPath moveToPoint:CGPointMake(-2, -length)];
            [startPath addLineToPoint:CGPointMake(2, -length)];
            [startPath addLineToPoint:CGPointMake(0, 0)];
            // 图层将使用 startPath 定义的三角形形状
            layer.path = startPath.CGPath;
            
            // 创建 6 个三角形形状，图层分别绕 z 轴旋转 0 度、60 度、120 度、180 度、240 度和 300 度
            layer.transform = CATransform3DMakeRotation(M_PI / 3.0f * i, 0.0, 0.0, 1.0);
            [self.layer addSublayer:layer];
            
            // 对图层的缩放属性进行动画处理
            CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnim.fromValue = @(0.0);   // 没有缩放状态（不可见）的状态开始
            scaleAnim.toValue = @(1.0);     // 缩放为原始比例，即正常大小
            scaleAnim.duration = duration * 0.2f;
            
            // 结束路径
            UIBezierPath *endPath = [UIBezierPath bezierPath];
            [endPath moveToPoint:CGPointMake(-2, -length)];
            [endPath addLineToPoint:CGPointMake(2, -length)];
            [endPath addLineToPoint:CGPointMake(0, -length)];
            
            CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
            group.removedOnCompletion = NO;
            // 动画效果为先慢慢加速再慢慢减速
            group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            // 动画结束后，图层一直保持动画的最终结束状态
            group.fillMode = kCAFillModeForwards;
            group.duration = duration;
            
            // 改变图层路径的动画
            CABasicAnimation *pathAnim = [CABasicAnimation animationWithKeyPath:@"path"];
            pathAnim.fromValue = (__bridge id)layer.path;
            pathAnim.toValue = (__bridge id)endPath.CGPath;
            pathAnim.beginTime = duration * 0.2f;
            pathAnim.duration = duration * 0.8f;
            
            // 将缩放和改变图层路径的动画组合在一起
            [group setAnimations:@[scaleAnim, pathAnim]];
            [layer addAnimation:group forKey:nil];
        }
        [_likeAfter setHidden:NO];
        // 透明度为 0，代表完全不可见
        _likeAfter.alpha = 0.0f;
        // 逆时针旋转 120 度，x 和 y 方向都缩小为原来的一半
        _likeAfter.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(-M_PI/3*2), 0.5f, 0.5f);
        [UIView animateWithDuration:0.4f      // 动画总的持续时间
                             delay:0.2f     // 延迟执行动画的时间
             usingSpringWithDamping:0.6f     // 是弹簧阻尼系数，控制动画的弹簧效果。值越小，弹簧效果越明显
              initialSpringVelocity:0.8f     // 初始弹簧速度，表示动画的初始速度
                            options:UIViewAnimationOptionCurveEaseIn     // 先慢慢加速，后突然停止
                         animations:^{
                            // 在这部分将 likeBefore 不可见，likeAfter 可见，并将 likeAfter 矫正 & 恢复正常大小
                             self.likeBefore.alpha = 0.0f;
                             self.likeAfter.alpha = 1.0f;
                             self.likeAfter.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(0), 1.0f, 1.0f);
                         }
                         completion:^(BOOL finished) {
                             [self.likeBefore setHidden:YES];
                             self.likeBefore.userInteractionEnabled = YES;
                             self.likeAfter.userInteractionEnabled = YES;
                         }];
    } else {
        [self.likeBefore setHidden:NO];
        self.likeBefore.alpha = 1.0f;
        _likeAfter.alpha = 1.0f;
        _likeAfter.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(0), 1.0f, 1.0f);
        [UIView animateWithDuration:0.35f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                            // 逆时针旋转 45 度，缩放为原始大小的 0.1
                             self.likeAfter.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(-M_PI_4), 0.1f, 0.1f);
                         }
                         completion:^(BOOL finished) {
                             [self.likeAfter setHidden:YES];
                             self.likeBefore.userInteractionEnabled = YES;
                             self.likeAfter.userInteractionEnabled = YES;
                         }];
    }
}

- (void)resetView {
    [_likeBefore setHidden:NO];
    [_likeAfter setHidden:YES];
    [self.layer removeAllAnimations];
}
@end
