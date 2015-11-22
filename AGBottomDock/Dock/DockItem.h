//
//  DockItem.h
//  NetEaseNews
//
//  Created by Agenric on 15/11/3.
//  Copyright © 2015年 Agenric. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    DockItemMarkType_normal = 1,
    DockItemMarkType_number,
} DockItemMarkType;

@interface DockItem : UIButton
- (void)setMarkWithMarkType:(DockItemMarkType)markType number:(NSInteger)number;
@end
