//
//  DYSlideListViewController.m
//  DYIDou
//
//  Created by ByteDance on 2023/9/25.
//

#import "DYSlideListViewController.h"
#import "DYSlideListCell.h"
#import "Config.h"

static NSUInteger kDataSourceCount = 100;

@interface DYSlideListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger    currentIndex;
@end

@implementation DYSlideListViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentIndex = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

#pragma mark - private methods
- (void)setUpView {
    // 核心在于控制 tableView 的上下边距
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT * 5)];
    // 内容内边距，上、左、下、右
    _tableView.contentInset = UIEdgeInsetsMake(SCREEN_HEIGHT, 0, SCREEN_HEIGHT * 3, 0);
    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO; // 隐藏垂直滚动条
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 去掉单元格之间的分割线
    _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; // 不自动调整 scrollView 内容的内边距

    [_tableView registerClass:[DYSlideListCell class] forCellReuseIdentifier:NSStringFromClass([DYSlideListCell class])];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view addSubview:self.tableView];
        [self.tableView reloadData];
        
        // 当前选中的行，滚动到屏幕中间
        NSIndexPath *curIndexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
        [self.tableView scrollToRowAtIndexPath:curIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    });
}

- (UIColor *)randomColor {
    CGFloat hue = (arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kDataSourceCount;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYSlideListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(DYSlideListCell.class)];
    cell.backgroundColor = [self randomColor];
    cell.currentIndex = indexPath.row;
    return cell;
}

#pragma mark - ScrollView delegate
// 当用户在滚动视图中拖动内容并释放时调用，用户在滑动 UITableView 时，当滑动距离达到一定阈值时，自动滚到上一行或下一行
// 并且在滚动期间禁用其他滑动手势，以避免冲突，当滑动动画结束后，再恢复手势的响应
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // UI 更新通常在主线程中执行
    dispatch_async(dispatch_get_main_queue(), ^{
        CGPoint translatedPoint = [scrollView.panGestureRecognizer translationInView:scrollView];
        scrollView.panGestureRecognizer.enabled = NO;
        if(translatedPoint.y < -50 && self.currentIndex < (kDataSourceCount - 1)) {
            self.currentIndex ++;
        }
        if(translatedPoint.y > 50 && self.currentIndex > 0) {
            self.currentIndex --;
        }
        [UIView animateWithDuration:0.15
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut animations:^{
                                //UITableView滑动到指定cell（即某一行），UITableViewScrollPositionTop 表示将指定的行滚动到屏幕顶部
                                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                            } completion:^(BOOL finished) {
                                scrollView.panGestureRecognizer.enabled = YES;
                            }];
        
    });
}

@end
