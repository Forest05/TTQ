//
//  NaviMenuViewController.m
//  DDX
//
//  Created by Forest on 14-12-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "NaviMenuViewController.h"

@interface NaviMenuViewController ()

@end

@implementation NaviMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:_tableView];
    
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"naviMenu_BG.jpg"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    L();
    NSLog(@"NaviMenu # %@",self.view);
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int section = indexPath.section;
    CGFloat height = 50;
   
    if (section == 0) {
        height = 60;
    }
    else if (section == 1){
        height = 90;
    }
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    int section = indexPath.section;
   
    
    //!!!: 可以根据Setting的不同进行不同的工作
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor clearColor];
    
    float width = self.view.width;
    
    if (section == 0) {
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
        nameL.text = @"sss";
        UILabel *welcomeL = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, width, 30)];
        welcomeL.text = @"Welcome";
        [cell addSubview:nameL];
        [cell addSubview:welcomeL];
    }
    else if(section == 1){
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((width-90)/2, 0, 90, 90)];
        imgV.image = DefaultImg;
        [cell addSubview:imgV];
    }
    else {
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.text = @"aaa";
    }
    return cell;
    
}

@end
