//
//  HallArtViewController.h
//  DDX
//
//  Created by Forest on 14-12-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArtDetailsViewController.h"

@interface HallArtViewController : ArtDetailsViewController<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_tableView;
    
}



@end
