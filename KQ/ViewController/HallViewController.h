//
//  HallViewController.h
//  DDX
//
//  Created by Forest on 14-10-5.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PaneViewController.h"

@interface HallViewController : PaneViewController<UITableViewDataSource,UITableViewDelegate>{

    UIBarButtonItem *_shareBB;
    NSArray *_arts;

}

@property (nonatomic, strong) NSArray *arts;






@end
