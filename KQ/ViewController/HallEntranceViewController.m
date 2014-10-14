//
//  HallEntranceViewController.m
//  DDX
//
//  Created by Forest on 14-10-5.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "HallEntranceViewController.h"
#import "UIImageView+WebCache.h"
#import "UserController.h"
#import "TTQRootViewController.h"
#import "NavigationViewController.h"
#import "HallViewController.h"



@interface HallEntranceViewController ()

@end

@implementation HallEntranceViewController

- (void)setHall:(Hall *)hall{
    _hall = hall;
    
    
}
#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _manager = [AppManager sharedInstance];
    
    self.hall = _manager.hall;
    
//     NSLog(@"hall # %@",_manager.hall);
    
    self.title = @"1933画廊";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *bb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_tabuser.png"] style:UIBarButtonItemStylePlain target:self action:@selector(userBBClicked:)];
    self.navigationItem.rightBarButtonItem = bb;
    
   UIBarButtonItem *backBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backBB;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    
    
    
    _introduceScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _w, 400)];
    _introduceScrollView.backgroundColor = [UIColor redColor];
    _introduceScrollView.pagingEnabled = YES;
    
    
    for (int i = 0; i<self.hall.imageTexts.count; i++) {
      
        ImageText *it = self.hall.imageTexts[i];
        
        CGFloat x = _w*i;
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, _w, 200)];
        [imgV setImageWithURL:[NSURL URLWithString:it.imageUrl] placeholderImage:[UIImage imageNamed:@"t1.jpg"]];
       
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(x, 200-40, _w, 40)];
        l.backgroundColor = [UIColor clearColor];
        l.textAlignment = NSTextAlignmentCenter;
        l.textColor = [UIColor whiteColor];
        
        
        
        UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(_w*i, CGRectGetMaxY(imgV.frame), _w, 200)];
        tv.backgroundColor = kColorGreen;
        tv.textColor = [UIColor whiteColor];
        
        if ([kLang isEqualToString:TTQLangZh]) {
            tv.text = it.text;
            l.text = it.title;
        }
        else{
            tv.text = it.text_en;
            l.text = it.title_en;
        }
        
        [_introduceScrollView addSubview:imgV];
        [_introduceScrollView addSubview:tv];
        [_introduceScrollView addSubview:l];
        _introduceScrollView.contentSize = CGSizeMake(CGRectGetMaxX(imgV.frame), 0);
    }
    
    _toNavigationBtn = [UIButton buttonWithFrame:CGRectMake(30 , 420, 100, 40) title:@"智能导览" bgImageName:nil target:self action:@selector(buttonClicked:)];
    _toNavigationBtn.tag = 1;
    _toNavigationBtn.backgroundColor = kColorGreen;
    
    _toHallBtn = [UIButton buttonWithFrame:CGRectMake(200 , 420, 100, 40) title:@"作品简介" bgImageName:nil target:self action:@selector(buttonClicked:)];
    _toHallBtn.tag = 2;
    [_toHallBtn setBackgroundColor:kColorGreen];
    
    
    
    [_scrollView addSubview:_introduceScrollView];
    [_scrollView addSubview:_toNavigationBtn];
    [_scrollView addSubview:_toHallBtn];
    
    [_scrollView setContentSize:CGSizeMake(0, 500)];
    
    [self.view addSubview:_scrollView];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)buttonClicked:(id)sender{

    int tag = [sender tag];
    if (tag == 1) {
        [self toNavigation];
    }
    else if(tag == 2){
        [self toHall];
    }
}

- (IBAction)userBBClicked:(id)sender{
    
    if ([[UserController sharedInstance] isLogin]) {
        [self toUser];
    }
    else{

        [[TTQRootViewController sharedInstance] toLogin];
        
    }

}

#pragma mark - Fcns
- (void)back{
    [self.navigationController.view removeFromSuperview];
}
- (void)toUser{
    L();
    
  }
- (void)toNavigation{
    L();
    
    if (!_navigationVC) {
        _navigationVC = [[NavigationViewController alloc] init];
    }
    
    [self.navigationController pushViewController:_navigationVC animated:YES];
}
- (void)toHall{
    L();
    
    if (!_hallVC) {
        _hallVC = [[HallViewController alloc] init];
    }
    
    [self.navigationController pushViewController:_hallVC animated:YES];
    
}
@end
