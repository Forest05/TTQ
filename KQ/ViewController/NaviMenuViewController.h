//
//  NaviMenuViewController.h
//  DDX
//
//  Created by Forest on 14-12-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NaviMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    UITableView *_tableView;
}

@property (nonatomic, strong) UITableView *tableView;

- (void)toWebsite;
@end
