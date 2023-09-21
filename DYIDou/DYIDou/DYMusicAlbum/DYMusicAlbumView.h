//
//  DYMusicAlbumView.h
//  DYIDou
//
//  Created by ByteDance on 2023/9/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYMusicAlbumView : UIView
@property (nonatomic, strong) UIImageView *album;
/**
 开始动画
 @param rate 动画时间系数
 */
- (void)startAnimation:(CGFloat)rate;

/**
 重置视图 删除所有已添加的动画组
 */
- (void)resetView;
@end

NS_ASSUME_NONNULL_END
