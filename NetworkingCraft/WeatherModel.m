//
//  WeatherModel.m
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import "WeatherModel.h"


@implementation WeatherModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    // 进行键值对的转换匹配
    //    if([key isEqualToString:@"id"]) {
    //        self.productID = value;
    //    }
    
}


- (void)setValue:(id)value forKey:(NSString *)key {
    
    // 过滤NSNull值
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    
    // 属性为数组时(数组中的所有元素都为相同类型的对象)
//    if ([key isEqualToString:@"属性名字"] && [value isKindOfClass:[NSArray class]]) {
//        
//        NSArray *tmp              = value;
//        NSMutableArray *dataArray = [NSMutableArray array];
//        
//        for (NSDictionary *info in tmp) {
//            ObjClass *obj  = [[ObjClass alloc] initWithDictionary:info];
//            [dataArray addObject:obj];
//        }
//        
//        value = dataArray;
//    }
    
    // 属性为字典时
//    if ([key isEqualToString:@"属性名字"] && [value isKindOfClass:[NSDictionary class]]) {
//        value = [[ObjClass alloc] initWithDictionary:value];
//    }
    
    [super setValue:value forKey:key];
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        self = [super init];
        if (self) {
            [self setValuesForKeysWithDictionary:dictionary];
        }
        
        return self;
        
    } else {
        return nil;
    }
}


@end

