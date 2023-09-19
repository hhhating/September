//
//  DYVideoPlayer.m
//  DYIDou
//
//  Created by ByteDance on 2023/9/19.
//

#import "DYVideoPlayer.h"

static const NSString *kplayerStatus = @"status";
@interface DYVideoPlayer ()
@property (nonatomic, strong) id timeObserver;
@end
@implementation DYVideoPlayer

#pragma mark - init

- (instancetype)init
{
    if (self = [super init]) {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        [audioSession setActive:YES error:nil];
        self.player = [[AVPlayer alloc] init];
        [self addObserver];
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)url
{
    if (self = [self init]) {
        _currentItem = [[AVPlayerItem alloc] initWithURL:url];
        [self.player replaceCurrentItemWithPlayerItem:_currentItem];
        [_currentItem addObserver:self forKeyPath:kplayerStatus options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver];
}

#pragma mark - Public method

- (void)showPlayerInView:(UIView *)view withFrame:(CGRect)frame
{
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    _playerLayer.frame = frame;
    _playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [view.layer addSublayer:_playerLayer];
}

- (void)play
{
    [self.player play];
    self.playerStatus = DYPlayerStatusPlaying;
}

- (void)pause
{
    [self.player pause];
    self.playerStatus = DYPlayerStatusPausing;
}

- (void)stop
{
    self.playerStatus = DYPlayerStatusFinished;
    [self.currentItem seekToTime:kCMTimeZero toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self.currentItem cancelPendingSeeks];
}

- (void)seekToTime:(CGFloat)time
{
    [self.currentItem seekToTime:CMTimeMakeWithSeconds(time, 1.0) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

#pragma mark - Private method

- (void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    __weak typeof(self) weakSelf = self;
    self.timeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf.currentPlayTimeCallBack) {
            CMTime currentTime = strongSelf.currentItem.currentTime;
            float currentPlayTime = (double)currentTime.value / currentTime.timescale;
            strongSelf.currentPlayTimeCallBack(strongSelf.player, currentPlayTime);
        }
    }];
}

- (void)setPlayerStatus:(DYPlayerStatus)playerStatus {
    if (_playerStatus != playerStatus) {
        _playerStatus = playerStatus;
        DY_BLOCK_INVOKE(self.playerStatusChangeCallBack, self.player, self.playerStatus);
    }
}

- (void)removeObserver
{
    [self.player removeTimeObserver:self.timeObserver];
    if (self.currentItem) {
        [self.currentItem removeObserver:self forKeyPath:kplayerStatus];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:kplayerStatus]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay) {
            if (self.currentItemDurationCallBack) {
                CGFloat duration = CMTimeGetSeconds(self.currentItem.duration);
                DY_BLOCK_INVOKE(self.currentItemDurationCallBack, self.player, duration);
            }
        }
    } else if ([keyPath isEqualToString:@"playerStatus"]) {
        if (self.playerStatusChangeCallBack) {
            DY_BLOCK_INVOKE(self.playerStatusChangeCallBack, self.player, self.playerStatus);
        }
    }
}

#pragma mark - notification

- (void)playbackFinished:(NSNotification *)notification
{
    AVPlayerItem *playerItem = (AVPlayerItem *)notification.object;
    if (playerItem == self.currentItem) {
        [self stop];
    }
}

@end

