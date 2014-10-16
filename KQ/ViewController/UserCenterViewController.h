//
//  UserCenterViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ConfigViewController.h"
#import <MessageUI/MessageUI.h>

@class  HallViewController;
@interface UserCenterViewController : ConfigViewController<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, MFMailComposeViewControllerDelegate>{
    People *_people;

    HallViewController *_hallVC;
}

- (IBAction)logout;

- (void)toCoupons;
- (void)toShops;
- (void)toCards;
- (void)toFavoritedCoupons;
- (void)toSettings;
- (void)toFavoritedArts;

- (void)willLogout;

/**
 *	@brief	登录成功
 */
- (void)didLogin;

@end
