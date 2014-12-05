//
//  KQAppDelegate.m
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "TTQAppDelegate.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "TTQRootViewController.h"
#import "TTQRootViewController.h"

#define kWeixinAppId @"wxb5fa63851976db24"
#define kWeixinAppSecret @"6a4c1967026aa2ec977d3d9eee5017e9"

@implementation TTQAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    [self initUmeng];
    
//    [self initAvosCloud];

    
//	self.window.rootViewController = [TTQRootViewController sharedInstance];
    
    
    
    return YES;
}

- (void)initUmeng
{
    // 友盟
    [UMSocialData setAppKey:kUmengAppKey];
    
//    [UMSocialWechatHandler setWXAppId:kWeixinAppId url:@"http://www.51ttq.com"];
    [UMSocialWechatHandler setWXAppId:kWeixinAppId appSecret:kWeixinAppSecret url:@"http://www.quickquan.com"];
}

- (void)initAvosCloud{
    
//    static NSString *AVOSApplicationId = @"ezxvldwk94k38d6fki1ks4yq55jkl2t15tttu5ezdqbk8mio";
//    static NSString *AVOSClientKey = @"mtbrztjctplgnho2qf49cs70gd4lfggiayww7u6h4mv5s60t";
//    [AVOSCloud setApplicationId:AVOSApplicationId clientKey:AVOSClientKey];

}

- (void)customizeAppearance{

   
///     取消navibar下方的阴影线
///    不能简单用44的图片来替换！，可能64可以？  不能使用的原因是：使用后storyboard中push出来的VC的navibar永远是白色的，不能调！！
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"]
//                                      forBarPosition:UIBarPositionAny
//                                         barMetrics:UIBarMetricsDefault];
    
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];  //

    [[UINavigationBar appearance] setBarTintColor:kColorGreen];  //背景色
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]]; //title文字颜色
    
    // Title文字
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont fontWithName:kFontBoldName size:16]}];
    
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                              NSForegroundColorAttributeName : kColorDardGray,
                                                              NSFontAttributeName:[UIFont fontWithName:kFontBoldName size:13]
                                                              } forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                              NSForegroundColorAttributeName : [UIColor whiteColor],
                                                            NSFontAttributeName:[UIFont fontWithName:kFontBoldName size:13]
                                                              } forState:UIControlStateHighlighted];
    // Title文件颜色
    [[UISegmentedControl appearance] setTintColor:kColorLightYellow];
    

}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}


@end
