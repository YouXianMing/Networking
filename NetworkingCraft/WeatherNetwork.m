//
//  WeatherNetwork.m
//  NetworkingCraft
//
//  Created by YouXianMing on 15/6/11.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "WeatherNetwork.h"

@implementation WeatherNetwork

- (id)transformRequestData:(id)data {
    
    WeatherModel *model = [[WeatherModel alloc] initWithDictionary:data];
    return model;
}

+ (instancetype)networkingWithUrlString:(NSString *)urlString
                      requestDictionary:(NSDictionary *)requestDictionary
                               delegate:(id)delegate {
    
    return [WeatherNetwork networkingWithUrlString:urlString
                                 requestDictionary:requestDictionary
                                          delegate:delegate
                                   timeoutInterval:nil
                                              flag:nil
                                     requestMethod:GET_METHOD
                                       requestType:HTTPRequestType
                                      responseType:JSONResponseType];
}

@end
