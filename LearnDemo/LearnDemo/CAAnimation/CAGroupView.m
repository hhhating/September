//
//  CAGroupView.m
//  LearnDemo
//
//  Created by ByteDance on 2023/9/15.
//

#import "CAGroupView.h"

@interface CAGroupView ()
@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, strong) CAShapeLayer *pathLayer;
@property (nonatomic, strong) UIButton *testBtn;
@end

@implementation CAGroupView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.colorView];
    [self.view addSubview:self.testBtn];
    _bezierPath = [[UIBezierPath alloc] init];
    [_bezierPath moveToPoint:CGPointMake(50, 200)];
    [_bezierPath addCurveToPoint:CGPointMake(CGRectGetWidth(self.view.frame) - 50, 200) controlPoint1:CGPointMake(150, 50) controlPoint2:CGPointMake(CGRectGetWidth(self.view.frame) - 150, 250)];
    [self.view.layer addSublayer:self.pathLayer];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - getter
- (UIView *)colorView {
    if (!_colorView) {
        _colorView = [[UIView alloc] init];
        _colorView.frame = CGRectMake(0, 0, 60, 60);
        _colorView.center = CGPointMake(50, 200);
        _colorView.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1];
    }
    return _colorView;
}

- (CAShapeLayer *)pathLayer {
    if (!_pathLayer) {
        _pathLayer = [CAShapeLayer layer];
        _pathLayer.path = self.bezierPath.CGPath;
        _pathLayer.fillColor = [UIColor clearColor].CGColor;
        _pathLayer.strokeColor = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1].CGColor;
        _pathLayer.lineWidth = 3.0f;
    }
    return _pathLayer;
}

- (void)startAnimation:(UIButton *)sender {
    [self.colorView.layer removeAnimationForKey:@"groupAnimation"];
    // 1. 创建基础动画：修改 view 的背景色
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    basicAnimation.toValue = (__bridge id _Nullable)([UIColor colorWithRed:32/255.0 green:178/255.0 blue:170/255.0 alpha:1].CGColor);
    // 2. 创建关键帧动画
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = self.bezierPath.CGPath;
    keyFrameAnimation.rotationMode = kCAAnimationRotateAuto;
    // 3. 创建组合动画：组合基础动画和关键帧动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[basicAnimation, keyFrameAnimation];
    groupAnimation.duration = 4.0;
    [self.colorView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
}

- (UIButton *)testBtn {
    if (!_testBtn) {
        _testBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_testBtn setTitle:@"开始测试" forState:UIControlStateNormal];
        [_testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _testBtn.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
        _testBtn.frame = CGRectMake(60, 700, CGRectGetWidth(self.view.frame) - 60 * 2, 40);
        [_testBtn addTarget:self action:@selector(startAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testBtn;
}
@end
