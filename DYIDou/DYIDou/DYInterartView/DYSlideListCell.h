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
@property (nonatomic, assign) NSUInteger currentIndex;

@property (nonatomic, strong) DYVideoPlayerController *videoPlayerController;
@property (nonatomic, strong) DYLikeView *likeView;
@property (nonatomic, strong) DYMusicAlbumView *musicAlbum;

@property (nonatomic, strong) UIImageView *head;
@property (nonatomic, strong) UIImageView *share;
@property (nonatomic, strong) UIImageView *comment;

@property (nonatomic, strong) UILabel *shareNum;
@property (nonatomic, strong) UILabel *commentNum;
@property (nonatomic, strong) UILabel *likeNum;
@end

NS_ASSUME_NONNULL_END
