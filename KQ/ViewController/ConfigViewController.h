//
//  MKViewController.h
//  Makers
//
//  Created by AppDevelopper on 14-5-21.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "TTQRootViewController.h"
#import "TableConfiguration.h"
#import "UserController.h"
#import "NetworkClient.h"
#import "LibraryManager.h"
#import "ConfigCell.h"


@interface ConfigViewController : UITableViewController{

    TableConfiguration *_config;
    TTQRootViewController *_root;
    UserController *_userController;
    NetworkClient *_networkClient;
    LibraryManager *_libraryManager;
       

}

@property (nonatomic, strong) TableConfiguration *config;
@property (nonatomic, strong) TTQRootViewController *root;
@property (nonatomic, strong) UserController *userController;


- (void)initConfigCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;
- (void)configCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;


@end
