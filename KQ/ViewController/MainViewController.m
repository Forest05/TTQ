//
//  MainViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "MainViewController.h"
#import "Coupon.h"
#import "CouponListCell.h"
#import "CouponDetailsViewController.h"
#import "TTQRootViewController.h"
#import "CityViewController.h"



@interface MainCell : ConfigCell{

    
}

@end

@implementation MainCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = kColorLightYellow;
        
        CGFloat w = 140;
        CGFloat h = 68;
        UIButton *b = [UIButton buttonWithFrame:CGRectMake(15, 10, w, h) title:nil bgImageName:@"main_kuaiquan.png" target:self action:@selector(buttonPressed:)];

        
        UIButton *b2 = [UIButton buttonWithFrame:CGRectMake(165, 10, w, h) title:nil bgImageName:@"main_haiwai.png" target:self action:@selector(buttonPressed:)];

        
        UIButton *b3 = [UIButton buttonWithFrame:CGRectMake(15, 78, w, h) title:nil bgImageName:@"main_huodong.png" target:self action:@selector(buttonPressed:)];
        
        UIButton *b4 = [UIButton buttonWithFrame:CGRectMake(165, 78, w, h) title:nil bgImageName:@"main_mingxing.png" target:self action:@selector(buttonPressed:)];
        [self addSubview:b];
        [self addSubview:b2];
        [self addSubview:b3];
        [self addSubview:b4];
        
        
    }
    
    return self;
}

- (IBAction)buttonPressed:(id)sender{
    L();
    
//    [UIAlertView showAlert:@"敬请期待" msg:@"更多功能即将上线" cancel:@"知道了"];
}

@end

@interface MainViewController (){

}

@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"快券";
    self.navigationController.tabBarItem.title = @"首页";
    
    self.config = [[TableConfiguration alloc] initWithResource:@"mainConfig"];

//    self.isLoadMore = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    
    NSString *city = _userController.city;
    if (ISEMPTY(city)) {
        city = @"选择城市";
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:city style:UIBarButtonItemStylePlain target:self action:@selector(cityPressed:)];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

#pragma mark - IBAction

- (IBAction)cityPressed:(id)sender{
    //    L();
    

    [self performSegueWithIdentifier:@"toCity" sender:nil];
}

#pragma mark - TableView



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 1) {
        return 20;
    }
    return 1.0f;
    

}

- (void)configCell:(CouponListCell *)cell atIndexPath:(NSIndexPath *)indexPath{

    
    if ([cell isKindOfClass:[CouponListCell class]]) {
        
          Coupon *project = _models[indexPath.row];
        
         [cell setValue:project];
   
    }
   

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    L();
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        
        Coupon *coupon = _models[indexPath.row];
        
        [self toCouponDetails:coupon];
        
    }
 

}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(ConfigCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
 

}




#pragma mark - Fcns;




/// 返回基本coupon，在load list的时候再载入购买人数的数据
- (void)loadModels{

    L();

    [_libraryManager startProgress:nil];
  
    [self.models removeAllObjects];
    
    [_networkClient queryNewestCouponsSkip:0 block:^(NSArray *couponDicts, NSError *error) {
        
         [_libraryManager dismissProgress:nil];
        
        [self addCouponsInModel:couponDicts];
        
    }];
  
    
}

- (void)refreshModels{
    [_models removeAllObjects];
    
    [self loadModels];
}

- (void)loadMore:(VoidBlock)finishedBlock{
    
    
    int count = [_models count];
    
    [_networkClient queryNewestCouponsSkip:count block:^(NSArray *couponDicts, NSError *error) {
        
        [self addCouponsInModel:couponDicts];
        
        finishedBlock();
    }];
}



- (void)toCouponDetails:(Coupon*)coupon{



    [self performSegueWithIdentifier:@"toCouponDetails" sender:coupon];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toCouponDetails"])
    {
        //        L();
        [segue.destinationViewController setValue:sender forKeyPath:@"coupon"];
        
    }
}

- (void)addCouponsInModel:(NSArray *)array {
    for (NSDictionary *dict in array) {
        //            NSLog(@"dict # %@",dict);
        
        Coupon *coupon = [Coupon couponWithDict:dict];
        [self.models addObject:coupon];
        
    }
    
    [self.tableView reloadData];
}

@end