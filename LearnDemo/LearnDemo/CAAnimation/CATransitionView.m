//
//  CATransitionView.m
//  LearnDemo
//
//  Created by ByteDance on 2023/9/15.
//

#import "CATransitionView.h"

@interface CATransitionView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *subtype;
@property (nonatomic, strong) UIButton *testBtn;
@end

@implementation CATransitionView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.images = @[[UIImage imageNamed:@"spring"],
                   [UIImage imageNamed:@"summer"],
                   [UIImage imageNamed:@"autumn"],
                   [UIImage imageNamed:@"winter"]];
    self.type = kCATransitionReveal;
    self.subtype = kCATransitionFromRight;
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.testBtn];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)performTransitionAnimation:(UIButton *)sender {
    CATransition *transition = [[CATransition alloc] init];
    transition.type = self.type;
    transition.subtype = self.subtype;
    transition.duration = 0.5;
    [self.imageView.layer addAnimation:transition forKey:nil];
    
    UIImage *currentImage = self.imageView.image;
    NSUInteger index = [self.images indexOfObject:currentImage];
    index = (index + 1) % self.images.count;
    self.imageView.image = self.images[index];
}

#pragma mark - getter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 0, 85, 85);
        _imageView.center = self.view.center;
        _imageView.image = [UIImage imageNamed:@"spring"];
    }
    return _imageView;
}

- (UIButton *)testBtn {
    if (!_testBtn) {
        _testBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_testBtn setTitle:@"change" forState:UIControlStateNormal];
        [_testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _testBtn.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
        _testBtn.frame = CGRectMake(60, 700, CGRectGetWidth(self.view.frame) - 60 * 2, 40);
        [_testBtn addTarget:self action:@selector(performTransitionAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testBtn;
}
@end
