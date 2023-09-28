//
//  DYSlideListCell.m
//  DYIDou
//
//  Created by ByteDance on 2023/9/25.
//

#import "DYSlideListCell.h"
#import <Masonry/Masonry.h>
#import "Config.h"
#import "DYShareView.h"
#import "../DYBaseKit/UIView+DYIDou.h"
#define RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
static const NSInteger kAwemeListLikeCommentTag = 0x01;
static const NSInteger kAwemeListLikeShareTag   = 0x02;
@interface DYSlideListCell ()
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UITapGestureRecognizer *singleTapGesture;
@property (nonatomic, strong) NSArray *headIconsName;
@end

@implementation DYSlideListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initData];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = RGBA(0.0, 0.0, 0.0, 0.01);
        self.videoPlayerController = [[DYVideoPlayerController alloc] initWithView:390 viewHeight:844];
        NSURL *url = [NSURL URLWithString:@"https://v3.cdnpk.net/videvo_files/video/free/2014-12/large_watermarked/Raindrops_Videvo_preview.mp4"];
        self.videoPlayerController.url = url;
        [self.contentView addSubview:self.videoPlayerController.view];
        [self addSubview];
        [self layoutSubview];
        [self.musicAlbum startAnimation:12];
    }
    return self;
}


#pragma mark - method
- (void)initData {
    _headIconsName = @[
        @"https://img.freepik.com/premium-photo/asian-young-woman-being-angry_180547-1156.jpg",
        @"https://img.freepik.com/free-photo/asian-man-taking-selfie_58466-11503.jpg",
        @"https://img.freepik.com/free-photo/fun-3d-cartoon-casual-character_183364-80985.jpg",
        @"https://img.freepik.com/free-photo/asian-blogger-woman-travel-bangkok-thailand_7861-1320.jpg",
        @"http://p3.music.126.net/h9mt7TJr9ewthxZZiS2yPA==/6026423232495755.jpg",
        @"https://img.freepik.com/free-photo/attractive-beautiful-asian-female-casual-dress-wear-hat-hand-hold-film-camera-travel-vacation-concept-white-background_609648-879.jpg",
        @"https://img.freepik.com/free-photo/cute-woman-hold-hands-gesture-empty-spec-business-woman-concept-pink-background-3d-rendering_56104-1468.jpg",
        @"https://img.freepik.com/free-photo/front-view-smiley-kid-holding-camera_23-2149514062.jpg",
        @"https://img.freepik.com/premium-photo/photo-female-tourist-taking-photo-street-landscape_296537-3310.jpg",
        @"http://ww1.sinaimg.cn/crop.278.0.1448.1448.1024/5a22e1e7jw8eo10kpdkanj21kw148gsh.jpg",
        @"https://img.freepik.com/premium-photo/school-girl-wear-pink-shirt-jean-holding-holding-pink-book-stairs_323117-2352.jpg",
        @"https://img.freepik.com/free-photo/smiley-girl-taking-photos_23-2148480296.jpg",
        @"https://img.freepik.com/premium-photo/young-hipster-asian-man-traveling-with-backpack-summer-forest-trip-travel-lifestyle-concept_41471-13022.jpg",
        @"https://img.freepik.com/premium-photo/cat-looking-forward-3d-illustration_1119-3516.jpg",
        @"https://img.freepik.com/free-photo/asian-teenager-s-portrait-isolated-blue-studio-background_155003-33140.jpg",
        @"https://img.freepik.com/free-photo/curious-glasses-asiasn-man-with-summer-costume-hand-hold-camera-find-something-white-background_609648-1622.jpg",
    ];
}

- (void)addSubview {
    [self.contentView addSubview:self.container];
    [self.container addGestureRecognizer:self.singleTapGesture];
    [self.container addSubview:self.likeView];
    [self.container addSubview:self.likeNum];
    [self.container addSubview:self.comment];
    [self.container addSubview:self.commentNum];
    [self.container addSubview:self.share];
    [self.container addSubview:self.shareNum];
    [self.container addSubview:self.musicAlbum];
    [self.container addSubview:self.head];
}

- (void)handleGesture:(UITapGestureRecognizer *)sender {
    switch (sender.view.tag) {
        case kAwemeListLikeCommentTag: {
            break;
        }
        case kAwemeListLikeShareTag: {
            DYShareView *popView = [[DYShareView alloc] init];
            [popView show];
            break;
        }
        default: {
            break;
        }
    }
}

- (void)layoutSubview {
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).inset(10);
        make.bottom.equalTo(self).inset(70);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(400);
    }];
    [self.musicAlbum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).inset(10);
        make.bottom.equalTo(self).inset(75);
        make.width.height.mas_equalTo(50);
    }];
    [self.share mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.musicAlbum.mas_top).inset(50);
        make.right.equalTo(self).inset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(45);
    }];
    [self.shareNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.share.mas_bottom);
        make.centerX.equalTo(self.share);
    }];
    [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.share.mas_top).inset(25);
        make.right.equalTo(self).inset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(45);
    }];
    [self.commentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.comment.mas_bottom);
        make.centerX.equalTo(self.comment);
    }];
    [self.likeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.comment.mas_top).inset(25);
        make.right.equalTo(self).inset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(45);
    }];
    
    [self.likeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.likeView.mas_bottom);
        make.centerX.equalTo(self.likeView);
    }];
    [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.likeView.mas_top).inset(25);
        make.right.equalTo(self).inset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
}

- (CGFloat)randomFloat {
    CGFloat randomFloat = (CGFloat)arc4random_uniform(1000) / 10.0;
    return randomFloat;
}

#pragma mark - getter
- (UIView *)container {
    if (!_container) {
        _container = [UIView new];
    }
    return _container;
}

- (DYLikeView *)likeView {
    if (!_likeView) {
        _likeView = [DYLikeView new];
        _likeView.likeDuration = 0.5;
        _likeView.likeColor = [UIColor redColor];
    }
    return _likeView;
}

- (DYMusicAlbumView *)musicAlbum {
    if (!_musicAlbum) {
        _musicAlbum = [[DYMusicAlbumView alloc] init];
    }
    return _musicAlbum;
}

- (UITapGestureRecognizer *)singleTapGesture {
    if (!_singleTapGesture) {
        _singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    }
    return _singleTapGesture;
}

- (UIImageView *)comment {
    if (!_comment) {
        _comment = [UIImageView new];
        _comment.contentMode = UIViewContentModeCenter;
        _comment.image = [UIImage imageNamed:@"icon_comment"];
        _comment.userInteractionEnabled = YES;
        _comment.tag = kAwemeListLikeCommentTag;
        [_comment addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
    }
    return _comment;
}

- (UILabel *)commentNum {
    if (!_commentNum) {
        _commentNum = [[UILabel alloc] init];
        _commentNum.text = [NSString stringWithFormat:@"%.1fw", [self randomFloat]];
        _commentNum.textColor = [UIColor whiteColor];
        _commentNum.font = [UIFont systemFontOfSize:12.0];
        _commentNum.textAlignment = NSTextAlignmentCenter;
    }
    return _commentNum;
}

- (UILabel *)likeNum {
    if (!_likeNum) {
        _likeNum = [[UILabel alloc] init];
        _likeNum.text = [NSString stringWithFormat:@"%.1fw", [self randomFloat]];
        _likeNum.textColor = [UIColor whiteColor];
        _likeNum.font = [UIFont systemFontOfSize:12.0];
        _likeNum.textAlignment = NSTextAlignmentCenter;
    }
    return _likeNum;
}

- (UIImageView *)share {
    if (!_share) {
        _share = [[UIImageView alloc]init];
        _share.contentMode = UIViewContentModeCenter;
        _share.image = [UIImage imageNamed:@"icon_share"];
        _share.userInteractionEnabled = YES;
        _share.tag = kAwemeListLikeShareTag;
        [_share addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
    }
    return _share;
}

- (UILabel *)shareNum {
    if (!_shareNum) {
        _shareNum = [[UILabel alloc] init];
        _shareNum.text = [NSString stringWithFormat:@"%.1fw", [self randomFloat]];
        _shareNum.textColor = [UIColor whiteColor];
        _shareNum.font = [UIFont systemFontOfSize:12.0];
        _shareNum.textAlignment = NSTextAlignmentCenter;
    }
    return _shareNum;
}

- (UIImageView *)head {
    if (!_head) {
        CGFloat wh = 50.0f;
        CGRect headFrame = CGRectMake(wh / 2.0f, wh / 2.0f, wh, wh);
        _head = [[UIImageView alloc] initWithFrame:headFrame];
        _head.contentMode = UIViewContentModeScaleAspectFill;
        _head.layer.cornerRadius = wh / 2.0f;
        _head.layer.masksToBounds = YES;
    }
    return _head;
}

- (void)setCurrentIndex:(NSUInteger)currentIndex {
    _currentIndex = currentIndex;
    [self setHeadImageWithURL:self.headIconsName[currentIndex % self.headIconsName.count]];
    [self setMusicAlbumImageWithURL:self.headIconsName[currentIndex % self.headIconsName.count]];
}

- (void)setHeadImageWithURL:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    __weak typeof(self) weakSelf = self;
    [self.head sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!error) {
            weakSelf.head.image = image;
        }
    }];
}

- (void)setMusicAlbumImageWithURL:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    __weak typeof(self) weakSelf = self;
    [self.musicAlbum.album sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!error) {
            weakSelf.musicAlbum.album.image = image;
        }
    }];
}
@end
