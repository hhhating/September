//
//  DYSlideListCell.m
//  DYIDou
//
//  Created by ByteDance on 2023/9/25.
//

#import "DYSlideListCell.h"
#import <Masonry/Masonry.h>

#define RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@interface DYSlideListCell ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation DYSlideListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = RGBA(0.0, 0.0, 0.0, 0.01);
        
        // 创建和设置UILabel
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont systemFontOfSize:36 weight:UIFontWeightBold];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setCurrentIndex:(NSUInteger)currentIndex {
    _currentIndex = currentIndex;
    self.label.text = [NSString stringWithFormat:@"当前第 %zd 个Cell", currentIndex];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
