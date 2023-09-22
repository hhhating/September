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
static CGFloat widthHeight = 50;

@interface ViewController ()
@property (nonatomic, strong) DYVideoPlayerController *playerController;
@property (nonatomic, strong) DYInteractViewController *interactController;
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

    self.playerController = [[DYVideoPlayerController alloc] initWithView:self.view.dy_width viewHeight:self.view.dy_height];
    
    NSURL *url = [NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    self.playerController.url = url;
    
    [self.view addSubview:self.playerController.view];
    
    // 添加自定义布局约束，这里可以根据你的需要来布局
    self.playerController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.playerController.view.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.playerController.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.playerController.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.playerController.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
    ]];
    
    self.interactController = [[DYInteractViewController alloc] init];
    [self.view addSubview:self.interactController.view];
    self.interactController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.interactController.view.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:480],
        [self.interactController.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-10],
        [self.interactController.view.widthAnchor constraintEqualToConstant:50],
        [self.interactController.view.heightAnchor constraintEqualToAnchor:self.view.heightAnchor constant:-480]
    ]];
    self.view.backgroundColor = [UIColor whiteColor];
}


@end
