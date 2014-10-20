//
//  LoginViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "LoginViewController.h"

#import "UserController.h"
#import "TTQRootViewController.h"
#import "ForgetPasswordViewController.h"
#import "TextManager.h"
#import "LibraryManager.h"

@interface LoginViewController ()


@end

@implementation LoginViewController

#define kCellHeight 44.0

- (void)viewDidLoad{

    [super viewDidLoad];
    
    
    self.title = lang(@"用户登录");

    UIImageView *bgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgV.image = [UIImage imageNamed:@"login_调整后BG.jpg"];

    
    UIImageView *logoV = [[UIImageView alloc] initWithFrame:CGRectMake(115, 30, 90, 90)];
    logoV.image = [UIImage imageNamed:@"icon.png"];
    
    _userTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, 250, kCellHeight)];
    _userTextField.keyboardType = UIKeyboardTypeDefault;
    _userTextField.returnKeyType = UIReturnKeyNext;
    _userTextField.placeholder = lang(@"用户名");
    _userTextField.delegate = self;
    _userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, 250, kCellHeight)];//f

    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.delegate = self;
    _passwordTextField.returnKeyType = UIReturnKeyGo;
    _passwordTextField.placeholder = lang(@"密码");
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _tfs = @[_userTextField,_passwordTextField];
    _tableImageNames = @[@"icon_user.png",@"icon_password.png"];
    
    

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(logoV.frame) , _w, 88 + 50) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    
    
    _loginB = [UIButton buttonWithFrame:CGRectMake(10, CGRectGetMaxY(_tableView.frame) +20, 300, 40) title:lang(@"登录") bgImageName:nil target:self action:@selector(loginPressed:)];
    _loginB.backgroundColor = kColorGreen;
    _loginB.titleLabel.font = [UIFont fontWithName:kFontBoldName size:18];
    _loginB.layer.cornerRadius = 3;
    
    CGFloat y = CGRectGetMaxY(_loginB.frame) + 10;
    _registerB = [UIButton buttonWithFrame:CGRectMake(10, CGRectGetMaxY(_loginB.frame) + 10, 300, 40) title:lang(@"注册") bgImageName:nil target:self action:@selector(toRegister)];
    _registerB.titleLabel.font = [UIFont fontWithName:kFontName size:18];
    _registerB.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    _registerB.layer.cornerRadius = 3;
    _registerB.backgroundColor = kColorLightGreen;
    

    
    _forgetB = [UIButton buttonWithFrame:CGRectMake(10, y, 100, 30) title:@"忘记密码?" bgImageName:nil target:self action:@selector(toForget)];
    _forgetB.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    _forgetB.titleLabel.font = [UIFont fontWithName:kFontName size:18];
    
    [_scrollView addSubview:logoV];
    [_scrollView addSubview:_tableView];
    [_scrollView addSubview:_loginB];
    [_scrollView addSubview:_registerB];
//    [_scrollView addSubview:_forgetB];

   

     _scrollView.contentSize = CGSizeMake(0, 700);


    [self.view insertSubview:bgV belowSubview:_scrollView];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [_userTextField becomeFirstResponder];
}

#pragma mark - IBAction

-(IBAction)loginPressed:(id)sender
{
 
    [self loginWithEmail:_userTextField.text password:_passwordTextField.text];
}


- (IBAction)registerPressed:(id)sender{

    [self toRegister];
}

- (IBAction)forgetPressed:(id)sender{

    
    [self toForget];
}
#pragma mark - Textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    if (textField == _userTextField) {

        [_passwordTextField becomeFirstResponder];
    }
   else if (textField == _passwordTextField) {
//        NSLog(@"go to login");
       [self loginPressed:nil];
    }
    
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier1 = @"Cell1";
    
    
    //!!!: 可以根据Setting的不同进行不同的工作
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
        
        [cell.contentView addSubview:_tfs[indexPath.row]];
    }
    
    cell.imageView.image = [UIImage imageNamed:_tableImageNames[indexPath.row]];

//    cell.imageView.image = [UIImage imageNamed:@"icon_password.png"];
  

    
    return cell;
    
}


#pragma mark -
- (void)back{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Fcns

- (void)loginWithEmail:(NSString*)email password:(NSString *)password{
    
    [[LibraryManager sharedInstance] startProgress];
    
    [[UserController sharedInstance] loginWithEmail:email pw:password block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"did login");

            [[LibraryManager sharedInstance] dismissProgress];
            NSString *str = lang(@"欢迎你回来");
            [[LibraryManager sharedInstance] startHint:[NSString stringWithFormat:@"%@, %@",str,email]];
            
            [self back];

            
            
        }
    }];
}




- (void)toRegister{
    
}

- (void)toForget{
    L();
    
    ForgetPasswordViewController *vc = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}




@end
