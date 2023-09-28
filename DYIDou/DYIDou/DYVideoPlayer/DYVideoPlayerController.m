//
//  DYVideoPlayerController.m
//  DYIDou
//
//  Created by ByteDance on 2023/9/19.
//

#import "DYVideoPlayerController.h"
#import "DYHelper.h"
#import "UIImage+DYIDou.h"
#import "../DYBaseKit/UIView+DYIDou.h"
static const CGFloat kLabelWidth = 65.0;
static const CGFloat kLabelHeight = 20.0;
static const CGFloat kSliderHeight = 20.0;
static const CGFloat kSliderSize = 10.0;
static const NSString *kOriginalTime = @"00";

@interface DYVideoPlayerController ()
@property (nonatomic, strong) UIButton *pauseButton;
@property (nonatomic, strong) UISlider *playProgress;
@property (nonatomic, strong) UILabel *currentTimeLabel;
@property (nonatomic, strong) UILabel *totalTimeLabel;
@property (nonatomic, strong) DYVideoPlayer *videoPreview;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *playerView;
@property (nonatomic, assign) CGFloat totalTime;
@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat viewHeight;
@end

@implementation DYVideoPlayerController

- (instancetype)initWithView:(CGFloat) width viewHeight:(CGFloat) height {
    if (self) {
        self = [super init];
    }
    _viewWidth = width;
    _viewHeight = height;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubview];
    [self addVideoPlayer];
}

- (void)setUrl:(NSURL *)url {
    _url = url;
    return;
}

#pragma mark - Private method

- (void)addSubview {
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.playerView];
    [self.view addSubview:self.playProgress];
    [self.view addSubview:self.pauseButton];
//    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.currentTimeLabel];
    [self.view addSubview:self.totalTimeLabel];
}

- (void)addVideoPlayer {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    [self.playerView addGestureRecognizer:singleTap];
    _videoPreview = [[DYVideoPlayer alloc] initWithURL:self.url];
    [_videoPreview showPlayerInView:self.playerView withFrame:self.playerView.bounds];
    
    // {zh} 播放时长  {en} Play duration
    __weak typeof(self) weakSelf = self;
    [_videoPreview setCurrentItemDurationCallBack:^(AVPlayer *player, CGFloat duration) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.totalTime = duration;
        NSString *minute = [NSString stringWithFormat:@"%02d", (int)((int)duration % 3600) / 60];
        NSString *second = [NSString stringWithFormat:@"%02d", (int)duration % 60];
        if ((int)duration / 3600 > 0) {
            NSString *hour = [NSString stringWithFormat:@"%02d", (int)duration / 3600];
            strongSelf.totalTimeLabel.text = [NSString stringWithFormat:@"%@:%@:%@", hour, minute, second];
        } else {
            strongSelf.totalTimeLabel.text = [NSString stringWithFormat:@"%@:%@", minute, second];
        }
    }];
    
    // {zh} 播放进度  {en} Play progress
    [_videoPreview setCurrentPlayTimeCallBack:^(AVPlayer *player, CGFloat time) {
        __strong typeof(self) strongSelf = weakSelf;
        NSString *minute = [NSString stringWithFormat:@"%02d", (int)((int)time % 3600) / 60];
        NSString *second = [NSString stringWithFormat:@"%02d", (int)time % 60];
        if ((int)time / 3600 > 0) {
            NSString *hour = [NSString stringWithFormat:@"%02d", (int)time / 3600];
            strongSelf.currentTimeLabel.text = [NSString stringWithFormat:@"%@:%@:%@", hour, minute, second];
        } else {
            strongSelf.currentTimeLabel.text = [NSString stringWithFormat:@"%@:%@", minute, second];
        }
        if (strongSelf.totalTime) {
            strongSelf.playProgress.value = time / strongSelf.totalTime;
        }
    }];
    
    // {zh} 播放器状态 {en} Player status
    [_videoPreview setPlayerStatusChangeCallBack:^(AVPlayer *player, DYPlayerStatus status) {
        __strong typeof(self) strongSelf = weakSelf;
        if (status == DYPlayerStatusFinished) {
            strongSelf.pauseButton.hidden = NO;
        }
    }];
    [self.videoPreview play];
}

#pragma mark - Respond method

- (void)singleTap:(UITapGestureRecognizer *)gesture {
    if (self.videoPreview.player.rate == 1.0) {
        [self.videoPreview pause];
        self.pauseButton.hidden = NO;
    }
}

- (void)pauseButtonClick {
    if (self.videoPreview.player.rate == 1.0) {
        [self.videoPreview pause];
        self.pauseButton.hidden = NO;
    } else {
        [self.videoPreview play];
        self.pauseButton.hidden = YES;
    }
}

- (void)handleSeek {
    [self.videoPreview seekToTime:self.playProgress.value * self.totalTime];
}

#pragma mark - property init

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(self.view.dy_origin.x, 422, 390, 0)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIButton *)pauseButton {
    if (!_pauseButton) {
        _pauseButton = [[UIButton alloc] initWithFrame:(CGRect)CGRectMake(0, 0, 50, 50)];
        _pauseButton.center = self.playerView.center;
        _pauseButton.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage imageNamed:@"video_play"];
        [_pauseButton setImage:image forState:UIControlStateNormal];
        [_pauseButton addTarget:self action:@selector(pauseButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _pauseButton.hidden = YES;
    }
    return _pauseButton;
}

- (UIView *)playerView {
    if (!_playerView) {
        _playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewWidth, self.viewHeight)];
        _playerView.center = self.contentView.center;
    }
    return _playerView;
}

- (UISlider *)playProgress {
    if (!_playProgress) {
        _playProgress = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, self.viewWidth - 2 * kLabelWidth, kSliderHeight)];
        _playProgress.center = CGPointMake(self.playerView.center.x, self.playerView.center.y + self.playerView.frame.size.height/2.0 - kSliderHeight - DYHomeIndicatorHeight());
        CGSize size = CGSizeMake(kSliderSize, kSliderSize);
        [_playProgress setThumbImage:[UIImage dy_imageWithClipImage:[UIImage dy_imageWithColor:[UIColor whiteColor] size:size]] forState:UIControlStateNormal];
        _playProgress.minimumTrackTintColor = [UIColor whiteColor];
        _playProgress.maximumTrackTintColor = [UIColor grayColor];
        [_playProgress addTarget:self action:@selector(handleSeek) forControlEvents:UIControlEventValueChanged];
    }
    return _playProgress;
}

- (UILabel *)currentTimeLabel {
    if (!_currentTimeLabel) {
        _currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kLabelWidth, kLabelHeight)];
        _currentTimeLabel.center = CGPointMake(kLabelWidth/2.0, self.playProgress.center.y);
        _currentTimeLabel.backgroundColor = [UIColor clearColor];
        _currentTimeLabel.font = [UIFont systemFontOfSize:14];
        _currentTimeLabel.textColor = [UIColor whiteColor];
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
        _currentTimeLabel.text = [NSString stringWithFormat:@"%@:%@", kOriginalTime, kOriginalTime];
    }
    return _currentTimeLabel;
}

- (UILabel *)totalTimeLabel {
    if (!_totalTimeLabel) {
        _totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kLabelWidth, kLabelHeight)];
        _totalTimeLabel.center = CGPointMake(self.viewWidth - kLabelWidth/2.0, self.playProgress.center.y);
        _totalTimeLabel.backgroundColor = [UIColor clearColor];
        _totalTimeLabel.font = [UIFont systemFontOfSize:14];
        _totalTimeLabel.textColor = [UIColor whiteColor];
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
        _totalTimeLabel.text = [NSString stringWithFormat:@"%@:%@", kOriginalTime, kOriginalTime];
    }
    return _totalTimeLabel;
}
@end
