//
//  DYVideoPlayer.h
//  DYIDou
//
//  Created by ByteDance on 2023/9/19.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DYPlayerConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface DYVideoPlayer : NSObject
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayerItem *currentItem;
@property (nonatomic, assign) DYPlayerStatus playerStatus;
@property (nonatomic, copy) void(^currentItemDurationCallBack)(AVPlayer *player, CGFloat duration);
@property (nonatomic, copy) void(^currentPlayTimeCallBack)(AVPlayer *player, CGFloat time);
@property (nonatomic, copy) void(^playerStatusChangeCallBack)(AVPlayer *player, DYPlayerStatus status);
- (instancetype)initWithURL:(NSURL *)url;
- (void)showPlayerInView:(UIView *)view withFrame:(CGRect)frame;
- (void)play;
- (void)pause;
- (void)stop;
- (void)seekToTime:(CGFloat)time;
@end

NS_ASSUME_NONNULL_END
