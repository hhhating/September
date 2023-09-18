//
//  CAKeyFramePath.m
//  LearnDemo
//
//  Created by ByteDance on 2023/9/15.
//

#import "CAKeyFramePath.h"

@interface CAKeyFramePath ()
@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, strong) CAShapeLayer *pathLayer;
@property (nonatomic, strong) UIImageView *airPlaneImgView;
@property (nonatomic, strong) CAKeyframeAnimation *animation;
@end

@implementation CAKeyFramePath

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1. 创建贝塞尔曲线
    // 在视图中绘制一条从(50, 200)到(CGRectGetWidth(self.view.frame) - 50, 200)的贝塞尔曲线
    // 控制点分别为(150, 50)和(CGRectGetWidth(self.view.frame) - 150, 250)
    _bezierPath = [[UIBezierPath alloc] init];
    [_bezierPath moveToPoint:CGPointMake(50, 200)];
    [_bezierPath addCurveToPoint:CGPointMake(CGRectGetWidth(self.view.frame) - 50, 200) controlPoint1:CGPointMake(150, 50) controlPoint2:CGPointMake(CGRectGetWidth(self.view.frame) - 150, 250)];
    // 2. 绘制飞行路线
    [self.view.layer addSublayer:self.pathLayer];
    // 3. 显示飞机的视图
    [self.view addSubview:self.airPlaneImgView];
    // 4. 设置关键帧动画
    [self.airPlaneImgView.layer addAnimation:self.animation forKey:nil];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (CAShapeLayer *)pathLayer {
    if (!_pathLayer) {
        _pathLayer = [CAShapeLayer layer];
        _pathLayer.path = self.bezierPath.CGPath;
        _pathLayer.fillColor = [UIColor whiteColor].CGColor;
        _pathLayer.strokeColor = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1].CGColor;
        _pathLayer.lineWidth = 3.0f;
    }
    return _pathLayer;
}

- (UIImageView *)airPlaneImgView {
    if (!_airPlaneImgView) {
        _airPlaneImgView = [[UIImageView alloc] init];
        _airPlaneImgView.frame = CGRectMake(0, 0, 50, 30);
        _airPlaneImgView.center = CGPointMake(50, 200);
        _airPlaneImgView.image = [UIImage imageNamed:@"airplane"];
    }
    return _airPlaneImgView;
}

- (CAKeyframeAnimation *)animation {
    if (!_animation) {
        _animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        _animation.duration = 5.0;
        _animation.path = self.bezierPath.CGPath;
        // 自动旋转的动画效果
        _animation.rotationMode = kCAAnimationRotateAuto;
    }
    return _animation;
}

@end
