//
//  ImplicitAnimation.m
//  LearnDemo
//
//  Created by ByteDance on 2023/9/11.
//

#import "ImplicitAnimation.h"
#import "DefaultImplicit.h"
#import "WorkImplicit.h"
#import "CustomImplicit.h"

@interface ImplicitAnimation ()
@property (strong, nonatomic) UIButton *button1;
@property (strong, nonatomic) UIButton *button2;
@property (strong, nonatomic) UIButton *button3;
@end

@implementation ImplicitAnimation

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
}

- (void)defaultAnimation:(UIButton *)sender {
    DefaultImplicit *vc = [DefaultImplicit new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)workAnimation:(UIButton *)sender {
    WorkImplicit *vc = [WorkImplicit new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)customAnimation:(UIButton *)sender {
    CustomImplicit *vc = [CustomImplicit new];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - getter
- (UIButton *)button1 {
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button1 setTitle:@"默认存在" forState:UIControlStateNormal];
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
        [_button2 setTitle:@"事务" forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button2.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
        _button2.frame = CGRectMake(100, 360, CGRectGetWidth(self.view.frame) - 100 * 2, 40);
        [_button2 addTarget:self action:@selector(workAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}

- (UIButton *)button3 {
    if (!_button3) {
        _button3 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button3 setTitle:@"自定义图层行为" forState:UIControlStateNormal];
        [_button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button3.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
        _button3.frame = CGRectMake(100, 520, CGRectGetWidth(self.view.frame) - 100 * 2, 40);
        [_button3 addTarget:self action:@selector(customAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button3;
}
@end
