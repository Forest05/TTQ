//
//  AgreementViewController.m
//  KQ
//
//  Created by Forest on 14-9-11.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()

@end

@implementation AgreementViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    UIBarButtonItem *bb = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_back.png" target:self action:@selector(backPressed:)]];
    
    self.navigationItem.leftBarButtonItem = bb;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    [self.view addSubview:_webView];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)backPressed:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
