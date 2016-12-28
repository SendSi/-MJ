//
//  RGUtilObject.m
//  读取MJ
//
//  Created by SunSi on 16/12/18.
//  Copyright © 2016年 SunSi. All rights reserved.
//
#define pathDoc  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]  stringByAppendingPathComponent:@"IDInput.plist"]
#define LampeManagerAllItemChangedNotification  @"LampeManagerAllItemChangedNotification"
#import "RGUtilObject.h"
#import "MJExtension.h"

@implementation RGUtilObject

/** 通过GCD方法实现单例  */
+ (instancetype)instance{
    static RGUtilObject* _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[RGUtilObject alloc] init];
    });
    return _instance;
}

+ (NSArray<RGUtilModel *> *)sort:(NSArray<RGUtilModel *> *)items{
    return [items sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES]]];
}


#pragma mark - 存档与读取
+ (BOOL)saveLEDInput:(NSArray<RGUtilModel *> *)inputModels{
    NSMutableArray* array = [NSObject mj_keyValuesArrayWithObjectArray:inputModels];
    return [array writeToFile:pathDoc atomically:YES];
}


+ (NSMutableArray<RGUtilModel *> *)getLEDInput{
    NSArray *arrNew=   [NSArray arrayWithContentsOfFile:pathDoc];
    return [RGUtilModel mj_objectArrayWithKeyValuesArray:arrNew];
}

- (void)save{
    [RGUtilObject saveLEDInput:self.allArrItems] ? NSLog(@"保存成功") : NSLog(@"保存失败");
}

- (void)addItems:(NSArray<RGUtilModel *> *)items{
    [items enumerateObjectsUsingBlock:^(RGUtilModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate* pre = [NSPredicate predicateWithFormat:@"number = %ld", obj.number];
        NSArray* array = [_allArrItems filteredArrayUsingPredicate:pre];
        [_allArrItems removeObjectsInArray:array];
        [_allArrItems addObject:obj];
    }];
    
    if (items.count) {
        [self postItemChangedNotification];
    }
}
/** *  移除部分 磁盘/内存 */
- (void)removeItems:(NSArray<RGUtilModel *> *)items{
    [_allArrItems removeObjectsInArray:items];
    if (items.count) {
        [self postItemChangedNotification];
    }
}
/** *  移除全部 磁盘/内存 */
- (void)removeAllItems{
    [_allArrItems removeAllObjects];    
    [self postItemChangedNotification];
}

- (void)postItemChangedNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:LampeManagerAllItemChangedNotification object:nil];
}


//MARK: 懒加载
- (NSMutableArray<RGUtilModel *> *)allArrItems{
    if (_allArrItems == nil) {
        _allArrItems = [NSMutableArray<RGUtilModel *> array];
     [_allArrItems addObjectsFromArray:[RGUtilObject getLEDInput]];
    }
    return _allArrItems;
}

- (NSMutableArray<RGUtilModel *> *)selectedItems{
    if (_selectedArrItems == nil) {
        _selectedArrItems = [NSMutableArray<RGUtilModel *> array];
    }
    return _selectedArrItems;
}
@end

@implementation RGUtilModel


@end
