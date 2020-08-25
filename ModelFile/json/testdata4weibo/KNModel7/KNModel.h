//
//  KNModel.h
//  KNModelFileDemo
//
//  Created by kunnan on 2020/08/25.
//  Copyright © 2020 kunnan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface KNAddressModel : NSObject <NSCopying, NSCoding>
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *location;
@end


@interface KNOrderListModel : NSObject <NSCopying, NSCoding>
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *goods;
@end


@interface KNModel : NSObject <NSCopying, NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) KNAddressModel *address;
@property (nonatomic, copy) NSArray<KNOrderListModel *> *orderList;
@end


NS_ASSUME_NONNULL_END
