//
//  DYInteractViewController.h
//  DYIDou
//
//  Created by ByteDance on 2023/9/22.
//

#import <UIKit/UIKit.h>
#import "DYLikeView.h"
#import "DYMusicAlbumView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYInteractViewController : UIViewController
@property (nonatomic, strong) DYLikeView *likeView;
@property (nonatomic, strong) DYMusicAlbumView *musicAlbum;

@property (nonatomic, strong) UIImageView *share;
@property (nonatomic, strong) UIImageView *comment;

@property (nonatomic, strong) UILabel *shareNum;
@property (nonatomic, strong) UILabel *commentNum;
@property (nonatomic, strong) UILabel *likeNum;
@end

NS_ASSUME_NONNULL_END
