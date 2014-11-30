//
//  LYAppDelegate.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-7.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "LYAppDelegate.h"
#import "LeftMenuViewController.h"
#import "CenterViewController.h"
#import "PlayerViewController.h"
#import "MMExampleDrawerVisualStateManager.h"

@implementation LYAppDelegate

/** 初始化抽屉结构 */
- (void)initDrawerViewController
{
    self.leftNavCol = [[UINavigationController alloc] initWithRootViewController:[LeftMenuViewController new]];
    MenuModel *menuMol = [[[LYDataManager instance] selectMenuList] objectAtIndex:0];
    self.centerNavCol = [[UINavigationController alloc] initWithRootViewController:[[CenterViewController alloc] initWithMenu:menuMol]];
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:self.centerNavCol
                                                            leftDrawerViewController:self.leftNavCol];
    [self.drawerController setMaximumLeftDrawerWidth:LeftMenuWidth];
    [self.drawerController setMaximumRightDrawerWidth:RightMenuWidth];
    [self.drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible)
    {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
        if(block){
            block(drawerController, drawerSide, percentVisible);
        }
    }];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    self.drawerController.showsShadow = NO;
    //抽屉特殊效果
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeParallax];
    self.window.rootViewController = self.drawerController;
}

- (void)showLeftSideView
{
    [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)showRightSideView
{
    [self.drawerController openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

/** 初始化播放器界面 */
- (void)initPlayerView
{
    if (!self.playerView) {
        self.playerView = [[PlayerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.playerView.hidden = YES;
        [self.window addSubview:self.playerView];
    }
}

/** 初始化播放定时器 */
- (void)startPlayerTimer
{
    if ([self.instanceTimer isValid]) {
        [self.instanceTimer invalidate];
        self.instanceTimer = nil;
    }
    self.instanceTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(handlePlayerTimerEvent:) userInfo:nil repeats:YES];
}

#pragma mark - 播放定时器事件
- (void)handlePlayerTimerEvent:(NSTimer *)timer
{
    if (self.audioPlayer.isPlaying)  //正在播放
    {
        self.playerView.currentTimeLabel.text = [LYTimeUtils timeFormatted:self.audioPlayer.currentTime];
        self.playerView.totalTimeLabel.text = [LYTimeUtils timeFormatted:self.audioPlayer.duration];
        self.playerView.playSlider.value = self.audioPlayer.currentTime/self.audioPlayer.duration*1.0;
        
    }
    else  //未播放
    {
        
    }
}

#pragma mark - toastView
- (void)showToastView:(NSString *)text
{
//    if (!toastView)
//    {
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17]
                       constrainedToSize:CGSizeMake(200, MAXFLOAT)
                           lineBreakMode:NSLineBreakByWordWrapping];
        LYToastView *toastView = [[LYToastView alloc] initWithFrame:CGRectMake((ScreenWidth-size.width)/2, ScreenHeight-100, size.width+26, size.height+16)];
//    }
    toastView.textLabel.text = text;
    toastView.hidden = NO;
    [APP_DELEGATE.window addSubview:toastView];
    
    //1秒后消失
    [self hideToastViewAfter:1 toastView:toastView];
}

- (void)hideToastViewAfter:(NSTimeInterval)duration toastView:(LYToastView *)view
{
    __block LYToastView *toastView = view;
    [UIView animateWithDuration:0.6
                          delay:duration
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         toastView.alpha = 0;
     } completion:^(BOOL finished)
     {
         toastView.hidden = YES;
         [toastView removeFromSuperview];
         toastView = nil;
     }];
}

#pragma mark - AVAudioPlayer Delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
}

/** 配置播放器，允许后台播放语音 */
- (void)configAudio
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
}

///** 遍历数据库中的语音文件列表 */
//- (void)initAllVoiceDataFromDataBase
//{
//    self.voiceMutableArray = [NSMutableArray array];
//    self.menuLists = [[LYDataManager instance] selectMenuList];
//    self.centerNavContainer = [NSMutableArray array];
//    
//    for (MenuModel *menuModel in self.menuLists)
//    {
//        NSMutableArray *array = [[LYDataManager instance] selectVoiceListWithMenuID:menuModel.ID];
//        [self.voiceMutableArray addObject:array];
//        
//        CenterViewController *centerVC = [[CenterViewController alloc] initWithMenu:menuModel voiceLists:array];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:centerVC];
//        [self.centerNavContainer addObject:nav];
//    }
//}

#pragma mark - AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self initDrawerViewController];
    
    [self initPlayerView];
    
    [self startPlayerTimer];
    
    [self configAudio];
    
    return YES;
}

@end


