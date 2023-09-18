//
//  DefaultImplicit.m
//  LearnDemo
//
//  Created by ByteDance on 2023/9/11.
//

#import "DefaultImplicit.h"

@interface DefaultImplicit ()
@property (strong, nonatomic) CALayer *colorLayer;
@property (strong, nonatomic) UIButton *testBtn;
@end

@implementation DefaultImplicit

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view.layer addSublayer:self.colorLayer];
    self.colorLayer.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0].CGColor;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.testBtn];
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

