//
//  UserCenterViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UserCenterViewController.h"
#import "PeopleCell.h"
#import "UserCouponsViewController.h"

#import "UserCardsViewController.h"
#import "UserSettingsViewController.h"
#import "UIImageView+WebCache.h"
#import "TextManager.h"
#import "MyHallViewController.h"


#pragma mark - UserCenterViewController

@interface UserCenterViewController (){


}

@end

@implementation UserCenterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = lang(@"我的");

    NSString *configName = isZH?@"UserCenterLoginConfig":@"UserCenterLoginConfig_en";
   
    _config = [[TableConfiguration alloc] initWithResource:configName];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    L();

}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initConfigCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{

    if ([cell isKindOfClass:[PeopleCell class]]) {
        [(PeopleCell*)cell setPeople:_userController.people];
    }
    
    if (indexPath.section == 1) {
        
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0,0);
    }

}

#pragma mark - Table



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section >1) {
        return 20;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
//    NSInteger rowCount = [_config numberOfRowsInSection:section];
    
    
    return 1;
}

#pragma mark -
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    L();
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - AlertView
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    NSLog(@"button # %d",buttonIndex);
    
    if (buttonIndex == 1) {
        [self willLogout];
    }
}

#pragma mark - Mail
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{

    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - IBAction

- (IBAction)logout{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:lang(@"确定要退出当前账号吗？") message:nil delegate:self cancelButtonTitle:lang(@"取消") otherButtonTitles:lang(@"退出"), nil];
    
    [alert show];
    
    
    
}

#pragma mark - Fcns

- (void)toFavoritedArts{


//    _hallVC = [[MyHallViewController alloc] init];
//    
//    _hallVC.arts = [[AppManager sharedInstance] arts];
//    
//    [self.navigationController pushViewController:_hallVC animated:YES];
    
}

- (void)contactUs{

    L();
    
    MFMailComposeViewController* mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
//    NSString *emailBody = [info objectForKey:@"emailBody"];
//    NSString *subject = [info objectForKey:@"subject"];
//    NSArray *toRecipients = [info objectForKey:@"toRecipients"];
//    NSArray *ccRecipients = [info objectForKey:@"ccRecipients"];
//    NSArray *bccRecipients = [info objectForKey:@"bccRecipients"];
//    NSArray *attachment = [info objectForKey:@"attachment"]; //0: nsdata, 1: mimetype, 2: filename
    
//    [mailPicker setMessageBody:@"hello world" isHTML:YES];
    [mailPicker setSubject:lang(@"联系我们")];
    [mailPicker setToRecipients:@[@"contact@51ttq.com"]];
    
    
    //	[_root presentModalViewController:mailPicker animated:YES];
    [[TTQRootViewController sharedInstance] presentViewController:mailPicker animated:YES completion:nil];

}


- (void)sendEmail{

}

- (void)toCoupons{

    [self performSegueWithIdentifier:@"toCoupons" sender:nil];
}
- (void)toShops{

    [self performSegueWithIdentifier:@"toShops" sender:nil];
}
- (void)toCards{

    [self performSegueWithIdentifier:@"toCards" sender:nil];
}
- (void)toFavoritedCoupons{

    
    [self performSegueWithIdentifier:@"toFavoritedCoupons" sender:nil];
}
- (void)toSettings{


    [self performSegueWithIdentifier:@"toSettings" sender:nil];
}

- (void)willLogout{
    
    [_userController logout];

//    [_root didLogout];
    
//    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//        
//    }];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didLogin{

    //???: 什么时候调用？
    [self.tableView reloadData];
}
@end


#pragma mark - UserAvatarCell
@interface UserAvatarCell : PeopleCell<UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation UserAvatarCell


- (void)setPeople:(People *)people{
    L();
    [super setPeople:people];
    
    //    if (ISEMPTY(people.avatarUrl)) {
    //
    //        self.avatarV.image = DefaultImg;
    //    }
    //
    //    else{
    //         [self.avatarV setImageWithURL:[NSURL URLWithString:people.avatarUrl] placeholderImage:DefaultImg];
    //    }
    //
    
    self.firstLabel.text = people.username;
    
    if (!ISEMPTY(people.avatarStr)) {
        
        self.avatarV.image = people.avatar;
    }
    
    
}

//height: 190


- (void)awakeFromNib{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.avatarV.layer.cornerRadius = 60;
    self.avatarV.layer.masksToBounds = YES;
    self.avatarV.layer.borderWidth = 8;
    self.avatarV.layer.borderColor = [UIColor whiteColor].CGColor;
    self.avatarV.userInteractionEnabled = YES;
    [self.avatarV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarVPressed:)]];
    self.avatarV.image = [UIImage imageNamed:@"t1.jpg"];
    //    NSLog(@"avatar # %@, userinteract # %d",self.avatarV,self.avatarV.userInteractionEnabled);
    //    self.firstLabel.opaque = YES;
    
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarVPressed:)]];
    self.backgroundColor = kColorBG;
    self.separatorInset = UIEdgeInsetsMake(0, 160, 0, 160);
    
    
    
}

- (IBAction)avatarVPressed:(id)sender{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:lang(@"取消") destructiveButtonTitle:lang(@"照相机") otherButtonTitles:lang(@"图片库"), nil];//f
    
    [sheet showInView:self];
}

- (void)layoutSubviews{
    
    
}
#pragma mark - Actionsheet
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    //    NSLog(@"button # %d",buttonIndex);
    
    if (buttonIndex == 0) { // destructive: 照相机
        [self openCamera];
    }
    else if(buttonIndex == 1){ //other： 图片库
        [self openImageLibrary];
    }
}

#pragma mark - ImagePicker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    L();
    
    /// 存储所有的图片，保存入photoalbum，然后把图片加到album中，一页 3张图
    //    UIImage *editedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    //    NSURL *url = info[UIImagePickerControllerMediaURL];
    //    [importImages addObject:originalImage];
    
    
    //avatar 图片的size是200x200 （retina）
    UIImage *img200 = [originalImage imageByScalingAndCroppingForSize:CGSizeMake(100, 100)];
    
    
    
    // save image to currentuser.avatar
    
    //    [[UserController sharedInstance] setAvatar:img200];
    
    //???: 为什么不能直接变设avatar？
    
    [[NetworkClient sharedInstance] queryUpdateAvatar:self.people.id image:img200 block:^(NSDictionary *dict, NSError *error) {
        
        //        [self imagePickerControllerDidCancel:picker];
        // 更新people
        //        NSLog(@"finish dict # %@",dict);
        
        
        NSData *data = UIImageJPEGRepresentation(img200, .8);
        NSString *base64Str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        self.people.avatarStr = base64Str;
        self.people.avatar = img200;
        
    }];
    
    [self performSelector:@selector(imagePickerControllerDidCancel:) withObject:picker afterDelay:.5];

    
    self.avatarV.image = img200;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    L();
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - Fcns


- (void)openImageLibrary{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    picker.editing = YES;
    
    [[TTQRootViewController sharedInstance] presentViewController:picker animated:YES completion:^{
        
    }];
    
    //    [RootInstance presentModalViewController:picker animated:YES];
    
}


- (void)openCamera{
    L();
    
    /// 显示 camera
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType =  UIImagePickerControllerSourceTypeCamera;
    
    [[TTQRootViewController sharedInstance] presentViewController:picker animated:YES completion:^{
        
    }];
    
}

@end

