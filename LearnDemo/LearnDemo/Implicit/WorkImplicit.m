//
//  workImplicit.m
//  LearnDemo
//
//  Created by ByteDance on 2023/9/11.
//

#import "WorkImplicit.h"

@interface WorkImplicit ()
@property (strong, nonatomic) CALayer *colorLayer;
@property (strong, nonatomic) UIButton *testBtn;
@end

@implementation WorkImplicit

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view.layer addSublayer:self.colorLayer];
    self.colorLayer.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0].CGColor;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.testBtn];
}

- (void)changeColor:(UIButton *)sender {
    // 开始一个 Core Animation 事务，这表示接下来的一系列图层操作将在一个事务中执行
    [CATransaction begin];
    [CATransaction setAnimationDuration:3];
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.colorLayer.affineTransform;
        // M_PI_2，π/2 弧度即旋转 90°
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.colorLayer.affineTransform = transform;
    }];
    CGFloat red = arc4random() % 255 / 255.0;
    CGFloat green = arc4random() % 255 / 255.0;
    CGFloat blue = arc4random() % 255 / 255.0;
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.colorLayer.backgroundColor = randomColor.CGColor;
    // 提交 Core Animation 事务，这将触发事务内的所有图层属性动画，并在动画完成后执行设置的完成回调块
    [CATransaction commit];
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
