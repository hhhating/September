//
//  ViewController.m
//  DYIDou
//
//  Created by ByteDance on 2023/9/19.
//

#import "ViewController.h"
#import "DYVideoPlayer/DYVideoPlayerController.h"
#import "DYBaseKit/UIView+DYIDou.h"
#import "DYInteractViewController.h"
#import "DYSlideListViewController.h"
#import "Config.h"

static CGFloat widthHeight = 50;
#define ColorClear [UIColor clearColor]
@interface ViewController ()
@property (nonatomic, strong) DYVideoPlayerController *playerController;
@property (nonatomic, strong) DYInteractViewController *interactController;
@property (nonatomic, strong) DYSlideListViewController *slideController;
@property (nonatomic, strong) UIButton *enter;
@end

@implementation ViewController

- (instancetype)init {
    if (self) {
        self = [super init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

//    self.playerController = [[DYVideoPlayerController alloc] initWithView:self.view.dy_width viewHeight:self.view.dy_height];
//
//    NSURL *url = [NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
//    self.playerController.url = url;
//
//    [self.view addSubview:self.playerController.view];

//     添加自定义布局约束，这里可以根据你的需要来布局
//    self.playerController.view.translatesAutoresizingMaskIntoConstraints = NO;
//    [NSLayoutConstraint activateConstraints:@[
//        [self.playerController.view.topAnchor constraintEqualToAnchor:self.view.topAnchor],
//        [self.playerController.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
//        [self.playerController.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
//        [self.playerController.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
//    ]];
//    self.interactController = [[DYInteractViewController alloc] init];
//    [self.view addSubview:self.interactController.view];
//    self.interactController.view.translatesAutoresizingMaskIntoConstraints = NO;
//    [NSLayoutConstraint activateConstraints:@[
//        [self.interactController.view.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:480],
//        [self.interactController.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-10],
//        [self.interactController.view.widthAnchor constraintEqualToConstant:50],
//        [self.interactController.view.heightAnchor constraintEqualToAnchor:self.view.heightAnchor constant:-480]
//    ]];
    self.slideController = [[DYSlideListViewController alloc] init];
    [self addChildViewController:self.slideController];
    self.slideController.view.frame = self.view.bounds;
    [self.view addSubview:self.slideController.view];
    [self.slideController didMoveToParentViewController:self];
        
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)onEnterButtonClick:(UIButton *)sender {
    DYSlideListViewController *awemeVC = [[DYSlideListViewController alloc] init];
    [self.navigationController pushViewController:awemeVC animated:YES];
}

- (UIButton *)enter {
    if (!_enter) {
        _enter = [UIButton buttonWithType:UIButtonTypeSystem];
        [_enter setTitle:@"enter" forState:UIControlStateNormal];
        [_enter setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        _enter.backgroundColor = [UIColor blueColor];
        _enter.frame = CGRectMake(100, 200, 120, 40);
        [_enter addTarget:self action:@selector(onEnterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enter;
}

@end
