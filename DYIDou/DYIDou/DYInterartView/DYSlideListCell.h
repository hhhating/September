//
//  DYSlideListCell.h
//  DYIDou
//
//  Created by ByteDance on 2023/9/25.
//

#import <UIKit/UIKit.h>
#import "DYLikeView.h"
#import "DYMusicAlbumView.h"
#import "DYVideoPlayerController.h"
#import <SDWebImage/UIImageView+WebCache.h>
NS_ASSUME_NONNULL_BEGIN

@interface DYSlideListCell : UITableViewCell
@property (nonatomic, assign) NSUInteger currentIndex;                      // 当前选中单元格的索引

@property (nonatomic, strong) DYVideoPlayerController *videoPlayerController; // 视频播放器
@property (nonatomic, strong) DYLikeView *likeView;                         // 点赞视图
@property (nonatomic, strong) DYMusicAlbumView *musicAlbum;                  // 音乐专辑视图

@property (nonatomic, strong) UIImageView *head;                            // 头像视图
@property (nonatomic, strong) UIView *headView;                             // 头像底部空白视图
@property (nonatomic, strong) UIImageView *share;                           // 分享视图
@property (nonatomic, strong) UIImageView *comment;                         // 评论视图

@property (nonatomic, strong) UILabel *shareNum;                            // 分享数 label
@property (nonatomic, strong) UILabel *commentNum;                          // 评论数 label
@property (nonatomic, strong) UILabel *likeNum;                             // 点赞数 label

@property (nonatomic, strong) UILabel *nikeName;                            // 昵称 label
@property (nonatomic, strong) UILabel *desc;                                // 视频内容描述 label
@end

NS_ASSUME_NONNULL_END
