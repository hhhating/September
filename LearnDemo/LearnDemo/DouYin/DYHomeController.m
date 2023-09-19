//
//  DYHomeController.m
//  LearnDemo
//
//  Created by ByteDance on 2023/9/18.
//

#import "DYHomeController.h"
#import "LikeViewController.h"

@interface DYHomeController ()
@property (nonatomic, strong) UIButton *likeButton;
@end

@implementation DYHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1.0];
    [self addSubview];
}


- (void)addSubview {
    [self.view addSubview:self.likeButton];
}

- (void)likeDemo:(UIButton *)sender {
    LikeViewController *vc = [LikeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter
- (UIButton *)likeButton {
    if (!_likeButton) {
        _likeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_likeButton setTitle:@"点赞 Demo" forState:UIControlStateNormal];
        [_likeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _likeButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:160/255.0 blue:122/255.0 alpha:1.0];
        _likeButton.frame = CGRectMake(100, 300, 190, 70);
        [_likeButton addTarget:self action:@selector(likeDemo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeButton;
}


@end
