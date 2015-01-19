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

#import "UIImage+Alpha.h"
#import "UMSocialSinaHandler.h"
#import "MobClick.h"

#define kWeixinAppId @"wxcbdb435367bde789"
#define kWeixinAppSecret @"3ca5784e3c587f9183e9d65941a67c60"

@implementation TTQAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    [self initUmeng];
    
    NSLog(@"is tool version %d",isToolVersion());
    NSLog(@"isSmallPhone # %d",  isSmallPhone);    
    NSLog(@"app # %@,_w # %f, _h # %f",APPNAME,_w,_h);
    NSLog(@"lang # %@",kLang);

//	self.window.rootViewController = [TTQRootViewController sharedInstance];
    
    
    
    return YES;
}

- (void)initUmeng
{
    // 友盟
    [UMSocialData setAppKey:kUmengAppKey];
    
    [UMSocialWechatHandler setWXAppId:kWeixinAppId appSecret:kWeixinAppSecret url:@"http://www.51ttq.com"];
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://www.51ttq.com"];
    
    // 分析
    [MobClick startWithAppkey:kUmengAppKey reportPolicy:BATCH   channelId:@""];
    // 在线参数
    [MobClick updateOnlineConfig];
}


- (void)customizeAppearance{

   
///     取消navibar下方的阴影线
///    不能简单用44的图片来替换！，可能64可以？  不能使用的原因是：使用后storyboard中push出来的VC的navibar永远是白色的，不能调！！
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"]
//                                      forBarPosition:UIBarPositionAny
//                                         barMetrics:UIBarMetricsDefault];
    
    
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];  //

//    [[UINavigationBar appearance] setBarTintColor:kColorWhite];  //背景色
    

    

    
    
    //  NavigationBar 半透明
    UIImage *gradientImage44 = [UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:0.4]]; //replace "nil" with your method to programmatically create a UIImage object with transparent colors for portrait orientation
    
    UIImage *gradientImage32 = [UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:0.4]]; //replace "nil" with your method to programmatically create a UIImage object with transparent colors for landscape orientation
    
    //customize the appearance of UINavigationBar
    [[UINavigationBar appearance] setBackgroundImage:gradientImage44 forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:gradientImage32 forBarMetrics:UIBarMetricsLandscapePhone];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    
    // Title文字
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont fontWithName:kFontBoldName size:16]}];
    
    //BarButton 颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    

    // --------- Segment
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                              NSForegroundColorAttributeName : kColorDardGray,
                                                              NSFontAttributeName:[UIFont fontWithName:kFontBoldName size:13]
                                                              } forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                              NSForegroundColorAttributeName : [UIColor whiteColor],
                                                            NSFontAttributeName:[UIFont fontWithName:kFontBoldName size:13]
                                                              } forState:UIControlStateHighlighted];
  
    // Title文件颜色
    [[UISegmentedControl appearance] setTintColor:kColorWhite];
    

    

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
