//
//  NavigationArtViewController.m
//  DDX
//
//  Created by Forest on 14-12-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UIImageView+WebCache.h"

#import "NavigationArtViewController.h"

@interface NavigationArtViewController ()

@end

@implementation NavigationArtViewController


- (void)setArt:(Art *)art{
    _art = art;
    
    [_bannerV setImageWithURL:[NSURL URLWithString:art.imgUrl]];
    
    if (isZH) {
        _titleL.text = _art.name;
        _descL.text = _art.desc;
        
    }
    else{
        _titleL.text = _art.name_en;
        _descL.text = _art.description_en;
    }
    CGSize constraint = CGSizeMake(_titleL.width - 20, 10000);
    NSString *text = _descL.text;
    UIFont *font = _descFont;
    CGRect textRect = [text boundingRectWithSize:constraint options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil];
    
    _descL.frame = CGRectMake(10, 50, textRect.size.width, textRect.size.height);
    _scrollV.contentSize = CGSizeMake(0, textRect.size.height + 230);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  

    
    _bannerV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 240)];
    
    
    float width = 80;
    float y = CGRectGetMaxY(_bannerV.frame);
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, 80, self.view.height - y) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(width, y, self.view.width - width, self.view.height - y)];
    _scrollV = scrollView;
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, scrollView.width, 50)];
    _titleL.textColor = [UIColor whiteColor];
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.numberOfLines = 0;
    
    _descL = [[UILabel alloc] initWithFrame:CGRectZero];
    _descL.numberOfLines = 0;
    _descL.textColor = [UIColor whiteColor];
    _descL.font = _descFont;
    
    [scrollView addSubview:_titleL];
    [scrollView addSubview:_descL];
    
    
    [self.view addSubview:_bannerV];
    [self.view addSubview:_tableView];
    [self.view addSubview:scrollView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
}


#pragma mark - Table view data source





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier1 = @"Cell1";
    int row = indexPath.row;
    
    //!!!: 可以根据Setting的不同进行不同的工作
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
        
   
        
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textColor = [UIColor whiteColor];
        
    if (row == 0) {
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 44)];
        label.text = lang(@"作品简介");
        label.textColor = [UIColor whiteColor];

        [cell addSubview:label];
        
    }
    else if(row == 1){ // like
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
        imgV.image = [UIImage imageNamed:@"icon_like2.png"];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 40, 44)];
        label.text = getConfig(@"likeNum");
    
        label.textColor = [UIColor whiteColor];
        
        [cell addSubview:imgV];
        [cell addSubview:label];
    }
    else if(row == 2){ // share
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
        imgV.image = [UIImage imageNamed:@"icon_share2.png"];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 40, 44)];
        label.text = getConfig(@"shareNum");
        label.textColor = [UIColor whiteColor];
        
        [cell addSubview:imgV];
        [cell addSubview:label];

    }
    
    if (row<3) {
        UIImageView *lineV = [[UIImageView alloc] initWithFrame:CGRectMake(0, cell.height -1, cell.width, 1)];
        lineV.image = [UIImage imageNamed:@"line.png"];
        [cell addSubview:lineV];

    }
    
//    cell.textLabel.text = @"aaa";
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    L();
    
    NSString *key;
    if (indexPath.row == 1) {
        key = @"likeNum";
    
        int num = [getConfig(key) intValue];
        num++;
        setConfig([NSString stringWithInt:num], key);
        [[NSUserDefaults standardUserDefaults] synchronize];

        [tableView reloadData];
    }
    else if(indexPath.row == 2){
        
        [self shareArt:self.art];
        
        key = @"shareNum";
        
        int num = [getConfig(key) intValue];
        num++;
        setConfig([NSString stringWithInt:num], key);
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView reloadData];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - Fcns
- (void)shareArt:(Art*)art{
    
    [_manager shareArt:art];
    
}
@end
