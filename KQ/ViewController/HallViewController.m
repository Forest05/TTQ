//
//  HallViewController.m
//  DDX
//
//  Created by Forest on 14-10-5.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "HallViewController.h"

#import "ArtListView.h"
#import "TextManager.h"

@interface HallViewController ()

@end

@implementation HallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = lang(@"作品库");
    
    _appManager = [AppManager sharedInstance];
    
    self.arts = [_appManager arts];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIBarButtonItem *backBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    
    self.navigationItem.leftBarButtonItem = backBB;
    
    self.view.backgroundColor = [UIColor blueColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    
    [self.view addSubview:_tableView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 50;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *l = [[UILabel alloc] initWithFrame:view.bounds];
    l.text = lang(@"部分展示，现场观看体验更佳");
    l.textAlignment = NSTextAlignmentCenter;
    l.textColor = kColorGreen;
    l.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:l];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arts.count/2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier1 = @"Cell1";
    int row = indexPath.row;
    
    //!!!: 可以根据Setting的不同进行不同的工作
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        ArtListView *listV1 = [[ArtListView alloc] initWithFrame:CGRectMake(6, 0, 150, 150)];
        [listV1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        listV1.tag = 1;
        
        ArtListView *listV2 = [[ArtListView alloc] initWithFrame:CGRectMake(162, 0, 150, 150)];
        [listV2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        listV2.tag = 2;
        
        [cell.contentView addSubview:listV1];
        [cell.contentView addSubview:listV2];
        
    }
    
    ArtListView *v1 = (ArtListView*)[cell.contentView viewWithTag:1];
    v1.art = self.arts[2*row];
    
    ArtListView *v2 = (ArtListView*)[cell.contentView viewWithTag:2];
    v2.art = self.arts[2*row + 1];
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

#pragma mark - IBAction
- (IBAction)handleTap:(UITapGestureRecognizer*)sender{
    L();
    ArtListView *v = (ArtListView *)sender.view;
    Art *art = v.art;
    [self showArt:art];
}


#pragma mark - Fcns

- (void)showArt:(Art*)art{
    
    if (!_artView) {
        _artView = [[ArtNavView alloc] initWithFrame:CGRectMake(10, 10, _w - 20, 400)];
        
    }
    
    _artView.art = art;
    
    
    __weak id vc = self;
    _artView.closeBlock = ^{
        
        [vc closeArt];
        
    };
    
    [self.view addSubview:_artView];
}

- (void)closeArt{
    
    [_artView removeFromSuperview];
    
}


@end
