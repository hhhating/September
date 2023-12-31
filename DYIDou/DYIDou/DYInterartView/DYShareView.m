#import "DYShareView.h"
#import "Config.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>

#pragma mark -- DYShareView
static CGFloat kItemWidth = 68.0;
@interface DYShareView ()
@property (nonatomic, strong) NSArray *topIconsName;
@property (nonatomic, strong) NSArray *topTexts;
@property (nonatomic, strong) NSArray *bottomIconsName;
@property (nonatomic, strong) NSArray *bottomTexts;
@property (nonatomic, strong) UILabel *shareLabel;
@property (nonatomic, strong) UIScrollView *topScrollView;
@property (nonatomic, strong) UIScrollView *bottomScrollView;
@end
@implementation DYShareView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initData];
        self.frame = ScreenFrame;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)]];
        [self addSubview:self.container];
        [self addSubviewToContainer];
    }
    return self;
}

#pragma mark - method
- (void)addSubviewToContainer {
    [self.container addSubview:self.shareLabel];
    [self.container addSubview:self.topScrollView];
    [self.container addSubview:self.bottomScrollView];
}

- (void)onShareItemTap:(UITapGestureRecognizer *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/hhhating/September/tree/master/DYIDou"]
                                        options:@{}
                              completionHandler:nil];
    [self dismiss];
}

- (void)onActionItemTap:(UITapGestureRecognizer *)sender {
    [self dismiss];
}

- (void)handleGuesture:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:_container];
    if(![_container.layer containsPoint:point]) {
        [self dismiss];
        return;
    }
    point = [sender locationInView:_cancel];
    if([_cancel.layer containsPoint:point]) {
        [self dismiss];
    }
}

- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect frame = self.container.frame;
                         frame.origin.y = frame.origin.y - frame.size.height;
                         self.container.frame = frame;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.container.frame;
                         frame.origin.y = frame.origin.y + frame.size.height;
                         self.container.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

#pragma mark - DYShareView getter
- (void)initData {
    _topIconsName = @[
        @"https://img.freepik.com/free-photo/asian-teenager-s-portrait-isolated-blue-studio-background_155003-33140.jpg",
        @"https://img.freepik.com/free-photo/smiley-male-with-backpack_23-2148518154.jpg",
        @"https://img.freepik.com/premium-photo/young-hipster-asian-man-traveling-with-backpack-summer-forest-trip-travel-lifestyle-concept_41471-13022.jpg",
        @"https://img.freepik.com/free-photo/cute-baby-born_624325-1181.jpg",
        @"https://img.freepik.com/premium-photo/school-girl-wear-pink-shirt-jean-holding-holding-pink-book-stairs_323117-2352.jpg",
        @"https://img.freepik.com/free-photo/fun-3d-cartoon-casual-character_183364-80985.jpg",
    ];
    _topTexts = @[
        @"飞越仙女岛🐰",
        @"LiLi",
        @"等风吹🏀",
        @"吃不吃青椒",
        @"姜丝煮可乐i",
        @"Pixel.",
    ];
    _bottomIconsName = @[
        @"icon_forward",
        @"icon_copy",
        @"icon_recommend",
        @"icon_record",
    ];
    _bottomTexts = @[
        @"转发",
        @"复制链接",
        @"推荐给朋友",
        @"合拍",
    ];
}

- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 290 + SafeAreaBottomHeight)];
        _container.backgroundColor = [UIColor whiteColor];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_container.bounds
                                                               byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                                     cornerRadii:CGSizeMake(20.0, 20.0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _container.bounds;
        maskLayer.path = maskPath.CGPath;
        _container.layer.mask = maskLayer;
    }
    return _container;
}

- (UILabel *)shareLabel {
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 13, 100, 35)];
        _shareLabel.textAlignment = NSTextAlignmentCenter;
        _shareLabel.numberOfLines = 0;
        _shareLabel.text = @"分享给朋友";
        _shareLabel.textColor = [UIColor blackColor];
        _shareLabel.font = BigBoldFont;
    }
    return _shareLabel;
}

- (UIScrollView *)topScrollView {
    if (!_topScrollView) {
        _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 56, ScreenWidth, 105)];
        _topScrollView.contentSize = CGSizeMake(kItemWidth * self.topIconsName.count, 80);
        _topScrollView.showsHorizontalScrollIndicator = NO;
        _topScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 30);
        for (NSInteger i = 0; i < self.topIconsName.count; i++) {
            DYShareItem *item = [[DYShareItem alloc] initWithFrame:CGRectMake(20 + (kItemWidth + 13) * i, 0, 58, 105)];
            [item setImageWithURL:self.topIconsName[i]];
            item.label.text = self.topTexts[i];
            item.tag = i;
            [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onShareItemTap:)]];
            [_topScrollView addSubview:item];
        }
    }
    return _topScrollView;
}

- (UIScrollView *)bottomScrollView {
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 175, ScreenWidth, 105)];
        _bottomScrollView.contentSize = CGSizeMake(kItemWidth * self.bottomIconsName.count, 80);
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        _bottomScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 30);
        for (NSInteger i = 0; i < self.bottomIconsName.count; i++) {
            DYShareItem *item = [[DYShareItem alloc] initWithFrame:CGRectMake(20 + (kItemWidth + 13) * i, 0, 58, 105)];
            item.icon.image = [UIImage imageNamed:self.bottomIconsName[i]];
            item.label.text = self.bottomTexts[i];
            item.tag = i;
            [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onActionItemTap:)]];
            [_bottomScrollView addSubview:item];
        }
    }
    return _bottomScrollView;
}
@end

#pragma mark -- DYShareItem
@implementation DYShareItem
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.icon];
        [self addSubview:self.label];
    }
    return self;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(58);
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(10);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.icon.mas_bottom).offset(7);
    }];
}

- (void)setImageWithURL:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    __weak typeof(self) weakSelf = self;
    [self.icon sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!error) {
            weakSelf.icon.image = image;
        }
    }];
}

#pragma mark - DYShareItem getter
- (UIImageView *)icon {
    if (!_icon) {
        CGFloat wh = 58.0f;
        CGRect iconFrame = CGRectMake(wh / 2.0f, wh / 2.0f, wh, wh);
        _icon = [[UIImageView alloc] initWithFrame:iconFrame];
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        _icon.userInteractionEnabled = YES;
        _icon.layer.cornerRadius = wh / 2.0f;
        _icon.layer.masksToBounds = YES;
    }
    return _icon;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.text = @"TEXT";
        _label.textColor = [UIColor blackColor];
        _label.font = SmallBoldFont;
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}
@end
