//
//  HallArtViewController.m
//  DDX
//
//  Created by Forest on 14-12-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "HallArtViewController.h"

#import "UIImageView+WebCache.h"

@interface HallArtViewController ()

@end

@implementation HallArtViewController

- (void)setArt:(Art *)art{

    _art = art;
    [_artImgV setImageWithURL:[NSURL URLWithString:art.imgUrl] placeholderImage:nil];
    
    if (isZH) {
        _artTitleL.text = _art.name;
        _artDescTV.text = art.desc;
//        _authorV.author = art.author;
//        _authorDescTV.text = art.author.desc;

        
    }
    else{
        
        _artTitleL.text = _art.name_en;
        _artDescTV.text = art.description_en;
//        _authorV.author = art.author;
//        _authorDescTV.text = art.author.description_en;
        
    }


    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    
//    float width = self.view.width;
//    
//    _artImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 200)];
//
//    _artTitleL = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_artImgV.frame), width, 50)];
//    
//    _artDescTV = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_artTitleL.frame), width, 100)];
//    
//    
//    [scrollV addSubview:_artImgV];
//    [scrollV addSubview:_artTitleL];
//
//    
//    [self.view addSubview:scrollV];

    self.edgesForExtendedLayout = UIRectEdgeNone;

    
    UIImageView *bgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgV.image = [UIImage imageNamed:@"bg.jpg"];
    bgV.contentMode = UIViewContentModeScaleAspectFill;
//    [self.view addSubview:bgV];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}


#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 9;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int section = indexPath.section;
    CGFloat height = 50;
    switch (section) {
        case 0:
            height = 200;
            break;
            
        default:
            break;
    }
    
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier1 = @"Cell1";
    
    int section = indexPath.section;
    int row = indexPath.row;
    
    //!!!: 可以根据Setting的不同进行不同的工作
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = [UIColor clearColor];
   
    }
    
    float width = self.view.width;
    
    if (section == 0) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 200)];
        [imgV  setImageWithURL:[NSURL URLWithString:_art.imgUrl] placeholderImage:nil];
        [cell addSubview:imgV];
    
    }
    else if(section == 1){
        cell.textLabel.text = _art.name;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    else{
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.text = @"aaa";
    }
    return cell;
    
}
@end
