//
//  CAAnimationDefault.m
//  LearnDemo
//
//  Created by ByteDance on 2023/9/14.
//

#import "CAAnimationDefault.h"
#import "ChangeColor.h"
#import "CAKeyFrameValues.h"
#import "CAKeyFramePath.h"
#import "CAGroupView.h"
#import "CATransitionView.h"

@interface CAAnimationDefault ()
@property (strong, nonatomic) UIButton *button1;
@property (strong, nonatomic) UIButton *button2;
@property (strong, nonatomic) UIButton *button3;
@property (strong, nonatomic) UIButton *button4;
@property (strong, nonatomic) UIButton *button5;
@end

@implementation CAAnimationDefault
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubview];
}

#pragma mark - method
- (void)addSubview {
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    [self.view addSubview:self.button3];
    [self.view addSubview:self.button4];
    [self.view addSubview:self.button5];
}

- (void)defaultAnimation:(UIButton *)sender {
    ChangeColor *vc = [ChangeColor new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)valuesAnimation:(UIButton *)sender {
    CAKeyFrameValues *vc = [CAKeyFrameValues new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pathAnimation:(UIButton *)sender {
    CAKeyFramePath *vc = [CAKeyFramePath new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)groupAnimation:(UIButton *)sender {
    CAGroupView *vc = [CAGroupView new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)transitionAnimation:(UIButton *)sender {
    CATransitionView *vc = [CATransitionView new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter
- (UIButton *)button1 {
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button1 setTitle:@"改变颜色动画" forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button1.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
        _button1.frame = CGRectMake(100, 200, CGRectGetWidth(self.view.frame) - 100 * 2, 40);
        [_button1 addTarget:self action:@selector(defaultAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}

- (UIButton *)button2 {
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button2 setTitle:@"关键帧动画 - values" forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button2.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
        _button2.frame = CGRectMake(100, 300, CGRectGetWidth(self.view.frame) - 100 * 2, 40);
        [_button2 addTarget:self action:@selector(valuesAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}

- (UIButton *)button3 {
    if (!_button3) {
        _button3 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button3 setTitle:@"关键帧动画 - path" forState:UIControlStateNormal];
        [_button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button3.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
        _button3.frame = CGRectMake(100, 400, CGRectGetWidth(self.view.frame) - 100 * 2, 40);
        [_button3 addTarget:self action:@selector(pathAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button3;
}

- (UIButton *)button4 {
    if (!_button4) {
        _button4 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button4 setTitle:@"组合动画" forState:UIControlStateNormal];
        [_button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button4.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
        _button4.frame = CGRectMake(100, 500, CGRectGetWidth(self.view.frame) - 100 * 2, 40);
        [_button4 addTarget:self action:@selector(groupAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button4;
}

- (UIButton *)button5 {
    if (!_button5) {
        _button5 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button5 setTitle:@"过渡动画" forState:UIControlStateNormal];
        [_button5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button5.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
        _button5.frame = CGRectMake(100, 600, CGRectGetWidth(self.view.frame) - 100 * 2, 40);
        [_button5 addTarget:self action:@selector(transitionAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button5;
}

@end
