//
//  ViewController.m
//  DYIDou
//
//  Created by ByteDance on 2023/9/19.
//

#import "ViewController.h"
#import "DYVideoPlayer/DYVideoPlayerController.h"
#import "DYBaseKit/UIView+DYIDou.h"

@interface ViewController ()
@property (nonatomic, strong) DYVideoPlayerController *playerController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.playerController = [[DYVideoPlayerController alloc] initWithView:self.view.dy_width viewHeight:self.view.dy_height];
    
    NSURL *url = [NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    self.playerController.url = url;
    
    // 添加CKBVideoPreviewController的视图到ViewController的视图
    [self.view addSubview:self.playerController.view];
    
    // 添加自定义布局约束，这里可以根据你的需要来布局
    self.playerController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.playerController.view.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.playerController.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.playerController.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.playerController.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
    ]];
    self.view.backgroundColor = [UIColor whiteColor];
}


@end
