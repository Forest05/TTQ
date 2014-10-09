//
//  ChooseLangViewController.m
//  DDX
//
//  Created by Forest on 14-10-5.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ChooseLangViewController.h"
#import "TTQRootViewController.h"
#import "FXLabel.h"

@interface ChooseLangViewController ()

@end

@implementation ChooseLangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _blurView = [[DKLiveBlurView alloc]initWithFrame:self.view.bounds];
     _blurView.isGlassEffectOn = YES;
    [_blurView setInitialBlurLevel:1];
//    [_blurView setInitialGlassLevel:.8];
     _blurView.originalImage = [UIImage imageNamed:@"t1.jpg"];

    
    _zhBtn = [UIButton buttonWithFrame:CGRectMake(130, _h/2-50, 190, 40) title:@"中文" bgImageName:nil target:self action:@selector(buttonClicked:)];
    _zhBtn.tag = 0;
    _zhBtn.backgroundColor = kColorGreen;
    [_zhBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_zhBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    _enBtn = [UIButton buttonWithFrame:CGRectMake(130, _h/2+10, 190, 40) title:@"English" bgImageName:nil target:self action:@selector(buttonClicked:)];
    _enBtn.tag = 1;
    _enBtn.backgroundColor = [UIColor whiteColor];
    [_enBtn setTitleColor:kColorGreen forState:UIControlStateNormal];
    
    [self.view addSubview:_blurView];
    [self.view addSubview:_zhBtn];
    [self.view addSubview:_enBtn];
    
//    FXLabel *l = [[FXLabel alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
//    l.text = @"abc";
//    
//    [self.view addSubview:l];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonClicked:(id)sender{
    int tag = [sender tag];

    [self setLang:tag];
    [self toHallEntrance];
}

- (void)setLang:(int)lang{
    NSString *langStr;
    if (lang == 0) {
        langStr = TTQLangZh;
    }
    else{
        langStr = TTQLangEn;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:langStr forKey:TTQLangKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)toHallEntrance{
    [[TTQRootViewController sharedInstance] toHallEntrance];
}
@end
