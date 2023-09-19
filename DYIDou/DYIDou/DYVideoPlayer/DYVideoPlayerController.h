//
//  DYVideoPlayerController.h
//  DYIDou
//
//  Created by ByteDance on 2023/9/19.
//

#import <Foundation/Foundation.h>
#import "DYVideoPlayer.h"
NS_ASSUME_NONNULL_BEGIN

@interface DYVideoPlayerController : UIViewController
@property (nonatomic, readonly) UIButton *pauseButton;
@property (nonatomic, readonly) UIButton *closeButton;
@property (nonatomic, readonly) UISlider *playProgress;
@property (nonatomic, readonly) UILabel *currentTimeLabel;
@property (nonatomic, readonly) UILabel *totalTimeLabel;
@property (nonatomic, readonly) DYVideoPlayer *videoPreview;
@property (nonatomic, strong) NSURL *url;
- (instancetype)initWithView:(CGFloat) width viewHeight:(CGFloat) height;
@end

NS_ASSUME_NONNULL_END
