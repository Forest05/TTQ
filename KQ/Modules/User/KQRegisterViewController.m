//
//  KQRegisterViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "KQRegisterViewController.h"
#import "UserController.h"
#import "AgreementViewController.h"

#import "NetworkClient.h"

@interface KQRegisterViewController ()

@end

@implementation KQRegisterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userTextField.placeholder = @"手机号";

     _userTextField.keyboardType = UIKeyboardTypeNumberPad;

    _verifyTextField.userInteractionEnabled = NO;
     self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Alert
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{

   

}

#pragma mark - Fcn


- (void)toAgreement{
    
    AgreementViewController *vc = [[AgreementViewController alloc]init];
    vc.title = @"快券注册协议";
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(IBAction)signUpUserPressed:(id)sender
{
    
    ///  先进行validate， 通过后再注册
    [self validateWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
//            NSDictionary *info = @{@"username":self.userTextField.text,@"password":_passwordTextField.text,@"phone":_userTextField.text,
//                                   @"nickname":_usernameTextField.text};

            
            // 这里
            NSDictionary *info = @{@"username":self.userTextField.text,@"password":_passwordTextField.text,@"phone":_userTextField.text,
                                  @"nickname":@"KQ84567033"};
            
            //    NSLog(@"info # %@",info);
            
            [self registerUser:info];
        }
    }];

    
}

- (void)validateWithBlock:(BooleanResultBlock)block{

      NSString *msg = @"请输入所有信息";
    if (ISEMPTY(_userTextField.text) || ISEMPTY(_passwordTextField.text)) {
        [UIAlertView showAlert:msg msg:nil cancel:@"OK"];
        block(NO,nil);
        
    }
    else{
        block(YES,nil);
    }

    
}

- (void)registerUser:(NSDictionary *)userInfo{

    
    [[UserController sharedInstance] registerWithUserInfo:userInfo block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {

            /// 注册成功后显示提示窗
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册成功" message:@"已获免费摩提快券，请前往绑定银行卡" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];

    
}



@end