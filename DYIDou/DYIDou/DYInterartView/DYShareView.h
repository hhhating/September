//
//  SharePopView.h
//  DYIDou
//
//  Created by ByteDance on 2023/9/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYShareView : UIView
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIButton *cancel;

- (void)show;
- (void)dismiss;

@end


@interface DYShareItem : UIView

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *label;
- (void)setImageWithURL:(NSString *)urlString;
@end

NS_ASSUME_NONNULL_END
