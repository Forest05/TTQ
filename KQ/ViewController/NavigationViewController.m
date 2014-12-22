//
//  NavigationViewController.m
//  DDX
//
//  Created by Forest on 14-10-5.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "NavigationViewController.h"
#import "BeaconManager.h"
#import "TextManager.h"
#import "TTQBeacon.h"
#import "NavigationArtViewController.h"

@interface NavigationViewController (){

}


@end

@implementation NavigationViewController

- (void)setSelectedArt:(Art *)selectedArt{

    _selectedArt = selectedArt;

    NSString *name = isZH?selectedArt.name:selectedArt.name_en;

    _tf.text = [NSString stringWithFormat:@"%@", name];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
    UIBarButtonItem *cameraBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_camera.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pushCamera)];
    self.navigationItem.rightBarButtonItem = cameraBB;

  
    [self registerNotification];
    
    
    _tableKeys = @[lang(@"开启"),lang(@"找到标识"),lang(@"完成, enjoy :)")];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, self.view.width, 300) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.scrollEnabled = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    _label.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    _label.textColor = [UIColor blackColor];
    _label.font = [UIFont fontWithName:kFontName size:10];
    _label.numberOfLines = 0;
    _label.alpha = 0;
    [self.view addSubview:_label];
    
    if(isToolVersion()){
        _label.alpha = 1;
    }


}

- (void)viewWillAppear:(BOOL)animated{

//    L();
    [super viewWillAppear:animated];
    
    [[BeaconManager sharedInstance] startRanging];
}

- (void)viewDidAppear:(BOOL)animated{

//    L();
    [super viewDidAppear:animated];
    

      self.naviMenu.title = _menuArray[0];
}

- (void)viewDidDisappear:(BOOL)animated{

//    L();
    [super viewDidDisappear:animated];
    
    [[BeaconManager sharedInstance] stopRanging];
  
    [self closeArt];
    
    [_closeBtn removeFromSuperview];
}


- (void)registerNotification {
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kOpenBeaconNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note){
        NSLog(@"open Beacon # %@",note.object);
        //需要判别是否是art的beacon还是展厅的beacon
        
        TTQBeacon *beacon = note.object;
        
        
        Art *art = [_appManager artWithTTQBeacon:beacon];
        
        if (!art) {
//            [UIAlertView showAlert:@"open beacon empty" msg:[NSString stringWithInt:beacon.minorValue]];
            return ;
        }
        
        //如果没有打开的展品，打开
        if (!self.showedArt) {
            [self showArt:art];
        }
        else{
            NSLog(@"showedArt is already opened # %@",self.showedArt);
        }
//        _label.text = [NSString stringWithFormat:@"Open Beacon # %d",beacon.minorValue];
        

    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kCloseBeaconNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note){
        NSLog(@"close Beacon # %@",note.object);
        
        TTQBeacon *beacon = note.object;
        Art *art = [_appManager artWithTTQBeacon:beacon];
        
        // 如果离开当前打开的展品，关闭

        if (art) {
            [self closeArt];
        }
    }];

    [[NSNotificationCenter defaultCenter] addObserverForName:kListBeaconsNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note) {
       
        NSArray *beacons = note.object;
        NSMutableString *str = [NSMutableString stringWithString:@"Beacon List\n"];
        for (CLBeacon *beacon in beacons) {
            [str appendFormat:@"minor # %d, distance: %f\n",[beacon.minor intValue],[beacon accuracy]];
        }
        
        _label.text = str;
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *CellIdentifier1 = @"Cell1";
    int row = indexPath.row;
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d. %@",indexPath.row+1, _tableKeys[indexPath.row]];
    
    cell.textLabel.textColor = kColorGray;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (row == 0) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
        imgV.image = [UIImage imageNamed:@"bluetooth.png"];
        cell.accessoryView = imgV;
        
        UIImageView *lineV = [[UIImageView alloc] initWithFrame:CGRectMake(0, cell.height -1, cell.width, 1)];
        lineV.image = [UIImage imageNamed:@"line.png"];
        [cell addSubview:lineV];
    }
    else if(row == 1){
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
        imgV.image = [UIImage imageNamed:@"logo.png"];
        cell.accessoryView = imgV;
        
        UIImageView *lineV = [[UIImageView alloc] initWithFrame:CGRectMake(0, cell.height -1, cell.width, 1)];
        lineV.image = [UIImage imageNamed:@"line.png"];
        [cell addSubview:lineV];
    }
    else{
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    L();
    Art *art = [[AppManager sharedInstance] arts][0];
    [self showArt:art];
}




#pragma mark - Fcns



- (void)showArt:(Art*)art{

    if (!_artVC) {
        _artVC = [NavigationArtViewController new];
        
        _artVC.view.alpha = 1;
    }
    
    _artVC.art = art;
    
    self.showedArt = art;
    
    if (_label.superview) {
        [self.view insertSubview:_artVC.view belowSubview:_label];
    }
    else{
        [self.view addSubview:_artVC.view];
    }
    
    [self.view addSubview:_closeBtn];
    [[self.view layer] addAnimation:_animation forKey:@"animation"];
}

- (void)closeArt{
 
    [super closeArt];
    
    self.showedArt = nil;
 
    
}



@end
