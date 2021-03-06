//
//  NavigationViewController.h
//  DDX
//
//  Created by Forest on 14-10-5.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PaneViewController.h"

@interface NavigationViewController : PaneViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{


    
    UIScrollView *_scrollView;
    UITextField *_tf;
    UIBarButtonItem *_cameraBB;
    
    UILabel *_label;

    NSArray *_tableKeys;
 
    
    
}

@property (nonatomic, assign) BOOL isCameraOn;
@property (nonatomic, assign) BOOL isArtViewOn;
@property (nonatomic, strong) Art *selectedArt;
@property (nonatomic, strong) Art *showedArt;




@end
