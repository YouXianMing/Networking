//
//  WeatherNetwork.h
//  NetworkingCraft
//
//  Created by YouXianMing on 15/6/11.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "Networking.h"
#import "WeatherModel.h"

@interface WeatherNetwork : Networking

+ (instancetype)networkingWithUrlString:(NSString *)urlString
                      requestDictionary:(NSDictionary *)requestDictionary
                               delegate:(id)delegate;

@end
