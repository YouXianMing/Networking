//
//  Networking.h
//  NetworkingCraft
//
//  Created by YouXianMing on 15/6/11.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Networking;


typedef enum : NSUInteger {
    
    GET_METHOD,                  // GET请求
    POST_METHOD,                 // POST请求
    
} AFNetworkingRequestMethod;


typedef enum : NSUInteger {
    
    HTTPRequestType = 0x11,      // 二进制格式 (不设置的话为默认格式)
    JSONRequestType,             // JSON方式
    PlistRequestType,            // 集合文件方式
    
} AFNetworkingRequestType;


typedef enum : NSUInteger {
    
    HTTPResponseType = 0x22,     // 二进制格式 (不设置的话为默认格式)
    JSONResponseType,            // JSON方式
    PlistResponseType,           // 集合文件方式
    ImageResponseType,           // 图片方式
    CompoundResponseType,        // 组合方式
    
} AFNetworkingResponseType;


@protocol NetworkingDelegate <NSObject>
@optional
/**
 *  请求成功
 *
 *  @param networking Networking实例对象
 *  @param data       数据
 */
- (void)requestSucess:(Networking *)networking data:(id)data;

/**
 *  请求失败
 *
 *  @param networking Networking实例对象
 *  @param error      错误信息
 */
- (void)requestFailed:(Networking *)networking error:(NSError *)error;

/**
 *  用户取消请求
 *
 *  @param networking Networking实例对象
 *  @param error      错误信息
 */
- (void)userCanceledFailed:(Networking *)networking error:(NSError *)error;

@end

@interface Networking : NSObject

/**
 *  代理
 */
@property (nonatomic, weak)  id <NetworkingDelegate>  delegate;

/**
 *  标识符
 */
@property (nonatomic, strong) NSString               *flag;

/**
 *  超时时间间隔(设置了才能生效,不设置,使用的是AFNetworking自身的超时时间间隔)
 */
@property (nonatomic, strong) NSNumber               *timeoutInterval;

/**
 *  请求的类型
 */
@property (nonatomic) AFNetworkingRequestType         requestType;

/**
 *  回复的类型
 */
@property (nonatomic) AFNetworkingResponseType        responseType;

/**
 *  请求的方法类型
 */
@property (nonatomic) AFNetworkingRequestMethod       RequestMethod;

/**
 *  网络请求地址
 */
@property (nonatomic, strong) NSString               *urlString;

/**
 *  作为请求用字典
 */
@property (nonatomic, strong) NSDictionary           *requestDictionary;

/**
 *
 *  -====== 此方法由继承的子类来重载实现 ======-
 *
 *  转换请求字典
 *
 *  @return 转换后的字典
 */
- (NSDictionary *)transformRequestDictionary;

/**
 *
 *  -====== 此方法由继承的子类来重载实现 ======-
 *
 *  对返回的结果进行转换
 *
 *  @return 转换后的结果
 */
- (id)transformRequestData:(id)data;

/**
 *  开始请求
 */
- (void)startRequest;

/**
 *  取消请求
 */
- (void)cancelRequest;

#pragma mark - 便利构造器方法

/**
 *  便利构造器方法
 *
 *  @param urlString         请求地址
 *  @param requestDictionary 请求参数
 *  @param delegate          代理
 *  @param timeoutInterval   超时时间
 *  @param flag              标签
 *  @param requestMethod     请求方法
 *  @param requestType       请求类型
 *  @param responseType      回复数据类型
 *
 *  @return 实例对象
 */
+ (instancetype)networkingWithUrlString:(NSString *)urlString
                      requestDictionary:(NSDictionary *)requestDictionary
                               delegate:(id)delegate
                        timeoutInterval:(NSNumber *)timeoutInterval
                                   flag:(NSString *)flag
                          requestMethod:(AFNetworkingRequestMethod)requestMethod
                            requestType:(AFNetworkingRequestType)requestType
                           responseType:(AFNetworkingResponseType)responseType;

@end
