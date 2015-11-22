//
//  ViewController.m
//  AGBottomDock
//
//  Created by Agenric on 15/11/22.
//  Copyright © 2015年 Agenric. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"

#import "Dock.h"

@interface ViewController ()
<
DockDelegate,
UINavigationControllerDelegate
>

@property (nonatomic, strong) Dock *dock;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self addDock];
    [self addChildViewControllers];
    [self dock:nil itemSelectedFrom:0 to:0];
    
    [self.dock setMarkForItemWithIndex:2 markType:DockItemMarkType_normal number:0];
    [self.dock setMarkForItemWithIndex:3 markType:DockItemMarkType_number number:3];
    
    self.view.layer.masksToBounds = YES;
}

#pragma mark - Private Methods
- (void)addChildViewControllers {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:FirstViewController.new];
    nav.delegate = self;
    [self addChildViewController:nav];
    
    UIViewController *vc = [[UIViewController alloc] init];
    nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.view.backgroundColor = [UIColor redColor];
    nav.delegate = self;
    [self addChildViewController:nav];
    
    vc = [[UIViewController alloc] init];
    nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.view.backgroundColor = [UIColor orangeColor];
    nav.delegate = self;
    [self addChildViewController:nav];
    
    vc = [[UIViewController alloc] init];
    nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.view.backgroundColor = [UIColor blueColor];
    nav.delegate = self;
    [self addChildViewController:nav];
    
    vc = [[UIViewController alloc] init];
    nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.view.backgroundColor = [UIColor grayColor];
    nav.delegate = self;
    [self addChildViewController:nav];
}

- (void)addDock {
    Dock *dock = [[Dock alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kDockHeight, SCREEN_WIDTH, kDockHeight)];
    
    [dock addItemWithIcon:@"tabbar_icon_news_normal" selectedIcon:@"tabbar_icon_news_highlight" title:@"新闻"];
    [dock addItemWithIcon:@"tabbar_icon_reader_normal" selectedIcon:@"tabbar_icon_reader_highlight" title:@"阅读"];
    [dock addItemWithIcon:@"tabbar_icon_media_normal" selectedIcon:@"tabbar_icon_media_highlight" title:@"视听"];
    [dock addItemWithIcon:@"tabbar_icon_found_normal" selectedIcon:@"tabbar_icon_found_highlight" title:@"发现"];
    [dock addItemWithIcon:@"tabbar_icon_me_normal" selectedIcon:@"tabbar_icon_me_highlight" title:@"我"];
    [dock setBackgroundColor:[UIColor whiteColor]];
    [dock setDelegate:self];
    dock.layer.masksToBounds = YES;
    [self.view addSubview:dock];
    self.dock = dock;
}

- (void)dock:(Dock *)dock itemSelectedFrom:(int)from to:(int)to {
    if (self.childViewControllers[from].view) {
        [self.childViewControllers[from].view removeFromSuperview];
    }
    [self.view insertSubview:self.childViewControllers[to].view belowSubview:self.dock];
}

#pragma mark - NavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *rootViewController = navigationController.childViewControllers[0];
    if (rootViewController != viewController) {
        // 拉长navigationController的高度
        CGRect navFrame = navigationController.view.frame;
        navFrame.size.height = [UIScreen mainScreen].bounds.size.height + kDockHeight;
        navigationController.view.frame = navFrame;
        
        // 将dock从self.view上移动到navigationController的rootViewController
        [self.dock removeFromSuperview];
        CGRect dockFrame = self.dock.frame;
        dockFrame.origin.y = navigationController.view.frame.size.height - kDockHeight * 2;
        if ([rootViewController.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)rootViewController.view;
            dockFrame.origin.y += scrollView.contentOffset.y;
        }
        self.dock.frame = dockFrame;
        [rootViewController.view addSubview:self.dock];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *rootViewController = navigationController.childViewControllers[0];
    if (rootViewController == viewController) {
        // 还原navigationController的高度
        CGRect navFrame = navigationController.view.frame;
        navFrame.size.height = [UIScreen mainScreen].bounds.size.height - kDockHeight;
        navigationController.view.frame = navFrame;
        
        // 将dock从navigationController的rootViewController移回到self.view
        [self.dock removeFromSuperview];
        CGRect dockFrame = self.dock.frame;
        dockFrame.origin.y = rootViewController.view.frame.size.height;
        self.dock.frame = dockFrame;
        [self.view addSubview:self.dock];
    }
}

@end
