//
//  Dock.h
//  NetEaseNews
//
//  Created by Agenric on 15/11/3.
//  Copyright © 2015年 Agenric. All rights reserved.
//  自定义底部Tabbar

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define kDockHeight  48.0f

#import <UIKit/UIKit.h>
#import "DockItem.h"

@class Dock;
@protocol DockDelegate <NSObject>
@optional 
- (void)dock:(Dock *)dock itemSelectedFrom:(int)from to:(int)to;
@end

@interface Dock : UIView
/*!
 * @brief  添加一个选项卡
 *
 * @param icon         普通状态按钮图片
 * @param selectedIcon 选中状态按钮图片
 * @param title        按钮文字
 */
- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon title:(NSString *)title;

/*!
 * @brief  设置某一个选项卡新消息标示
 *
 * @param index    选项卡索引
 * @param markType 标示类型
 * @param number   新消息数目
 */
- (void)setMarkForItemWithIndex:(NSInteger)index markType:(DockItemMarkType)markType number:(NSInteger)number;
@property (nonatomic, weak) id<DockDelegate> delegate;

@end