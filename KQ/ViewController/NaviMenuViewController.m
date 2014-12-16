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
        height = 120;
    }
    else if (section == 2){
        height = 30;
    }
    return height;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    float height = 20;
    if (section == 3) { //老场房
        height = 1;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    int section = indexPath.section;
   
    
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor clearColor];
    
    float width = self.view.width-55;
    
    if (section == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
        nameL.text = @"sss";
        nameL.textColor = kColorWhite;
        nameL.textAlignment = NSTextAlignmentCenter;
        UILabel *welcomeL = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, width, 30)];
        welcomeL.text = @"Welcome";
        welcomeL.textColor = kColorWhite;
        welcomeL.textAlignment = NSTextAlignmentCenter;

    }
    else if(section == 1){ //avatar
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((width-90)/2, 0, 90, 90)];
        imgV.image = DefaultImg;
        imgV.layer.borderWidth = 2;
        imgV.layer.cornerRadius = 45;
        imgV.layer.borderColor = kColorWhite.CGColor;
        imgV.layer.masksToBounds = YES;
        
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, width, 30)];
        nameL.text = @"Lisa";
        nameL.textColor = kColorWhite;
        nameL.textAlignment = NSTextAlignmentCenter;
        
        [cell addSubview:imgV];
        [cell addSubview:nameL];
    }
    else if (section == 2){ //segment

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"中文",@"English"]];
     
        seg.frame = CGRectMake((width-160)/2, 0, 160, 26);

        if (isZH) {
            seg.selectedSegmentIndex = 0;
        }
        else{
            seg.selectedSegmentIndex = 1;
        }
        [seg addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];

        [cell addSubview:seg];
//        cell.accessoryView = seg;

    }
    else if (section == 3){ //1933老场房
       
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 11, 50, 28)];
        imgV.image = [UIImage imageNamed:@"1933logo.png"];
        
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
        nameL.text = @"1933老场房";
        nameL.textColor = kColorWhite;
        nameL.textAlignment = NSTextAlignmentCenter;
       
        [cell addSubview:imgV];
        [cell addSubview:nameL];
    }
    else if (section == 4){ //-1933现代艺术空间
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
        imgV.image = [UIImage imageNamed:@"左侧高亮BG.png"];
        
        
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
        nameL.text =  @"-1933现代艺术空间";
        nameL.textColor = kColorWhite;
        nameL.textAlignment = NSTextAlignmentCenter;
        
        [cell addSubview:imgV];
        [cell addSubview:nameL];
        
    }

    else {
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.text = @"aaa";
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    L();
}

#pragma mark - IBAction
- (IBAction)segmentedControlChanged:(UISegmentedControl*)sender{
    L();
    int index = sender.selectedSegmentIndex; // 0 中文， 1： 英语
    
    NSString *langStr = TTQLangZh;
    
    if (index == 0) {
        langStr = TTQLangZh;
    }
    else{
        langStr = TTQLangEn;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:langStr forKey:TTQLangKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [_tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NotifiChangeLang object:nil];
    
    
//    [[TTQRootViewController sharedInstance] didChangeLanguage];
}

@end
