//
//  Dock.m
//  NetEaseNews
//
//  Created by Agenric on 15/11/3.
//  Copyright © 2015年 Agenric. All rights reserved.
//

#import "Dock.h"

@interface Dock ()
{
    DockItem *_selectedItem;
}
@property (nonatomic, assign) int selectedIndex;
@end

@implementation Dock

-(void)layoutSubviews {
    [super layoutSubviews];
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 0.5)];
    [topLine setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:topLine];
}

- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon title:(NSString *)title {

    DockItem *dockItem = [[DockItem alloc]init];

    [dockItem setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [dockItem setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateSelected];
    [dockItem setTitle:title forState:UIControlStateNormal];
    [dockItem setTitleColor:[UIColor colorWithRed:137/255.0f green:137/255.0f blue:137/255.0f alpha:1] forState:UIControlStateNormal];
    [dockItem setTitleColor:[UIColor colorWithRed:223/255.0f green:41/255.0f blue:43/255.0f alpha:1] forState:UIControlStateSelected];
    [dockItem addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:dockItem];

    int count = (int)self.subviews.count;
    // Dock默认显示第一项
    if (count == 1) {
        [self itemClick:dockItem];
    }
    CGFloat width = self.frame.size.width / count;
    CGFloat height = self.frame.size.height;
    for (int i = 0; i < count; i++) {
        DockItem *item = self.subviews[i];
        item.tag = i;
        item.frame = CGRectMake(width * i, 0, width, height);
    }
}

- (void)itemClick:(DockItem *)item {
    [item setMarkWithMarkType:0 number:0];
    // 0. 通知代理
    if ([_delegate respondsToSelector:@selector(dock:itemSelectedFrom:to:)]) {
        [_delegate dock:self itemSelectedFrom:(int)_selectedItem.tag to:(int)item.tag];
    }
    // 1. 取消当前选中的item
    _selectedItem.selected = NO;
    // 2. 选中点击的item
    item.selected = YES;
    // 3. 保存已选中的item
    _selectedItem = item;
    // 4. 设置当前所选的item的index
    _selectedIndex = (int)_selectedItem.tag;
}

- (void)setMarkForItemWithIndex:(NSInteger)index markType:(DockItemMarkType)markType number:(NSInteger)number {
    DockItem *item = self.subviews[index];
    [item setMarkWithMarkType:markType number:number];
}
@end
