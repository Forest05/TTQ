//
//  HallViewController.h
//  DDX
//
//  Created by Forest on 14-10-5.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HallViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{

    UITableView *_tableView;
    
}

@property (nonatomic, strong) NSArray *arts;

@end
