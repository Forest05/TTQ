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

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)setSelectedArt:(Art *)selectedArt{
    _selectedArt = selectedArt;
    _tf.text = [NSString stringWithFormat:@"%@ %@",selectedArt.id, selectedArt.name];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.isCameraOn = NO;

    self.title = lang(@"智能导览");
    
    _appManager = [AppManager sharedInstance];
    
    [self registerNotification];
    
    
     _artView = [[ArtNavView alloc] initWithFrame:CGRectMake(10, 10, _w - 20, 400)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *backBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backBB;
    
    UIBarButtonItem *cameraBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleCameraClicked:)];
    self.navigationItem.rightBarButtonItem = cameraBB;

    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    
    UIImageView *mapV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, _w-20, 177)];
    mapV.image = [UIImage imageNamed:@"4picker2.png"];
    
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(mapV.frame)+ 10, _w - 20, 50)];
    titleL.text = lang(@"打开蓝牙，作品相关信息会自动推送到手机屏幕\n也可手动选择作品查看。");
    titleL.font = [UIFont fontWithName:kFontName size:14];
    titleL.textColor = kColorLightGreen;
    titleL.numberOfLines = 0;
    
    CGFloat y = CGRectGetMaxY(titleL.frame);
    UILabel *hintL = [[UILabel alloc] initWithFrame:CGRectMake(10, y , 80, 40)];
    hintL.font = [UIFont fontWithName:kFontName size:14];
    hintL.textColor = kColorGray;
    hintL.text = lang(@"请输入作品编号");
    
    UITextField *artTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(hintL.frame), y, 150, 50)];
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
    
    UIButton *navBtn = [UIButton buttonWithFrame:CGRectMake(50, CGRectGetMaxY(artTf.frame) + 10, _w - 100, 40) title:@"确定" bgImageName:nil target:self action:@selector(navButtonClicked:)];
    navBtn.backgroundColor = kColorGreen;
    
    [scrollView addSubview:titleL];
    [scrollView addSubview:mapV];
    [scrollView addSubview:hintL];
    [scrollView addSubview:artTf];
    [scrollView addSubview:navBtn];
    
    [self.view addSubview:scrollView];
    
    _scrollView = scrollView;
    
    
}

- (void)viewWillAppear:(BOOL)animated{

    L();
    [super viewWillAppear:animated];
    
    [[BeaconManager sharedInstance] startRanging];
}

- (void)viewDidAppear:(BOOL)animated{

    L();
    [super viewDidAppear:animated];
    
//    [self openCamera];
}

- (void)viewDidDisappear:(BOOL)animated{

    L();
    [super viewDidDisappear:animated];
    
    [[BeaconManager sharedInstance] stopRanging];
    [self closeArt];
}


- (void)registerNotification {
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kOpenBeaconNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note){
        NSLog(@"open Beacon # %@",note.object);
        //需要判别是否是art的beacon还是展厅的beacon
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kCloseBeaconNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note){
        NSLog(@"close Beacon # %@",note.object);
    }];
    
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
  
    return [NSString stringWithFormat:@"%@ %@",art.id,art.name];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    L();
    
    self.selectedArt = _appManager.arts[row];
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
  
    
   __weak id vc = self;
    _artView.closeBlock = ^{
        
        [vc closeArt];
        
    };
    
    [self.view addSubview:_artView];
}

- (void)closeArt{
    
    [_artView removeFromSuperview];
    
}
- (void)openCamera{

    if (!_camVC) {
        _camVC = [[AVCamViewController alloc] initWithNibName:@"AVCamViewController" bundle:nil];
    }
    
    [_camVC startSesseion];
    
    [_scrollView insertSubview:_camVC.view atIndex:0];
    
    self.isCameraOn = YES;
}
- (void)closeCamera{
    
 
    [_camVC.view removeFromSuperview];
    [_camVC stopSesseion];
    self.isCameraOn = NO;
}


@end
