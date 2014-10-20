//
//  NavigationViewController.m
//  DDX
//
//  Created by Forest on 14-10-5.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "NavigationViewController.h"
#import "BeaconManager.h"
#import "TextManager.h"
#import "TTQBeacon.h"

@interface NavigationViewController (){
    CATransition *animation;
    UIButton *closeBtn;
    UIButton *navBtn;
    UILabel *hintL;
}

- (void)adjustShowDistance;
- (void)adjustCloseDistance;

@end

@implementation NavigationViewController

- (void)setSelectedArt:(Art *)selectedArt{

    _selectedArt = selectedArt;

    NSString *name = isZH?selectedArt.name:selectedArt.name_en;

    _tf.text = [NSString stringWithFormat:@"%@", name];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.isCameraOn = NO;

    self.title = lang(@"智能导览");
    
    _appManager = [AppManager sharedInstance];
    
    animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    animation.subtype = kCATransitionFromRight;

    closeBtn = [UIButton buttonWithFrame:CGRectMake(_w - 50, 20 ,30, 30) title:nil bgImageName:@"icon_close.png" target:self action:@selector(closeBtnClicked:)];
    
    [self registerNotification];
    
    
     _artView = [[ArtNavView alloc] initWithFrame:CGRectMake(10, 10, _w - 20, 400)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *backBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backBB;
    
    UIBarButtonItem *cameraBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"camera_active.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleCameraClicked:)];
    self.navigationItem.rightBarButtonItem = cameraBB;
    _cameraBB = cameraBB;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    
    UIImageView *mapV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, _w-20, 177)];
    mapV.image = [UIImage imageNamed:@"4picker2.png"];
    
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(mapV.frame)+ 10, _w - 20, 50)];
    titleL.text = lang(@"打开蓝牙，作品相关信息会自动推送到手机屏幕也可手动选择作品查看。");
    
//    titleL.text =@"打开蓝牙，作品相关\n信息会自动推送到手机\n屏幕也可手动选择作品查看。";
    titleL.font = [UIFont fontWithName:kFontName size:14];
    titleL.textColor = kColorLightGreen;
    titleL.numberOfLines = 0;
    
    CGFloat y = CGRectGetMaxY(titleL.frame);
    hintL = [[UILabel alloc] initWithFrame:CGRectMake(10, y , 80, 40)];
    hintL.font = [UIFont fontWithName:kFontName size:14];
    hintL.textColor = kColorGray;
    hintL.text = lang(@"请输入作品编号");
    
    UITextField *artTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(hintL.frame), y, _w-10 - CGRectGetMaxX(hintL.frame), 40)];
    artTf.font = [UIFont fontWithName:kFontBoldName size:14];
    artTf.textColor = kColorGreen;
    
    _tf = artTf;
    
    
    self.selectedArt = _appManager.arts[0];
    

    artTf.delegate = self;

    _tf = artTf;
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    _tf.inputView = pickerView;
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, _w, 44)]; //should code with variables to support view resizing
    UIBarButtonItem *doneButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(inputAccessoryViewDidFinish)];
    
    
    //using default text field delegate method here, here you could call
    //myTextField.resignFirstResponder to dismiss the views
    
    UIBarButtonItem *fBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [myToolbar setItems:[NSArray arrayWithObjects: fBB,doneButton,nil] animated:NO];
    _tf.inputAccessoryView = myToolbar;
    
    navBtn = [UIButton buttonWithFrame:CGRectMake(50, CGRectGetMaxY(artTf.frame) + 10, _w - 100, 40) title:lang(@"展示") bgImageName:nil target:self action:@selector(navButtonClicked:)];
    navBtn.backgroundColor = kColorGreen;
    
    [scrollView addSubview:titleL];
    [scrollView addSubview:mapV];
    [scrollView addSubview:hintL];
    [scrollView addSubview:artTf];
    [scrollView addSubview:navBtn];
    
    [self.view addSubview:scrollView];
    
    _scrollView = scrollView;
    
    
//    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
//    _label.backgroundColor = [UIColor redColor];
//    [scrollView addSubview:_label];
    
//    UIButton *b = [UIButton buttonWithFrame:CGRectMake(10, _h - 30, 50, 30) title:@"Min" bgImageName:nil target:self action:<#(SEL)#>]

}

- (void)viewWillAppear:(BOOL)animated{

    L();
    [super viewWillAppear:animated];
    
    [[BeaconManager sharedInstance] startRanging];
}

- (void)viewDidAppear:(BOOL)animated{

    L();
    [super viewDidAppear:animated];
    
    [self openCamera];
    
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kOpenExhiBeaconNotificationKey object:nil];
}

- (void)viewDidDisappear:(BOOL)animated{

    L();
    [super viewDidDisappear:animated];
    
    [[BeaconManager sharedInstance] stopRanging];
    [self closeArt];
    [closeBtn removeFromSuperview];
}


- (void)registerNotification {
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kOpenBeaconNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note){
        NSLog(@"open Beacon # %@",note.object);
        //需要判别是否是art的beacon还是展厅的beacon
        
        TTQBeacon *beacon = note.object;
        Art *art = [_appManager artWithTTQBeacon:beacon];
        
        //如果没有打开的展品，打开
        if (art && !self.showedArt) {
            [self showArt:art];
        }
//        _label.text = [NSString stringWithFormat:@"Open Beacon # %d",beacon.minorValue];
        

    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kCloseBeaconNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note){
        NSLog(@"close Beacon # %@",note.object);
        
        TTQBeacon *beacon = note.object;
        Art *art = [_appManager artWithTTQBeacon:beacon];
        
        // 如果离开当前打开的展品，关闭
//        if (art && [art.name isEqualToString:self.showedArt.name]) {
//            [self closeArt];
//        }

        if (art) {
            [self closeArt];
        }
    }];
    
//    [[NSNotificationCenter defaultCenter] addObserverForName:kOpenExhiBeaconNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note){
////        NSLog(@"open Exhi Beacon # %@",note.object);
//        //需要判别是否是art的beacon还是展厅的beacon
//    
//        
//        [self showExhibition:_appManager.exhibition];
//        
//        
//    }];
//    
//    [[NSNotificationCenter defaultCenter] addObserverForName:kCloseExhiBeaconNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note){
////        NSLog(@"close Exhi Beacon # %@",note.object);
//        
//    
//        [self closeExhibition];
//        
//    }];
//
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPicker
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return _appManager.arts.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    Art *art = _appManager.arts[row];
  
//    return [NSString stringWithFormat:@"%@ %@",art.id,art.name];

    NSString *name = isZH?art.name:art.name_en;
    return [NSString stringWithFormat:@"%@", name];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    L();
    
    self.selectedArt = _appManager.arts[row];
    
    [self showArt:self.selectedArt];
}

#pragma mark - IBAction

- (IBAction)navButtonClicked:(id)sender{
    
    [self showArt:self.selectedArt];
    
}

- (IBAction)toggleCameraClicked:(id)sender{
    L();
    if (self.isCameraOn) {
        [self closeCamera];
    }
    else{
        [self openCamera];
    }
}
- (IBAction)closeBtnClicked:(id)sender{
    
    [closeBtn removeFromSuperview];
    [self closeArt];
//    [self closeExhibition];
}


#pragma mark - Fcns

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)inputAccessoryViewDidFinish{
    [_tf resignFirstResponder];
}



- (void)showArt:(Art*)art{

    if (!_artView) {
        _artView = [[ArtNavView alloc] initWithFrame:CGRectMake(10, 10, _w - 20, 400)];

    }
    
    _artView.art = art;
 
    self.showedArt = art;
    [self.view addSubview:_artView];
      [self.view addSubview:closeBtn];
    
     [[self.view layer] addAnimation:animation forKey:@"animation"];
}

- (void)closeArt{
    
    self.showedArt = nil;
    [_artView removeFromSuperview];
    
     [[self.view layer] addAnimation:animation forKey:@"animation"];
    
}
//
//- (void)showExhibition:(Exhibition*)exhi{
//    if (!_exhibitionView) {
//        _exhibitionView = [[ExhibitionNavView alloc] initWithFrame:CGRectMake(10, 10, _w - 20, 400)];
//        
//    }
//    
//    _exhibitionView.exhibition = exhi;
//    
////    self.showedArt = art;
//    [self.view addSubview:_exhibitionView];
//    [self.view addSubview:closeBtn];
//    
//    [[self.view layer] addAnimation:animation forKey:@"animation"];
//}
//
//- (void)closeExhibition{
//    
//    
//    [_exhibitionView removeFromSuperview];
//    
//    [[self.view layer] addAnimation:animation forKey:@"animation"];
//
//}

- (void)openCamera{

    if (!_camVC) {
        _camVC = [[AVCamViewController alloc] initWithNibName:@"AVCamViewController" bundle:nil];
    }
    
//    hintL.hidden = YES;
//    _tf.hidden = YES;
//    navBtn.hidden = YES;
    
    [_camVC startSesseion];
    
    [_scrollView insertSubview:_camVC.view atIndex:0];
    
    self.isCameraOn = YES;
    
//    [_cameraBB setImage:[UIImage imageNamed:@"camera_active.png"]];
}
- (void)closeCamera{
    
 
    [_camVC.view removeFromSuperview];
    [_camVC stopSesseion];
    self.isCameraOn = NO;
    
    
//    hintL.hidden = NO;
//    _tf.hidden = NO;
//    navBtn.hidden = NO;
    
//    [_cameraBB setImage:[UIImage imageNamed:@"camera_unactive.png"]];
}


#pragma mark - Test

- (void)adjustShowDistance{
    
//    UIButton *b = [UIButton alloc]
    
}
- (void)adjustCloseDistance{
    
}

@end
