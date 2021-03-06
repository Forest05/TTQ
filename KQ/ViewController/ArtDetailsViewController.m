//
//  ArtDetailsViewController.m
//  DDX
//
//  Created by Forest on 14-12-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ArtDetailsViewController.h"

@interface ArtDetailsViewController ()

@end

@implementation ArtDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *bgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgV.image = [UIImage imageNamed:@"bg.jpg"];
    bgV.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bgV];
    UIView *maskV = [[UIView alloc] initWithFrame:self.view.bounds];
    maskV.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:maskV];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    _descFont = [UIFont fontWithName:kFontName size:12];
    _manager = [AppManager sharedInstance];
    _libraryMng = [LibraryManager sharedInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
