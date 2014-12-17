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
#import "HallArtViewController.h"

@interface HallViewController (){

   

}

@end

@implementation HallViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *cameraBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_share2.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pushCamera)];
    self.navigationItem.rightBarButtonItem = cameraBB;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    _arts = [_appManager arts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.naviMenu.title = _menuArray[1];
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 20;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arts.count/2 + self.arts.count%2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
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
        
        cell.backgroundColor = [UIColor clearColor];
        
        ArtListView *listV1 = [[ArtListView alloc] initWithFrame:CGRectMake(10, 0, 145, 145)];
        [listV1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        listV1.tag = 1;
        
        ArtListView *listV2 = [[ArtListView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(listV1.frame) + 10, 0, 145, 145)];
        [listV2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        listV2.tag = 2;
        
        [cell.contentView addSubview:listV1];
        [cell.contentView addSubview:listV2];
        
    }
    
    ArtListView *v1 = (ArtListView*)[cell.contentView viewWithTag:1];
    
    v1.art = self.arts[2*row];
//
    
     ArtListView *v2 = (ArtListView*)[cell.contentView viewWithTag:2];
    if (2 * row + 1 <[self.arts count]) {
       
        v2.art = self.arts[2*row + 1 ];
        v2.hidden = NO;
    }
    else{
        v2.hidden = YES;
    }
    
    
    
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

    if (!_artVC) {
        _artVC = [HallArtViewController new];
        _artVC.view.alpha = 1;
    }
    
    _artVC.art = art;
    
    [self.view addSubview:_artVC.view];
    [self.view addSubview:_closeBtn];
    
    [[self.view layer] addAnimation:_animation forKey:@"animation"];
    
}





@end
