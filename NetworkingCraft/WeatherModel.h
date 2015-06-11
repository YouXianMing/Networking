//
//  WeatherModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>


@interface WeatherModel : NSObject


@property (nonatomic, strong) NSDictionary   *city;
@property (nonatomic, strong) NSArray        *list;


@property (nonatomic, strong) NSNumber       *message;
@property (nonatomic, strong) NSString       *cod;
@property (nonatomic, strong) NSNumber       *cnt;


- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

