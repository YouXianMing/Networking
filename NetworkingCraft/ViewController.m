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
#import "WeatherNetwork.h"
#import "DownloadTask.h"

@interface ViewController () <NetworkingDelegate, DownloadTaskDelegate>

@property (nonatomic, strong) WeatherNetwork  *network;
@property (nonatomic, strong) DownloadTask    *downloadTask;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 网络请求
    self.network = [WeatherNetwork networkingWithUrlString:@"http://api.openweathermap.org/data/2.5/forecast/daily"
                                         requestDictionary:@{@"lat" : @"39.907501",
                                                             @"lon" : @"116.397232"}
                                                  delegate:self];
    [self.network startRequest];
    
    
    // 下载任务
    self.downloadTask = [DownloadTask downloadTaskWithUrlString:@"http://41.duote.com.cn/2345explorer.exe"
                                                  fileDirectory:nil
                                                       fileName:nil
                                                       delegate:self];
    [self.downloadTask startDownload];
}

#pragma mark - 代理方法
- (void)requestSucess:(Networking *)networking data:(id)data {
    NSLog(@"%@", data);
}

- (void)requestFailed:(Networking *)networking error:(NSError *)error {

}

- (void)userCanceledFailed:(Networking *)networking error:(NSError *)error {

}

#pragma mark - 代理方法
- (void)downloadTask:(DownloadTask *)downloadTask withProgress:(CGFloat)progress {
    NSLog(@"%f", progress);
}

- (void)downloadTask:(DownloadTask *)downloadTask failedWithError:(NSError *)error {

}

- (void)downloadTaskSucess:(DownloadTask *)downloadTask {

}

@end
