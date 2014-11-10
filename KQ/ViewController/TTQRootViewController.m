//
//  KQRootViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "TTQRootViewController.h"


#import "NetworkClient.h"
#import "KQLoginViewController.h"
#import "UserCenterViewController.h"

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
    
    
    NSLog(@"isSmallPhone # %d",  isSmallPhone);
  
    NSLog(@"app # %@,_w # %f, _h # %f",APPNAME,_w,_h);
    
    
//    TTQBeacon *b = [[TTQBeacon alloc] init];
//    b.minorValue = 5;
//    Art *art = [[AppManager sharedInstance] artWithTTQBeacon:b];
//    NSLog(@"art # %@",art.name);
    
//    NSString *filePath = [NSString filePathForResource:@"2.txt"];
//    
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
//    
//    
//    NSLog(@"dict # %@",dict);

    
//    
//    NSString *updatedDate = @"2014-10-15 00:00:00";
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *date = [formatter dateFromString:updatedDate];
//
//    NSLog(@"date # %@",date);
//    NSLog(@"compare # %d",[date compare:[NSDate date]]);// -1 标识 date比现在早， 1 标识 date比现在晚
//
//    
    
//    NSString *filePath = [NSString filePathForResource:@"3.txt"];
//    
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"dict # %@",dict);

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
    [[NSUserDefaults standardUserDefaults] setFloat:2.5 forKey:@"minDistance"];
    [[NSUserDefaults standardUserDefaults] setFloat:3.0 forKey:@"maxDistance"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 载入网络数据
    
//    NSString *filePath = [NSString filePathForResource:@"3.txt"];
//    
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
//    
//    [[AppManager sharedInstance] configHallDict:dict];
}

#pragma mark - Fcns



- (void)toChooseLang{
//    [self.view addSubview:self.chooseLangVC.view];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromRight;
    
    [self.view addSubview:self.chooseLangVC.view];
    

    [[self.view layer] addAnimation:animation forKey:@"animation"];

}


- (void)toHallEntrance{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromRight;

    [self.view addSubview:self.hallEntranceNav.view];
   [[self.view layer] addAnimation:animation forKey:@"animation"];
    
}

//- (void)toHall{
//    
//}

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
//    [self testNav:@"HallViewController"];
    

}

@end
