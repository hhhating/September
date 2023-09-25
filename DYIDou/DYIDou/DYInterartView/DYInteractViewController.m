//
//  DYInteractViewController.m
//  DYIDou
//
//  Created by ByteDance on 2023/9/22.
//

#import "DYInteractViewController.h"
#import "DYShareView.h"
static CGFloat widthHeight = 50;
static CGFloat labelHeight = 15;
static const NSInteger kAwemeListLikeCommentTag = 0x01;
static const NSInteger kAwemeListLikeShareTag   = 0x02;
@interface DYInteractViewController ()
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UITapGestureRecognizer *singleTapGesture;
@end

@implementation DYInteractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.container];
    [self initSubview];
    [self.likeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.width.equalTo(@(widthHeight));
        make.height.equalTo(@(widthHeight));
    }];
    [self.likeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(50);
        make.width.equalTo(@(widthHeight));
        make.height.equalTo(@(labelHeight));
    }];
    [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(75);
        make.width.equalTo(@(widthHeight));
        make.height.equalTo(@(widthHeight));
    }];
    [self.commentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(125);
        make.width.equalTo(@(widthHeight));
        make.height.equalTo(@(labelHeight));
    }];
    [self.share mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(150);
        make.width.equalTo(@(widthHeight));
        make.height.equalTo(@(widthHeight));
    }];
    [self.shareNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(200);
        make.width.equalTo(@(widthHeight));
        make.height.equalTo(@(labelHeight));
    }];
    [self.musicAlbum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.likeView.mas_bottom).offset(180);
        make.width.equalTo(@(widthHeight));
        make.height.equalTo(@(widthHeight));
    }];
    [self.musicAlbum startAnimation:12];
}

#pragma mark - method
- (void)initSubview {
    [self.view addSubview:self.likeView];
    [self.view addSubview:self.likeNum];
    [self.view addSubview:self.musicAlbum];
    [self.view addGestureRecognizer:self.singleTapGesture];
    [self.view addSubview:self.comment];
    [self.view addSubview:self.commentNum];
    [self.view addSubview:self.likeNum];
    [self.view addSubview:self.share];
    [self.view addSubview:self.shareNum];
}


- (void)handleGesture:(UITapGestureRecognizer *)sender {
    switch (sender.view.tag) {
        case kAwemeListLikeCommentTag: {
//            CommentsPopView *popView = [[CommentsPopView alloc] initWithAwemeId:_aweme.aweme_id];
//            [popView show];
            break;
        }
        case kAwemeListLikeShareTag: {
            DYShareView *popView = [[DYShareView alloc] init];
            [popView show];
            break;
        }
        default: {
//            //获取点击坐标，用于设置爱心显示位置
//            CGPoint point = [sender locationInView:self.container];
//            //获取当前时间
//            NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
//            //判断当前点击时间与上次点击时间的时间间隔
//            if(time - self.lastTapTime > 0.25f) {
//                //推迟0.25秒执行单击方法
//                [self performSelector:@selector(singleTapAction) withObject:nil afterDelay:0.25f];
//            }else {
//                //取消执行单击方法
//                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTapAction) object: nil];
//                //执行连击显示爱心的方法
//                [self showLikeViewAnim:point oldPoint:self.lastTapPoint];
//            }
//            //更新上一次点击位置
//            self.lastTapPoint = point;
//            //更新上一次点击时间
//            self.lastTapTime =  time;
            break;
        }
    }
    
}
#pragma mark - getter
- (DYLikeView *)likeView {
    if (!_likeView) {
        _likeView = [[DYLikeView alloc] initWithFrame:CGRectMake(0, 0, widthHeight, widthHeight)];
        _likeView.likeDuration = 0.5;
        _likeView.likeColor = [UIColor redColor];
    }
    return _likeView;
}

- (DYMusicAlbumView *)musicAlbum {
    if (!_musicAlbum) {
        _musicAlbum = [[DYMusicAlbumView alloc] initWithFrame:CGRectMake(0, 0, widthHeight, widthHeight)];
        
        __weak __typeof(self) wself = self;
        //加载网络图
        [_musicAlbum.album sd_setImageWithURL:[NSURL URLWithString:@"https://img.freepik.com/free-photo/beautiful-fluffy-cat-bed-generative-ai_169016-28980.jpg"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(!error) {
                wself.musicAlbum.album.image = image;
            }
        }];
    }
    return _musicAlbum;
}

- (UIView *)container {
    if (!_container) {
        _container = [UIView new];
    }
    return _container;
}

- (UITapGestureRecognizer *)singleTapGesture {
    if (!_singleTapGesture) {
        _singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    }
    return _singleTapGesture;
}

- (UIImageView *)comment {
    if (!_comment) {
        _comment = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, widthHeight, widthHeight)];
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
        _commentNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, widthHeight, labelHeight)];
        _commentNum.text = @"14.2w";
        _commentNum.textColor = [UIColor whiteColor];
        _commentNum.font = [UIFont systemFontOfSize:12.0];
        _commentNum.textAlignment = NSTextAlignmentCenter;
    }
    return _commentNum;
}

- (UILabel *)likeNum {
    if (!_likeNum) {
        _likeNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, widthHeight, labelHeight)];
        _likeNum.text = @"66.8w";
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
        _shareNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, widthHeight, 20)];
        _shareNum.text = @"7.2w";
        _shareNum.textColor = [UIColor whiteColor];
        _shareNum.font = [UIFont systemFontOfSize:12.0];
        _shareNum.textAlignment = NSTextAlignmentCenter;
    }
    return _shareNum;
}

@end
