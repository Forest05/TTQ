//
//  RootViewController.m
//  Test
//
//  Created by AppDevelopper on 14-4-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "RootViewController.h"


@interface RootViewController ()



@end

@implementation RootViewController

+ (id)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    rootLoadViewFlag = YES;
    
    testObjs = [NSMutableArray array];
    
    [self registerNotification];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    //TODO: delete
//    if (DEBUG) {
//        [self handleAppFirstTimeOpen];
//    }
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:TTQAPPBeforeOpenedKey]) {
       
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:TTQAPPBeforeOpenedKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self handleAppFirstTimeOpen];
        
    }
    
    if (rootLoadViewFlag) {
        
        rootLoadViewFlag = NO;
        
        [self handleRootFirstWillAppear];
        

        
	}
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleAppFirstTimeOpen{}
- (void)handleRootFirstWillAppear{}


- (void)registerNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleWillEnterForeground)
												 name:UIApplicationWillEnterForegroundNotification
											   object: [UIApplication sharedApplication]];
	
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleWillResignActive) name:UIApplicationWillResignActiveNotification object:[UIApplication sharedApplication]];
    
    
}

- (void)handleWillEnterForeground{}

- (void)handleWillResignActive{
}

- (void)testViewController:(NSString*)className{
    
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    [testObjs addObject:vc];
    [self.view addSubview:vc.view];
}

- (void)testNav:(NSString*)className{
    
    
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    //    nav.view.frame = self.view.bounds;
    
    [testObjs addObject:nav];
//    [testObjs addObject:vc];
    
    [self.view addSubview:nav.view];
}


- (void)test{
    
    //    L();
    
    testObjs = [NSMutableArray array];
}
@end
