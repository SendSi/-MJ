//
//  RGUtilObject.h
//  读取MJ
//
//  Created by SunSi on 16/12/18.
//  Copyright © 2016年 SunSi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RGUtilModel;


@interface RGUtilObject : NSObject
/** 通过GCD方法实现单例  */
+ (instancetype)instance;

@property (nonatomic, strong) NSMutableArray<RGUtilModel *> *allArrItems;
@property (nonatomic, strong) NSMutableArray<RGUtilModel *> *selectedArrItems;

+ (NSArray<RGUtilModel *> *)sort:(NSArray<RGUtilModel *> *)items;

#pragma mark - 存档与读取
+ (BOOL)saveLEDInput:(NSArray<RGUtilModel *> *)inputModels;

+ (NSMutableArray<RGUtilModel *> *)getLEDInput;

/** *  保存到 磁盘/内存 */
- (void)addItems:(NSArray<RGUtilModel *> *)items;

/** *  移除部分 磁盘/内存 */
- (void)removeItems:(NSArray<RGUtilModel *> *)items;

/** *  移除全部 磁盘/内存 */
- (void)removeAllItems;

- (void)save;

@end


@interface RGUtilModel : NSObject

@property (nonatomic, copy) NSString* name;//名字
@property (nonatomic, assign) NSInteger number;//编号
@property (nonatomic, assign) NSInteger address;//地址
@property (nonatomic, assign) NSInteger mode;//模式,chandelier
@property (nonatomic, strong) NSMutableArray<NSNumber *>* datas;//填充数据

@end
