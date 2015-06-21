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
    [self normalRequest];
    
    
    // 下载任务
    [self downloadTaskRequest];
    
    
    // 上传图片
    [self uploadPictureRequest];
}

#pragma mark - 普通请求
- (void)normalRequest {
    self.network      = [WeatherNetwork networkingWithUrlString:@"http://api.openweathermap.org/data/2.5/forecast/daily"
                                              requestDictionary:@{@"lat" : @"39.907501",
                                                                  @"lon" : @"116.397232"}
                                                       delegate:self];
    self.network.flag = WEATHER_DATA;
    [self.network startRequest];
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

#pragma mark - 下载任务
- (void)downloadTaskRequest {
    self.downloadTask = [DownloadTask downloadTaskWithUrlString:@"http://41.duote.com.cn/2345explorer.exe"
                                                  fileDirectory:nil
                                                       fileName:nil
                                                       delegate:self];
    self.downloadTask.flag = DOWNLOAD_DATA;
    [self.downloadTask startDownload];
}

#pragma mark - 代理方法
- (void)requestSucess:(Networking *)networking data:(id)data {
    
    if ([networking.flag isEqualToString:UPLOAD_PIC_STR]) {
        
        NSLog(@"上传图片 %@", data);
        
    } else if ([networking.flag isEqualToString:WEATHER_DATA]) {
        
        NSLog(@"普通请求 %@", data);
        
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
