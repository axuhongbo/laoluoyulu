//
//  LogInViewController.h
//  LaoYueWeiBo
//
//  Created by 老岳 on 14-1-4.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebControlView.h"

@interface WeiBoViewController : UIViewController<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView *weiboWebView;
@property (nonatomic, strong) WebControlView *webControlView;

@end
