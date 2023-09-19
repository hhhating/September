//
//  LikeViewController.m
//  LearnDemo
//
//  Created by ByteDance on 2023/9/19.
//

#import "LikeViewController.h"
#import "LikeView.h"
#import <Masonry/Masonry.h>

@interface LikeViewController ()
@property (nonatomic, strong) LikeView *likeView;
@end

@implementation LikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat dx = 5; //倍数
    CGFloat width = 50 * dx;
    CGFloat height = 45 * dx;
    self.likeView = [[LikeView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self.view addSubview:self.likeView];
    self.likeView.likeDuration = 0.5;
    self.likeView.likeColor = [UIColor redColor];
    [self.likeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
}

@end
