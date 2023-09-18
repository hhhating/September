//
//  customImplicit.m
//  LearnDemo
//
//  Created by ByteDance on 2023/9/11.
//

#import "CustomImplicit.h"

@interface CustomImplicit ()
@property (strong, nonatomic) CALayer *colorLayer;
@property (strong, nonatomic) UIButton *testBtn;
@end

@implementation CustomImplicit

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.testBtn];
    CATransition *transition = [CATransition animation];
    // 设置动画类型为推动
    transition.type = kCATransitionPush;
    // 设置动画的推动方向为从左侧推入
    transition.subtype = kCATransitionFromLeft;
    // 将刚刚创建的 CATransition 动画对象关联到 _colorLayer 的 backgroundColor 属性。
    // 这意味着每当更改 _colorLayer 的 backgroundColor 属性时，都会触发这个动画。
    self.colorLayer.actions = @{@"backgroundColor": transition};
    [self.view.layer addSublayer:self.colorLayer];
    self.colorLayer.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0].CGColor;
}

- (void)changeColor:(UIButton *)sender {
    CGFloat red = arc4random() % 255 / 255.0;
    CGFloat green = arc4random() % 255 / 255.0;
    CGFloat blue = arc4random() % 255 / 255.0;
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.colorLayer.backgroundColor = randomColor.CGColor;
}

#pragma mark - getter
- (CALayer *)colorLayer {
    if (!_colorLayer) {
        _colorLayer = [[CALayer alloc] init];
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
