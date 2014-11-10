//
//  RegisterViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 6/27/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "RegisterViewController.h"
#import "TextManager.h"
#import "LibraryManager.h"

@interface RegisterViewController (){
    
      
}

@end

@implementation RegisterViewController

#define kCellHeight 44.0

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    
    self.title = lang(@"注册");
    
//    self.view.backgroundColor = kColorBG;
//
//    
////    _tableImageNames = @[@"icon-user.png",@"icon-identifying.png",@"icon-password01.png",@"icon-password02.png"];
//      _tableImageNames = @[@"icon_user.png",@"icon_password.png"];
//    
//    CGFloat x = 60;
//    
//    _userTextField = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, 250, kCellHeight)];
////    _userTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_user.png"]];
////    _userTextField.leftViewMode = UITextFieldViewModeAlways;
//    _userTextField.autocorrectionType =UITextAutocorrectionTypeNo;
//    _userTextField.placeholder = lang(@"用户名");
//    _userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    
//    
////    _verifyTextField = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, 180, kCellHeight)];
////    _verifyTextField.placeholder = @"手机验证码";
//    
//    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, 250, kCellHeight)];
//    _passwordTextField.placeholder = lang(@"密码");
//    _passwordTextField.secureTextEntry = YES;
//    _passwordTextField.autocorrectionType =UITextAutocorrectionTypeNo;
//    _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    
//
////    _rePasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, 250, kCellHeight)];
////    _rePasswordTextField.placeholder = @"密码(至少6位)";
////    _rePasswordTextField.secureTextEntry = YES;
////    _rePasswordTextField.autocorrectionType =UITextAutocorrectionTypeNo;
////    _rePasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
////    _rePasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//
//    _tfs = @[_userTextField,_passwordTextField];
//    
//    
////    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 102, 212, 40)];
////    _usernameTextField.placeholder = @"昵称";
//    
//
//
//    
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _w, 250) style:UITableViewStyleGrouped];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.scrollEnabled = NO;
//    _tableView.backgroundColor = [UIColor clearColor];
//    
//    
//    CGFloat y = CGRectGetMaxY(_tableView.frame);
//    
//    //TODO: 可以用TogoleBtn refactor
//    _selected = YES;
//    _selectBtn = [UIButton buttonWithFrame:CGRectMake(10, y, 30, 30) title:nil bgImageName:@"icon-agreement03.png" target:self action:@selector(selectAgreementClicked:)];
//
//    _readL = [[UILabel alloc] initWithFrame:CGRectMake(45, y, 100, 30)];
//    _readL.text = @"我已阅读并同意";
//    _readL.textColor = kColorDardGray;
//    _readL.font = [UIFont fontWithName:kFontName size:14];
//    _readL.userInteractionEnabled = YES;
//    [_readL addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(selectAgreementClicked:)]];
//    
//    _agreementB = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(_readL.frame), y, 120, 30) title:@"《快券注册协议》" bgImageName:nil target:self action:@selector(agreementClicked:)];
//    [_agreementB setTitleColor:kColorBlue forState:UIControlStateNormal];
//    _agreementB.titleLabel.font = [UIFont fontWithName:kFontName size:14];
//    _agreementB.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
//    
//    _registerB = [UIButton buttonWithFrame:CGRectMake(10, CGRectGetMaxY(_selectBtn.frame) + 10 , 300, 40) title:@"注册" bgImageName:nil target:self action:@selector(signUpUserPressed:)];
//    [_registerB.titleLabel setFont:[UIFont fontWithName:kFontBoldName size:18]];
//    _registerB.layer.cornerRadius = 3;
//    _registerB.backgroundColor = kColorGreen;
//
//    
//    [_scrollView addSubview:_tableView];
//    [_scrollView addSubview:_registerB];
//
//
//    _scrollView.contentSize = CGSizeMake(0, 668);
    
    
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
    
    
    
    CGFloat y = CGRectGetMaxY(_tableView.frame) + 10;
    _registerB = [UIButton buttonWithFrame:CGRectMake(10, y, 300, 40) title:lang(@"注册") bgImageName:nil target:self action:@selector(signUpUserPressed:)];
    _registerB.titleLabel.font = [UIFont fontWithName:kFontName size:18];
    _registerB.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    _registerB.layer.cornerRadius = 3;
    _registerB.backgroundColor = kColorGreen;
    
    
    
    [_scrollView addSubview:logoV];
    [_scrollView addSubview:_tableView];
//    [_scrollView addSubview:_loginB];
    [_scrollView addSubview:_registerB];
    //    [_scrollView addSubview:_forgetB];
    
    
    
    _scrollView.contentSize = CGSizeMake(0, 600);
    
    
    [self.view insertSubview:bgV belowSubview:_scrollView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
#pragma mark - Textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == _userTextField) {
        
        [_passwordTextField becomeFirstResponder];
    }
    else if (textField == _passwordTextField) {
        //        NSLog(@"go to login");
        [self signUpUserPressed:nil];
    }
    
    return YES;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 1.0;
//    }
//    else{
//        return 20;
//    }
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (indexPath.section == 0) {
//        return 55;
//    }
//    else
        return kCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    int section  = indexPath.section;
    
    
    static NSString *CellIdentifier1 = @"Cell1";
    
    //
    
    //!!!: 可以根据Setting的不同进行不同的工作
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
    
    
        cell.imageView.image = [UIImage imageNamed:_tableImageNames[indexPath.row]];

        [cell.contentView addSubview:_tfs[indexPath.row]];

//        if (indexPath.row == 1) {
//            _identifyB = [UIButton buttonWithFrame:CGRectMake(230, 3, 90, kCellHeight - 6) title:@"获取验证码" bgImageName:nil target:self action:@selector(identifyClicked:)];
//            
//            [_identifyB setTitleColor:kColorYellow forState:UIControlStateNormal];
//            [_identifyB.titleLabel setFont:[UIFont fontWithName:kFontName size:14]];
//            
//            UIView *borderV = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_identifyB.frame)-1, 5,1,kCellHeight-10)];
//            borderV.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
//            
//            [cell.contentView addSubview:_identifyB];
//            [cell.contentView addSubview:borderV];
//        }
//        
    
   
    
   
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
}

#pragma mark - IBAction
- (IBAction)selectAgreementClicked:(id)sender{
    L();
    
    if (_selected) {
        [_selectBtn setImage:[UIImage imageNamed:@"icon-agreement01.png"] forState:UIControlStateNormal];
    }
    else{
        [_selectBtn setImage:[UIImage imageNamed:@"icon-agreement03.png"] forState:UIControlStateNormal];
    }
    
    _selected = !_selected;
}

- (IBAction)agreementClicked:(id)sender{
//    L();
//    [self toAgreement];
}


- (IBAction)identifyClicked:(id)sender{
    L();
}
#pragma mark - Private methods


-(IBAction)signUpUserPressed:(id)sender
{

   
}


- (IBAction)toRegister:(id)sender{

}

- (void)registerUser:(NSDictionary *)userInfo{

}

- (void)validateWithBlock:(BooleanResultBlock)block{
}
@end
