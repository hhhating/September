//
//  SharePopView.m
//  DYIDou
//
//  Created by ByteDance on 2023/9/22.
//

#import "SharePopView.h"
#import "Config.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SharePopView

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *topIconsName = @[
                                 @"https://img.freepik.com/free-photo/asian-teenager-s-portrait-isolated-blue-studio-background_155003-33140.jpg",
                                 @"https://img.freepik.com/free-photo/smiley-male-with-backpack_23-2148518154.jpg",
                                 @"https://img.freepik.com/premium-photo/young-hipster-asian-man-traveling-with-backpack-summer-forest-trip-travel-lifestyle-concept_41471-13022.jpg",
                                 @"https://img.freepik.com/free-photo/cute-baby-born_624325-1181.jpg",
                                 @"https://img.freepik.com/premium-photo/school-girl-wear-pink-shirt-jean-holding-holding-pink-book-stairs_323117-2352.jpg",
                                 @"https://img.freepik.com/free-photo/fun-3d-cartoon-casual-character_183364-80985.jpg",
                                 ];
        NSArray *topTexts = @[
                             @"飞越仙女岛🐰",
                             @"LiLi",
                             @"等风吹🏀",
                             @"吃不吃青椒",
                             @"姜丝煮可乐i",
                             @"Pixel.",
                             ];
        NSArray *bottomIconsName = @[
                                    @"icon_forward",
                                    @"icon_copy",
                                    @"icon_recommend",
                                    @"icon_record",
                                    ];
        NSArray *bottomTexts = @[
                                @"转发",
                                @"复制链接",
                                @"推荐给朋友",
                                @"合拍",
                                ];
        
        self.frame = ScreenFrame;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)]];
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 290 + SafeAreaBottomHeight)];
        _container.backgroundColor = [UIColor whiteColor];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_container.bounds
                                                               byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                                     cornerRadii:CGSizeMake(20.0, 20.0)];
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame = _container.bounds;
                maskLayer.path = maskPath.CGPath;
                _container.layer.mask = maskLayer;
                
                [self addSubview:_container];
        [self addSubview:_container];

        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(7, 13, 100, 35)];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.text = @"分享给朋友";
        label.textColor = [UIColor blackColor];
        label.font = BigBoldFont;
        [_container addSubview:label];
        
        
        CGFloat itemWidth = 68;
        
        UIScrollView *topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 56, ScreenWidth, 105)];
        topScrollView.contentSize = CGSizeMake(itemWidth * topIconsName.count, 80);
        topScrollView.showsHorizontalScrollIndicator = NO;
        topScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 30);
        [_container addSubview:topScrollView];
        
        for (NSInteger i = 0; i < topIconsName.count; i++) {
            ShareItem *item = [[ShareItem alloc] initWithFrame:CGRectMake(20 + (itemWidth + 13) * i, 0, 58, 105)];
            [item setImageWithURL:topIconsName[i]];
            item.label.text = topTexts[i];
            item.tag = i;
            [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onShareItemTap:)]];
            [topScrollView addSubview:item];
        }
        
        UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 175, ScreenWidth, 105)];
        bottomScrollView.contentSize = CGSizeMake(itemWidth * bottomIconsName.count, 80);
        bottomScrollView.showsHorizontalScrollIndicator = NO;
        bottomScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 30);
        [_container addSubview:bottomScrollView];
        CGFloat wh = 58.0f;
                
                // 创建大圆形的容器视图
                UIView *circleContainer = [[UIView alloc] initWithFrame:CGRectMake(wh / 2.0f, wh / 2.0f, wh, wh)];
                circleContainer.layer.cornerRadius = wh / 2.0f;
                circleContainer.layer.masksToBounds = YES;
                [self addSubview:circleContainer];
                
                // 创建第一个小圆形图像1
                UIImageView *smallIcon1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
                smallIcon1.layer.cornerRadius = 15; // 设置小圆形的半径
                smallIcon1.layer.masksToBounds = YES;
                [circleContainer addSubview:smallIcon1];
                
                // 创建第二个小圆形图像2
                UIImageView *smallIcon2 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 30, 30)];
                smallIcon2.layer.cornerRadius = 15; // 设置小圆形的半径
                smallIcon2.layer.masksToBounds = YES;
                [circleContainer addSubview:smallIcon2];
                
                // 设置大圆形容器的布局
                [circleContainer mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.height.mas_equalTo(wh);
                    make.centerX.equalTo(self);
                    make.top.equalTo(self).offset(10);
                }];
        for (NSInteger i = 0; i < bottomIconsName.count; i++) {
            ShareItem *item = [[ShareItem alloc] initWithFrame:CGRectMake(20 + (itemWidth + 13) * i, 0, 58, 105)];
            item.icon.image = [UIImage imageNamed:bottomIconsName[i]];
            item.label.text = bottomTexts[i];
            item.tag = i;
            [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onActionItemTap:)]];
            [bottomScrollView addSubview:item];
        }
    }
    return self;
}
- (void)onShareItemTap:(UITapGestureRecognizer *)sender {
    switch (sender.view.tag) {
        case 0:
            break;
        default:
            break;
    }
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/sshiqiao/douyin-ios-objectc"]];
    [self dismiss];
}
- (void)onActionItemTap:(UITapGestureRecognizer *)sender {
    switch (sender.view.tag) {
        case 0:
            break;
        default:
            break;
    }
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
@end

#pragma Item view
@implementation ShareItem
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat wh = 58.0f;
        CGRect iconFrame = CGRectMake(wh / 2.0f, wh / 2.0f, wh, wh);
        _icon = [[UIImageView alloc] initWithFrame:iconFrame];
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        _icon.userInteractionEnabled = YES;
        _icon.layer.cornerRadius = wh / 2.0f;
        _icon.layer.masksToBounds = YES;
        [self addSubview:_icon];
        
        _label = [[UILabel alloc] init];
        _label.text = @"TEXT";
        _label.textColor = [UIColor blackColor];
        _label.font = SmallBoldFont;
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
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

@end

