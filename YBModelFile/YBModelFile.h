//
//  YBModelFile.h
//  YBModelFileDemo
//
//
/**
 省去了复制粘贴的环节
 
 
 iOS 效率工具【根据 JSON 自动生成 Model 文件（数据模型）】一句代码自动生成 Model 文件，拖入工程既能使用。 支持 YYModel / MJExtension 的自动映射. 灵活拓展和定制（名字、头文件注解、代码处理器、Code 格式处理器）。省去了复制粘贴的环节
 
 
 id可以做属性呀。Mac上其实有JSONExport了，只是我这个不用复制粘贴更偷懒而已。

 ESJsonFormatForMac
 https://github.com/czhen09/ESJsonFormatForMac
 */
#import <Foundation/Foundation.h>
#import "YBMFConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBModelFile : NSObject

+ (void)createFileWithName:(NSString *)name data:(id)data;

+ (void)createFileWithName:(NSString *)name data:(id)data config:(YBMFConfig *)config;

/**
 生成 Model 文件

 @param name 主 Model 文件名
 @param data 数据源 (字典/数组/json数据/json字符串/json文件名)
 @param config 配置 (默认为 [YBMFConfig shareConfig])
 @param path 文件生成路径 (默认为桌面 YBModelFile-Workspace 文件夹)
 */
+ (void)createFileWithName:(NSString *)name data:(id)data config:(nullable YBMFConfig *)config path:(nullable NSString *)path ;

@end

NS_ASSUME_NONNULL_END
