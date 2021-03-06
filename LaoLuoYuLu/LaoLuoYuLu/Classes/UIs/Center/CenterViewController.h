//
//  CenterViewController.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-7.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "BaseViewController.h"
#import "PlayerViewController.h"
#import "MenuModel.h"
#import "VoiceModel.h"

@interface CenterViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *voiceTableView;
@property (nonatomic, strong) NSMutableArray *voiceListArr;

@property (nonatomic, strong) PlayerViewController *playerView;

- (instancetype)initWithMenu:(MenuModel *)menu;

@end



