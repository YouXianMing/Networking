//
//  ViewController.m
//  NetworkingCraft
//
//  Created by YouXianMing on 15/6/11.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "Networking.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "WeatherNetwork.h"
#import "DownloadTask.h"
#import "AFDownloadRequestOperation.h"
#import "GCD.h"

#define  UPLOAD_PIC_STR  @"UPLOAD_PIC_STR"
#define  WEATHER_DATA    @"WEATHER_DATA"
#define  DOWNLOAD_DATA   @"DOWNLOAD_DATA"


@interface ViewController () <NetworkingDelegate, DownloadTaskDelegate>

@property (nonatomic, strong) WeatherNetwork  *network;
@property (nonatomic, strong) DownloadTask    *downloadTask;
@property (nonatomic, strong) Networking      *uploadPic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 网络请求
//    [self normalRequest];
    
    // 下载任务
//    [self downloadTaskRequest];

    // 上传图片
//    [self uploadPictureRequest];
    
    // 断点下载
//    [self resumeDownload];
    
    // 加载图片
//    [self loadPicture];
    
    // 监听网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationEvent:)
                                                 name:NetworkingReachability
                                               object:nil];
}

#pragma mark ===========================================================

- (void)notificationEvent:(id)sender {
    NSLog(@"%@", sender);
    
    if ([Networking isReachable]) {
        
        if ([Networking isReachableViaWiFi]) {
            NSLog(@"WIFI");
        } else if ([Networking isReachableViaWWAN]) {
            NSLog(@"WWAN");
        }
        
    } else {
        NSLog(@"网络有问题");
    }
}

#pragma mark - 普通请求
- (void)normalRequest {
    self.network      = [WeatherNetwork networkingWithUrlString:@"http://api.openweathermap.org/data/2.5/forecast/daily"
                                              requestDictionary:@{@"lat" : @"39.907501",
                                                                  @"lon" : @"116.397232"}
                                                       delegate:self];
    
    // 设置请求头部信息
    self.network.HTTPHeaderFieldsWithValues = @{@"User-Agent"      : @"NetworkingCraft/1.0 (YouXianMing; iOS 8.3; Scale/2.00)",
                                                @"Accept-Language" : @"zh-Hans;q=0.7, zh-Hant;q=0.6, ja;q=0.5"};

    self.network.flag = WEATHER_DATA;
    [self.network startRequest];
}

#pragma mark - 下载任务
- (void)downloadTaskRequest {
    self.downloadTask = [DownloadTask downloadTaskWithUrlString:@"http://41.duote.com.cn/2345explorer.exe"
                                                  fileDirectory:nil
                                                       fileName:nil
                                                       delegate:self];
    self.downloadTask.flag = DOWNLOAD_DATA;
    [self.downloadTask startDownload];
}

#pragma mark - 上传图片
- (void)uploadPictureRequest {
    
    // 获取数据
    UIImage *image  = [UIImage imageNamed:@"demo"];
    NSData *dataObj = UIImageJPEGRepresentation(image, 1.0);
    
    // 建立请求
    self.uploadPic  = [Networking networkingWithUrlString:@"http://zxapi.saltlight.cn/api/ios/chirld/Add"
                                        requestDictionary:@{@"ContactName"        : @"Lilis",
                                                            @"ContactPhoneNumber" : @"15910514789",
                                                            @"LoseDetail"         : @"小孩失踪了,太可怕了",
                                                            @"address"            : @"",
                                                            @"gender"             : @"2",
                                                            @"verify"             : @"123456"}
                                                 delegate:self
                                          timeoutInterval:nil
                                                     flag:UPLOAD_PIC_STR
                                            requestMethod:UPLOAD_DATA
                                              requestType:HTTPRequestType
                                             responseType:JSONResponseType];
    
    // 构建数据
    self.uploadPic.constructingBodyBlock = ^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:dataObj name:@"upload" fileName:@"image.jpg" mimeType:@""];
    };
    
    // 开始请求
    [self.uploadPic startRequest];
}

#pragma mark - 断点下载
- (void)resumeDownload {
    
    NSLog(@"%@", [NSHomeDirectory() stringByAppendingPathComponent:nil]);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://29.duote.org/antiarp.zip"]];
    AFDownloadRequestOperation *operation = [[AFDownloadRequestOperation alloc] initWithRequest:request
                                                                                 fileIdentifier:@"network.zip"
                                                                                     targetPath:[NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/network.zip"]
                                                                                   shouldResume:YES];
    operation.shouldOverwrite = YES;

    
    // 开始下载
    [operation start];
    
    // 4s后暂停
    [GCDQueue executeInMainQueue:^{
        NSLog(@"暂停");
        [operation pause];
    } afterDelaySecs:4.f];
    
    // 7s后继续恢复
    [GCDQueue executeInMainQueue:^{
        NSLog(@"开始");
        [operation resume];
    } afterDelaySecs:7.f];

    // 查看下载进度
    [operation setProgressiveDownloadProgressBlock:^(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile) {
        
        CGFloat percent = (float)totalBytesReadForFile / (float)totalBytesExpectedToReadForFile;
        NSLog(@"%f %ld  %lld  %lld  %lld", percent, (long)bytesRead, totalBytesRead, totalBytesReadForFile, totalBytesExpectedToReadForFile);
    }];
    
    // 结束block
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"下载成功 %@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"下载失败 %@", error);
        
    }];
    
}

#pragma mark - 加载图片
- (void)loadPicture {
    
    self.view.backgroundColor     = [UIColor blackColor];
    
    UIImageView *imageView        = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
    imageView.layer.borderColor   = [UIColor whiteColor].CGColor;
    imageView.layer.borderWidth   = 4.f;
    imageView.layer.masksToBounds = YES;
    imageView.contentMode         = UIViewContentModeScaleAspectFill;
    imageView.center              = self.view.center;
    [self.view addSubview:imageView];
    
    NSURL *url = [NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/pic/item/f3d3572c11dfa9ec78e256df60d0f703908fc12e.jpg"];
    
    [imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"demo"]];
}

#pragma mark ===========================================================

#pragma mark - 代理方法
- (void)requestSucess:(Networking *)networking data:(id)data {
    
    if ([networking.flag isEqualToString:UPLOAD_PIC_STR]) {
        
        NSLog(@"上传图片 %@", data);
        
    } else if ([networking.flag isEqualToString:WEATHER_DATA]) {
        
        WeatherModel *model = data;
        NSLog(@"普通请求 %@", model.city);
        
    }
}

- (void)requestFailed:(Networking *)networking error:(NSError *)error {

}

- (void)userCanceledFailed:(Networking *)networking error:(NSError *)error {

}

#pragma mark - 代理方法
- (void)downloadTask:(DownloadTask *)downloadTask withProgress:(CGFloat)progress {
    
    if ([downloadTask.flag isEqualToString:DOWNLOAD_DATA]) {
        NSLog(@"%.2f%%", progress * 100);
    }
}

- (void)downloadTask:(DownloadTask *)downloadTask failedWithError:(NSError *)error {

}

- (void)downloadTaskSucess:(DownloadTask *)downloadTask {

}

@end
