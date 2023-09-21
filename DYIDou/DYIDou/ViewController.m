//
//  ViewController.m
//  DYIDou
//
//  Created by ByteDance on 2023/9/19.
//

#import "ViewController.h"
#import "DYVideoPlayer/DYVideoPlayerController.h"
#import "DYBaseKit/UIView+DYIDou.h"
#import "DYVideoLike/DYLikeView.h"
#import "DYMusicAlbum/DYMusicAlbumView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

static CGFloat widthHeight = 50;

@interface ViewController ()
@property (nonatomic, strong) DYVideoPlayerController *playerController;
@property (nonatomic, strong) DYLikeView *likeView;
@property (nonatomic, strong) DYMusicAlbumView *musicAlbum;
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

    self.likeView = [[DYLikeView alloc] initWithFrame:CGRectMake(0, 0, widthHeight, widthHeight)];
    [self.view addSubview:self.likeView];
    self.likeView.likeDuration = 0.5;
    self.likeView.likeColor = [UIColor redColor];
    [self.likeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(480);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.width.equalTo(@(widthHeight));
        make.height.equalTo(@(widthHeight));
    }];

    self.musicAlbum = [[DYMusicAlbumView alloc] initWithFrame:CGRectMake(0, 0, widthHeight, widthHeight)];
    [self.view addSubview:self.musicAlbum];
    
    __weak __typeof(self) wself = self;
    //加载网络图
    [self.musicAlbum.album sd_setImageWithURL:[NSURL URLWithString:@"https://img.freepik.com/free-photo/beautiful-fluffy-cat-bed-generative-ai_169016-28980.jpg"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(!error) {
            wself.musicAlbum.album.image = image;
        }
    }];
    [self.musicAlbum startAnimation:12];
    [self.musicAlbum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.likeView.mas_bottom).offset(180);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.width.equalTo(@(widthHeight));
        make.height.equalTo(@(widthHeight));
    }];

}


@end
