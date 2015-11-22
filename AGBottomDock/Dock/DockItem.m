//
//  DockItem.m
//  NetEaseNews
//
//  Created by Agenric on 15/11/3.
//  Copyright © 2015年 Agenric. All rights reserved.
//

#import "DockItem.h"

#define kImageRatio 0.7
#define kNormalMarkWH 6
#define kNumberMarkWH 18

@interface DockItem ()
@property (nonatomic, strong) UILabel *markLabel;
@end

@implementation DockItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:self.markLabel];
    }
    return self;
    
}

- (void)layoutSubviews {
    CGRect markFrame = self.markLabel.frame;
    CGFloat x = markFrame.size.height == kNumberMarkWH ? self.frame.size.width / 2 + kNormalMarkWH / 2 : self.frame.size.width / 2 + kNumberMarkWH / 2 - 2;
    CGFloat y = markFrame.size.height == kNumberMarkWH ? 1 : kNormalMarkWH / 2 + 2;
    markFrame.origin = CGPointMake(x, y);
    self.markLabel.frame = markFrame;
    [super layoutSubviews];
}

#pragma mark 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageWidth = self.frame.size.width;
    CGFloat imageHeight = self.frame.size.height * kImageRatio;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}
#pragma mark 调整内部UILable的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleWidth = self.frame.size.width;
    CGFloat titleHeight = self.frame.size.height * (1 - kImageRatio);
    CGFloat titleX = 0;
    CGFloat titleY = self.imageView.frame.size.height - 3;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}
#pragma mark 调设置按钮右上角标示
- (void)setMarkWithMarkType:(DockItemMarkType)markType number:(NSInteger)number {
    if (markType == 0) {
        self.markLabel.hidden = YES;
        return;
    }
    self.markLabel.hidden = NO;
    CGRect markFrame = self.markLabel.frame;
    if (markType == DockItemMarkType_normal) {
        markFrame.size = CGSizeMake(kNormalMarkWH, kNormalMarkWH);
        self.markLabel.layer.cornerRadius = kNormalMarkWH / 2;
    } else {
        markFrame.size = CGSizeMake(kNumberMarkWH, kNumberMarkWH);
        self.markLabel.layer.cornerRadius = kNumberMarkWH / 2;
        self.markLabel.text = [NSString stringWithFormat:@"%@", @(number)];
    }
    _markLabel.frame = markFrame;
}

// 重写按钮的setHighlighted: 方法，用以取消按钮处以高亮状态时的显示状态
- (void)setHighlighted:(BOOL)highlighted{}

- (UILabel *)markLabel {
    if (_markLabel == nil) {
        _markLabel = [[UILabel alloc] init];
        _markLabel.backgroundColor = [UIColor redColor];
        _markLabel.textAlignment = NSTextAlignmentCenter;
        _markLabel.textColor = [UIColor whiteColor];
        _markLabel.font = [UIFont systemFontOfSize:13];
        _markLabel.layer.masksToBounds = YES;
        _markLabel.hidden = YES;
    }
    return _markLabel;
}
@end