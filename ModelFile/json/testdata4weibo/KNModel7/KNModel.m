//
//  KNModel.m
//  KNModelFileDemo
//
//  Created by kunnan on 2020/08/25.
//  Copyright © 2020 kunnan. All rights reserved.
//

#import "KNModel.h"


@implementation KNAddressModel
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[[self class] allocWithZone:zone] init];
    one.city = self.city;
    one.location = self.location;
    return one;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    [self mj_decode:aDecoder];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self mj_encode:aCoder];
}
@end


@implementation KNOrderListModel
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[[self class] allocWithZone:zone] init];
    one.id = self.id;
    one.goods = self.goods;
    return one;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    [self mj_decode:aDecoder];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self mj_encode:aCoder];
}
@end


@implementation KNModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"orderList":@"KNOrderListModel"};
}
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[[self class] allocWithZone:zone] init];
    one.name = self.name;
    one.address = self.address;
    one.orderList = self.orderList;
    return one;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    [self mj_decode:aDecoder];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self mj_encode:aCoder];
}
@end


