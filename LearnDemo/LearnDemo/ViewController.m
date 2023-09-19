//
//  ViewController.m
//  LearnDemo
//
//  Created by ByteDance on 2023/9/11.
//

#import "ViewController.h"
#import "CALayerController.h"
#import "RotateAnimation.h"
#import "ImplicitAnimation.h"
#import "CAAnimationDefault.h"
#import "SessionController.h"
#import "DYHomeController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        NSArray *arr = @[@[@"自定义绘制", @"旋转动画", @"隐式动画", @"CAAnimation 动画", @"网络编程", @"抖音"]];
        _dataArr = [NSMutableArray arrayWithArray:arr];
    }
    return _dataArr;
}

- (void)setUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.width) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
}

#pragma mark - UITabelViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.dataArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSArray *arr = self.dataArr[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    return cell;
}

#pragma mark - UITabelViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSArray *arr = self.dataArr[indexPath.section];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                CALayerController *vc = [CALayerController new];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 1:
            {
                RotateAnimation *vc = [RotateAnimation new];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 2:
            {
                ImplicitAnimation *vc = [ImplicitAnimation new];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 3:
            {
                CAAnimationDefault *vc = [CAAnimationDefault new];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 4:
            {
                SessionController *vc = [SessionController new];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 5:
            {
                DYHomeController *vc = [DYHomeController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
            default:
                break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

@end

