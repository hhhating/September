//
//  CALayerController.m
//  LearnDemo
//
//  Created by ByteDance on 2023/9/11.
//

#import "CALayerController.h"

@class CustomCircleView;
@interface CALayerController ()<CALayerDelegate>
@property (strong, nonatomic) CustomCircleView *customCircleView;
@property (strong, nonatomic) CALayer *customLayer;
@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UILabel *label2;
@end

@interface CustomCircleView : UIView
@end
@implementation CALayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubview];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    // ctx 是一个用于执行绘图操作的图形上下文对象
    // 绘制线条的宽度
    CGContextSetLineWidth(ctx, 10.f);
    // 绘制线条的颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:173.0/255.0 green:216.0/255.0 blue:230.0/255.0 alpha:1.0].CGColor);
    // 在矩形内绘制椭圆
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

- (void)addSubview {
    [self.view addSubview:self.customCircleView];
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    [self.view.layer addSublayer:self.customLayer];
    // 触发绘制
    [self.customLayer display];
}

#pragma mark - getter
- (CustomCircleView *)customCircleView {
    if (!_customCircleView) {
        _customCircleView = [CustomCircleView new];
        _customCircleView.frame = CGRectMake((CGRectGetWidth(self.view.frame) - 100)/2.0, 200, 100, 100);
    }
    return _customCircleView;
}

- (UILabel *)label1 {
    if (!_label1) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(45, 150, 300, 20)];
        _label1.text = @"UIView 方法绘制自定义寄宿图";
        _label1.textAlignment = NSTextAlignmentCenter;
    }
    return _label1;
}

- (CALayer *)customLayer {
    if (!_customLayer) {
        _customLayer = [CALayer layer];
        _customLayer.frame = CGRectMake((CGRectGetWidth(self.view.frame) - 100)/2.0, 400, 100, 100);
        _customLayer.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:250.0/255.0 blue:205.0/255.0 alpha:1.0].CGColor;
        _customLayer.delegate = self;
        _customLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _customLayer;
}

- (UILabel *)label2 {
    if (!_label2) {
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(45, 350, 300, 20)];
        _label2.text = @"CALayer 方法绘制自定义寄宿图";
        _label2.textAlignment = NSTextAlignmentCenter;
    }
    return _label2;
}
@end

@implementation CustomCircleView : UIView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:182.0/255.0 blue:193.0/255.0 alpha:1.0];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // 获取画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 画笔颜色
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:173.0/255.0 green:216.0/255.0 blue:230.0/255.0 alpha:1.0].CGColor);
    // 画笔宽度
    CGFloat lineWidth = 5;
    CGContextSetLineWidth(context, lineWidth);
    // 圆点坐标
    CGFloat centerX = CGRectGetWidth(rect)/2.0;
    CGFloat centerY = CGRectGetHeight(rect)/2.0;
    CGFloat cusRadius = self.frame.size.width/2.0 - lineWidth/2.0;
    CGFloat PI = 3.14;
    // 1.5*PI 表示在圆的上半部分; 1.5*PI 表示在圆的上半部分; 1.5*PI 加上 2*PI 来表示一圈完整的弧线，因此它绘制的是一个完整的圆; NO 表示按顺时针方向绘制。
    CGContextAddArc(context, centerX, centerY, cusRadius, 1.5*PI, 1.5*PI + 2*PI, NO);
    // kCGPathStroke 表示绘制路径的轮廓，即描边。
    CGContextDrawPath(context, kCGPathStroke);
}

@end
