//
//  CAKeyFrameValues.m
//  LearnDemo
//
//  Created by ByteDance on 2023/9/15.
//

#import "CAKeyFrameValues.h"

@interface CAKeyFrameValues ()
@property (nonatomic, strong) UIView *testView;
@property (nonatomic, strong) CAKeyframeAnimation *animation;
@end

@implementation CAKeyFrameValues

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.testView];
    [self.testView.layer addAnimation:self.animation forKey:nil];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - getter
- (UIView *)testView {
    if (!_testView) {
        _testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _testView.center = CGPointMake(50, 100);
        _testView.backgroundColor = [UIColor colorWithRed:255/255.0 green:160/255.0 blue:122/255.0 alpha:1];
    }
    return _testView;
}

- (CAKeyframeAnimation *)animation {
    if (!_animation) {
        // 1. 创建动画
        _animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        // 2. 设置动画关键数据
        NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(50, 200)];
        NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.view.frame) - 50, 200)];
        NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.view.frame) - 50, CGRectGetWidth(self.view.frame))];
        NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(50, CGRectGetWidth(self.view.frame))];
        NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(50, 200)];
        _animation.values = @[value1, value2, value3, value4, value5];
        // 3. 设置动画属性
        _animation.repeatCount = MAXFLOAT;
        _animation.autoreverses = NO;
        _animation.removedOnCompletion = NO;
        _animation.duration = 4;
        _animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    }
    return _animation;
}

@end
