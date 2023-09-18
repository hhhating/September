//
//  changeColor.m
//  LearnDemo
//
//  Created by ByteDance on 2023/9/14.
//

#import "ChangeColor.h"

@interface ChangeColor () <CAAnimationDelegate>
@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) UIButton *testBtn;

@end

@implementation ChangeColor

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.testBtn];
    self.colorLayer.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)changeColor:(UIButton *)sender {
    // 1. 创建动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    // 2. 设置动画属性
    animation.autoreverses = NO;
    animation.duration = 0.25;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    
    CGFloat red = arc4random() % 255 / 255.0;
    CGFloat green = arc4random() % 255 / 255.0;
    CGFloat blue = arc4random() % 255 / 255.0;
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    animation.toValue = (__bridge id _Nullable)(randomColor.CGColor);
    // 3. 添加动画到图层
    [self.colorLayer addAnimation:animation forKey:@"keyPath_backgroundColor"];
}

#pragma mark - getter
- (CALayer *)colorLayer {
    if (!_colorLayer) {
        _colorLayer = [CALayer layer];
        _colorLayer.frame = CGRectMake(30, 200, CGRectGetWidth(self.view.frame) - 60, 300);
    }
    return _colorLayer;
}

- (UIButton *)testBtn {
    if (!_testBtn) {
        _testBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_testBtn setTitle:@"开始测试" forState:UIControlStateNormal];
        [_testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _testBtn.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
        _testBtn.frame = CGRectMake(60, 700, CGRectGetWidth(self.view.frame) - 60 * 2, 40);
        [_testBtn addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testBtn;
}

@end
