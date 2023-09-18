//
//  ConnectionController.m
//  LearnDemo
//
//  Created by ByteDance on 2023/9/18.
//

#import "SessionController.h"

@interface SessionController () <NSURLSessionDelegate, NSURLSessionDownloadDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *resumeButton;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSData *resumeData;  // 用于存储暂停下载时的数据
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) NSString *progressString;
@end

@implementation SessionController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubview];
    [self addObserver:self forKeyPath:@"resumeData" options:NSKeyValueObservingOptionNew context:NULL];
    [self addObserver:self forKeyPath:@"downloadTask" options:NSKeyValueObservingOptionNew context:NULL];
    self.cancelButton.enabled = NO;
    self.resumeButton.enabled = NO;
    self.imageView.hidden = YES;
    
    // 创建 loading 动画视图
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    self.activityIndicator.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    [self.view addSubview:self.activityIndicator];
    
    // 开始 loading 动画
    [self.activityIndicator startAnimating];
    
    // 创建下载任务
    self.downloadTask = [self.session downloadTaskWithURL:[NSURL URLWithString:@"https://cdn.tutsplus.com/mobile/uploads/2013/12/sample.jpg"]];
    
    // 执行任务
    [self.downloadTask resume];
}

#pragma mark - method
- (void)cancel:(UIButton *)sender {
    if (!self.downloadTask) return;
    
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        if (resumeData) {
            [self setResumeData:resumeData];
            [self setDownloadTask:nil];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicator stopAnimating]; // 停止 loading 动画
        });
    }];
}

- (void)resume:(UIButton *)sender {
    if (!self.resumeData) return;
    self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
    [self.downloadTask resume];
    [self setResumeData:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicator startAnimating]; // 开始 loading 动画
    });
}

- (void)addSubview {
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.resumeButton];
    [self.view addSubview:self.progressLabel];
}

#pragma mark - delegate method
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSData *data = [NSData dataWithContentsOfURL:location];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicator stopAnimating]; // 停止 loading 动画
        self.progressView.hidden = YES;
        self.cancelButton.enabled = NO;
        self.imageView.image = [UIImage imageWithData:data];
        self.imageView.hidden = NO;
        self.progressLabel.hidden = YES;
    });
    
    [session finishTasksAndInvalidate];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    // 输出NSLog所在行 方法名称
    NSLog(@"%d %s",__LINE__ ,__PRETTY_FUNCTION__);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    float progress = (double)totalBytesWritten / totalBytesExpectedToWrite;
    int progressPercentage = ceil(progress * 100); // 向上取整为整数百分比

    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = progress;
        self.progressString = [NSString stringWithFormat:@"%d%%", progressPercentage]; // 更新进度字符串为整数
        self.progressLabel.text = self.progressString; // 更新UILabel的文本
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"resumeData"])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.resumeButton.enabled = !(self.resumeData == nil);
        });
    }
    else if ([keyPath isEqualToString:@"downloadTask"])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cancelButton.enabled = !(self.downloadTask == nil);
        });
    }
    else
        // 如果遇到没有观察的属性，将其交由父类处理，父类可能也在观察该属性
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}
- (void)dealloc {
    // 移除观察者
    [self removeObserver:self forKeyPath:@"resumeData"];
    [self removeObserver:self forKeyPath:@"downloadTask"];
}

#pragma mark - getter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(20, 20, 200, 300);
        _imageView.center = self.view.center;
        _imageView.image = [UIImage imageNamed:@"winter"];
    }
    return _imageView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(45, self.imageView.frame.origin.y + 350, 250, 20);
        _progressView.progress = 0.0;
    }
    return _progressView;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.frame = CGRectMake(310, self.imageView.frame.origin.y + 342, 35, 20);
        _progressLabel.textColor = [UIColor blackColor];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.font = [UIFont systemFontOfSize:12];
        _progressLabel.text = @"0%";
    }
    return _progressLabel;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelButton.frame = CGRectMake(45, self.imageView.frame.origin.y + 400, 80, 40);
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        _cancelButton.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
        [_cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)resumeButton {
    if (!_resumeButton) {
        _resumeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _resumeButton.frame = CGRectMake(265, self.imageView.frame.origin.y + 400, 80, 40);
        [_resumeButton setTitle:@"Resume" forState:UIControlStateNormal];
        [_resumeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_resumeButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        _resumeButton.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
        [_resumeButton addTarget:self action:@selector(resume:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resumeButton;
}

- (NSURLSession *)session {
    if (!_session) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    }
    return _session;
}

@end
