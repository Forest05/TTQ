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
#import "LibraryManager.h"

@interface ChooseLangViewController ()

@end

@implementation ChooseLangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    _blurView = [[DKLiveBlurView alloc]initWithFrame:self.view.bounds];
//     _blurView.isGlassEffectOn = YES;
//    [_blurView setInitialBlurLevel:1];
////    [_blurView setInitialGlassLevel:.8];
//     _blurView.originalImage = [UIImage imageNamed:@"t1.jpg"];

    UIImageView *bgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgV.image = [UIImage imageNamed:@"login_调整后BG.jpg"];
    bgV.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
    CGFloat y = isSmallPhone?150:200;
    CGFloat width = 120;
    CGFloat x = _w - width;
    
    _zhBtn = [UIButton buttonWithFrame:CGRectMake(x, y, width, 40) title:@"中文" bgImageName:nil target:self action:@selector(buttonClicked:)];
    _zhBtn.tag = 0;
    _zhBtn.backgroundColor = kColorGreen;
    [_zhBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_zhBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    
    _enBtn = [UIButton buttonWithFrame:CGRectMake(x, CGRectGetMaxY(_zhBtn.frame)+10, width, 40) title:@"English" bgImageName:nil target:self action:@selector(buttonClicked:)];
    _enBtn.tag = 1;
    _enBtn.backgroundColor = [UIColor whiteColor];
    [_enBtn setTitleColor:kColorGreen forState:UIControlStateNormal];
    
    NSArray *titles = @[@"日语",@"韩语",@"法语"];
    
    
    [self.view addSubview:bgV];
    [self.view addSubview:_zhBtn];
    [self.view addSubview:_enBtn];
    
    CGFloat y2 = CGRectGetMaxY(_enBtn.frame) + 10;
    for (int i = 0; i<3; i++) {
       
        UIButton *b = [UIButton buttonWithFrame:CGRectMake(x, y2 + 50 * (i), width, 40) title:titles[i] bgImageName:nil target:self action:nil];
        b.backgroundColor = [UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255 alpha:1];
        [b setTitleColor:[UIColor colorWithRed:105.0/255 green:100.0/255 blue:95.0/255 alpha:1] forState:UIControlStateNormal];
        b.alpha = 0.6;
        [self.view addSubview:b];
    }

    
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
    
    [[TTQRootViewController sharedInstance] didChangeLanguage];
    
    
    if ([kLang isEqualToString:@"zh"]) {
        NSLog(@"zh");
    }
    else{
        NSLog(@"en");
    }
    
}

- (void)toHallEntrance{
    [[TTQRootViewController sharedInstance] toHallEntrance];
    
//    [[LibraryManager sharedInstance] shareWithText:@"txt" image:[UIImage imageNamed:@"t1.jpg"] delegate:self];
    
    
}
@end
