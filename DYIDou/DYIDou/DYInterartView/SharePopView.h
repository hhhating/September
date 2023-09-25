//
//  SharePopView.h
//  DYIDou
//
//  Created by ByteDance on 2023/9/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SharePopView : UIView
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIButton *cancel;

- (void)show;
- (void)dismiss;

@end


@interface ShareItem : UIView

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *label;
- (void)setImageWithURL:(NSString *)urlString;
@end


//- (void)onShareItemTap:(UITapGestureRecognizer *)sender {
//    switch (sender.view.tag) {
//        case 0:
//            break;
//        default:
//            break;
//    }
////    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/sshiqiao/douyin-ios-objectc"]];
//    [self dismiss];
//}
//- (void)onActionItemTap:(UITapGestureRecognizer *)sender {
//    switch (sender.view.tag) {
//        case 0:
//            break;
//        default:
//            break;
//    }
//    [self dismiss];
//}
//
//- (void)handleGuesture:(UITapGestureRecognizer *)sender {
//    CGPoint point = [sender locationInView:_container];
//    if(![_container.layer containsPoint:point]) {
//        [self dismiss];
//        return;
//    }
//    point = [sender locationInView:_cancel];
//    if([_cancel.layer containsPoint:point]) {
//        [self dismiss];
//    }
//}
//
//- (void)show {
//    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
//    [window addSubview:self];
//    [UIView animateWithDuration:0.15f
//                          delay:0.0f
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         CGRect frame = self.container.frame;
//                         frame.origin.y = frame.origin.y - frame.size.height;
//                         self.container.frame = frame;
//                     }
//                     completion:^(BOOL finished) {
//                     }];
//}
//
//- (void)dismiss {
//    [UIView animateWithDuration:0.15f
//                          delay:0.0f
//                        options:UIViewAnimationOptionCurveEaseIn
//                     animations:^{
//                         CGRect frame = self.container.frame;
//                         frame.origin.y = frame.origin.y + frame.size.height;
//                         self.container.frame = frame;
//                     }
//                     completion:^(BOOL finished) {
//                         [self removeFromSuperview];
//                     }];
//}

NS_ASSUME_NONNULL_END
