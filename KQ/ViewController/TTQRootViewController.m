//
//  KQRootViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "TTQRootViewController.h"
#import "SearchViewController.h"

#import "NetworkClient.h"
#import "KQLoginViewController.h"
#import "UserCenterViewController.h"
#import "MainViewController.h"
#import "BeaconManager.h"
#import "ChooseLangViewController.h"
#import "HallEntranceViewController.h"
#import "ImageText.h"
#import "AppManager.h"
#import "KQLoginViewController.h"
#import "TextManager.h"

@interface TTQRootViewController (){
    
}
- (void)deleteFirstTimeLoadedInformation;

@end

@implementation TTQRootViewController


+ (id)sharedInstance{
    
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{

       /**
        还是用了storyboard作为入口，但是不放任何
        */
        sharedInstance = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        
//        sharedInstance = [[TTQRootViewController alloc] init];
    });
    
    
    return sharedInstance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    L();

    //TODO: Delete
    [self deleteFirstTimeLoadedInformation];
    
    self.chooseLangVC = [[ChooseLangViewController alloc] init];
    self.hallEntranceVC = [[HallEntranceViewController alloc] init];
    self.hallEntranceNav = [[UINavigationController alloc] initWithRootViewController:self.hallEntranceVC];
    




    [self toChooseLang];
    
    
//        [UIScreen mainScreen].bounds.size.height

}

- (void)viewDidAppear:(BOOL)animated{
    
    L();
    [super viewDidAppear:animated];
    
    [self test];
    
//    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"hall"];
//    NSDictionary *hallDict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    NSLog(@"hall Dict # %@",hallDict);

//    NSLog(@"hall # %@,arts # %@",[[AppManager sharedInstance] hall],[[AppManager sharedInstance] arts]);
    
    NSLog(@"isSmallPhone # %d",  isSmallPhone);
  
    
    
    NSLog(@"app # %@,_w # %f, _h # %f",APPNAME,_w,_h);
    

   }



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Super Fcns
- (void)handleAppFirstTimeOpen{
    L();
    
    //设定默认语言
    [[NSUserDefaults standardUserDefaults] setObject:TTQLangZh forKey:TTQLangKey];
    
    
    // 载入网络数据
//    [[NetworkClient sharedInstance] queryFirstTimeOpenedWithBlock:^(NSDictionary *dict, NSError *error) {
//
//
//        //第一次载入app用
//        [[AppManager sharedInstance] configHallDict:dict];
//   
//        
//        //保存hall到defaults中
//        NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:dict];
//        [[NSUserDefaults standardUserDefaults] setObject:dataSave forKey:TTQHallKey];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//
//    }];

    [AppManager sharedInstance];
}

#pragma mark - Fcns



- (void)toChooseLang{
    [self.view addSubview:self.chooseLangVC.view];
}


- (void)toHallEntrance{
    
    [self.view addSubview:self.hallEntranceNav.view];
}

- (void)toHall{
    
}

- (void)toLogin{
    L();
    
    KQLoginViewController *vc = [[KQLoginViewController alloc] init];
    self.loginNav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:self.loginNav animated:YES completion:^{
        
        
    }];
    
}

/// 因为只有在chooseLange这里能改语言，所以reset hallEntrance就可以了。 如果有setting的话，就不能这么简单了
- (void)didChangeLanguage{
    self.hallEntranceVC = [[HallEntranceViewController alloc] init];
    self.hallEntranceNav = [[UINavigationController alloc] initWithRootViewController:self.hallEntranceVC];
    

}


- (void)didLogin{
//    self.selectedIndex = 3;
    
}
- (void)didLogout{

//    self.selectedIndex = 0;
}

- (void)deleteFirstTimeLoadedInformation{

    
//    TTQHallKey
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:TTQHallKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)test{
    L();
    
    [[NetworkClient sharedInstance] test];
    [[UserController sharedInstance] test];
    [[BeaconManager sharedInstance] test];
    [TextManager sharedInstance];
    
//    NSLog(@"lang # %@",TTQLangEn);
//    [self testNav:@"NavigationViewController"];

}

@end
