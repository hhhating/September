//
//  RotateAnimation.m
//  LearnDemo
//
//  Created by ByteDance on 2023/9/11.
//

#import "RotateAnimation.h"

@interface RotateAnimation ()
@property (strong, nonatomic) UIView *viewA;
@property (strong, nonatomic) UIView *viewB;
@end

@implementation RotateAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubview];
    
    [self addRotationAnimation:self.viewA withDuration:3];
    [self resetAnchorPoint:CGPointMake(0, 0) forView:self.viewB];
    [self addRotationAnimation:self.viewB withDuration:3];
}

- (void)addSubview {
    [self.view addSubview:self.viewA];
    [self.view addSubview:self.viewB];
}

- (void)resetAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    CGRect frame = view.frame;
    view.layer.anchorPoint = anchorPoint;
    // 将视图的框架（位置和大小）恢复到之前获取的框架，以确保视图的位置不变。
    // 这是因为更改锚点会影响到视图的位置，通过将框架恢复到原始状态，可以保持视图在屏幕上的位置不变，但是以新的锚点为中心进行变换。
    view.frame = frame;
}

- (void)addRotationAnimation:(__kindof UIView *)view withDuration:(CFTimeInterval)duration {
    // 表示绕着 Z 轴旋转
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // M_PI * 2.0，表示视图将绕 Z 轴逆时针旋转一整圈（360度）。负号表示逆时针旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat: -M_PI * 2.0];
    // 动画持续时间
    rotationAnimation.duration = duration;
    // 动画是否累积，设置为 YES 表示每次动画都会从上一次结束的位置开始，累积旋转。这通常用于创建连续旋转的效果
    rotationAnimation.cumulative = YES;
    // 动画的重复次数，这里设置为 MAXFLOAT，表示动画无限循环，一直旋转下去
    rotationAnimation.repeatCount = MAXFLOAT;
    // 动画完成后不要自动从图层中移除，这样动画结束后仍然保持在视图上的效果
    rotationAnimation.removedOnCompletion = NO;
    // 将创建的动画对象添加到视图的图层上，并为该动画指定一个键值（"rotationAnimation"）。这个键值用于标识动画，以后可以通过这个键值来获取或移除动画
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

#pragma mark - getter
- (UIView *)viewA {
    if (!_viewA) {
        _viewA = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 100)/2.0, 150, 100, 100)];
        _viewA.backgroundColor = [UIColor colorWithRed:255/255.0 green:160/255.0 blue:122/255.0 alpha:1.0];
    }
    return _viewA;
}

- (UIView *)viewB {
    if (!_viewB) {
        _viewB = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 100)/2.0, 450, 100, 100)];
        _viewB.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
    }
    return _viewB;
}

@end
