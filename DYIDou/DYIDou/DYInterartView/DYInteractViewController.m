//
//  DYInteractViewController.m
//  DYIDou
//
//  Created by ByteDance on 2023/9/22.
//

#import "DYInteractViewController.h"
#import "DYVideoLike/DYLikeView.h"
#import "DYMusicAlbum/DYMusicAlbumView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

static CGFloat widthHeight = 50;
@interface DYInteractViewController ()
@property (nonatomic, strong) DYLikeView *likeView;
@property (nonatomic, strong) DYMusicAlbumView *musicAlbum;
@end

@implementation DYInteractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.likeView = [[DYLikeView alloc] initWithFrame:CGRectMake(0, 0, widthHeight, widthHeight)];
    [self.view addSubview:self.likeView];
    self.likeView.likeDuration = 0.5;
    self.likeView.likeColor = [UIColor redColor];
    [self.likeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
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
