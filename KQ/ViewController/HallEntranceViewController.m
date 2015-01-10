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
#import "TextManager.h"
#import "UserCenterViewController.h"
#import "NetworkClient.h"

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
    
    self.title = lang(@"1933当代艺术空间");
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *bb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_tabuser.png"] style:UIBarButtonItemStylePlain target:self action:@selector(userBBClicked:)];
    self.navigationItem.rightBarButtonItem = bb;
    
   UIBarButtonItem *backBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backBB;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    
    _introduceScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _w, 300)];
    _introduceScrollView.backgroundColor = kColorGreen;
    _introduceScrollView.pagingEnabled = YES;
    _introduceScrollView.delegate = self;
    
    
    
    for (int i = 0; i<self.hall.imageTexts.count; i++) {
      
        ImageText *it = self.hall.imageTexts[i];
        
        CGFloat x = _w*i;
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, _w, 200)];
        [imgV setImageWithURL:[NSURL URLWithString:it.imageUrl] placeholderImage:[UIImage imageNamed:@"t1.jpg"]];
       
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(x, 200-40, _w, 40)];
        l.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        l.textAlignment = NSTextAlignmentCenter;
        l.textColor = [UIColor whiteColor];
        
        
        
        UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(_w*i + 10, CGRectGetMaxY(imgV.frame), _w - 20, 90)];
//        tv.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];

        tv.backgroundColor = [UIColor clearColor];
        tv.textColor = [UIColor whiteColor];
        tv.font = [UIFont fontWithName:kFontName size:13];
        
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
    
    
    
    CGFloat y = CGRectGetMaxY(_introduceScrollView.frame) + (isSmallPhone?0:10);
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, y, _w, 25)];
    _pageControl.numberOfPages = self.hall.imageTexts.count;
    _pageControl.currentPageIndicatorTintColor = kColorGreen;
    _pageControl.pageIndicatorTintColor = kColorLightGreen;
    
    y = CGRectGetMaxY(_pageControl.frame) + (isSmallPhone?0:10);
    
    _toNavigationBtn = [UIButton buttonWithFrame:CGRectMake(30 , y, 100, 40) title:lang(@"智能导览") bgImageName:nil target:self action:@selector(buttonClicked:)];
    _toNavigationBtn.tag = 1;
    _toNavigationBtn.backgroundColor = kColorGreen;
    
    
    _toHallBtn = [UIButton buttonWithFrame:CGRectMake(200 , y, 100, 40) title:lang(@"作品简介") bgImageName:nil target:self action:@selector(buttonClicked:)];
    _toHallBtn.tag = 2;
    [_toHallBtn setBackgroundColor:kColorGreen];
    
    UILabel *hintL = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_toHallBtn.frame)+ (isSmallPhone?0:10), _w - 40, 45)];
    hintL.text = lang(@"在场馆内，可点击进入场馆，自动导览 不在场馆内，可点击作品介绍，精华抢先看哦~");
    hintL.numberOfLines = 0;
    hintL.font = [UIFont fontWithName:kFontName size:11];
    hintL.textAlignment = NSTextAlignmentCenter;
    hintL.textColor = [UIColor colorWithRed:148.0/255 green:148.0/255 blue:148.0/255 alpha:1];
    
    [_scrollView addSubview:_introduceScrollView];
    [_scrollView addSubview:_pageControl];
    [_scrollView addSubview:_toNavigationBtn];
    [_scrollView addSubview:_toHallBtn];
    [_scrollView addSubview:hintL];
    
    [_scrollView setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];

//    [_scrollView setContentSize:CGSizeMake(0, 500)];
    
    [self.view addSubview:_scrollView];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offset = scrollView.contentOffset.x;
    int page = offset/_w;
//    NSLog(@"page # %d",page);
    
    _pageControl.currentPage = page;
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

//        [[TTQRootViewController sharedInstance] toLogin];
        
    }

}

#pragma mark - Fcns
- (void)back{
//    [self.navigationController.view removeFromSuperview];
    
//    [[TTQRootViewController sharedInstance] toChooseLang];
    
}
- (void)toUser{
    L();
    
    _userCenterVC = [[UserCenterViewController alloc] init];
    
    [self.navigationController pushViewController:_userCenterVC animated:YES];
    
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
    
    _hallVC.arts = [[AppManager sharedInstance]arts];
    [self.navigationController pushViewController:_hallVC animated:YES];
    
}
@end
