//
//  DYMusicAlbumView.m
//  DYIDou
//
//  Created by ByteDance on 2023/9/21.
//

#import "DYMusicAlbumView.h"
@interface DYMusicAlbumView ()
@property (nonatomic, strong) UIView *albumContainer;
@end

@implementation DYMusicAlbumView
- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, 50, 50)];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        self.albumContainer = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.albumContainer];
        CALayer *backgroundLayer = [CALayer layer];
        backgroundLayer.frame = self.bounds;
        backgroundLayer.contents = (id)[UIImage imageNamed:@"music_album"].CGImage;
        [self.albumContainer.layer addSublayer:backgroundLayer];
        // 用于自定义图片
        CGFloat w = CGRectGetWidth(frame);
        CGFloat h = CGRectGetHeight(frame);
        CGRect albumFrame = CGRectMake(0, 0, w, h);
        self.album = [[UIImageView alloc]initWithFrame:albumFrame];
        self.album.contentMode = UIViewContentModeScaleAspectFill;
        [self.albumContainer addSubview:self.album];
        self.album.layer.cornerRadius = h / 2.0f;
        self.album.layer.masksToBounds = YES;
    }
    return self;
}

- (void)startAnimation:(CGFloat)rate {
    rate = fabs(rate); // 防止 rate 为负值
    [self resetView];
    // 创建一个绕着 z 轴旋转的动画
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 目标值旋转一周，360 度
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    // 动画持续时间
    rotationAnimation.duration = 6.0f;
    // 动画积累，每次旋转都会基于上一次的旋转状态继续旋转
    rotationAnimation.cumulative = YES;
    // 动画重复次数为无数次
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.albumContainer.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)resetView {
    [self.layer removeAllAnimations];
}

@end
