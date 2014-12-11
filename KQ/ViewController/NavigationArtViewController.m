//
//  NavigationArtViewController.m
//  DDX
//
//  Created by Forest on 14-12-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UIImageView+WebCache.h"

#import "NavigationArtViewController.h"

@interface NavigationArtViewController ()

@end

@implementation NavigationArtViewController


- (void)setArt:(Art *)art{
    _art = art;
    
    [_bannerV setImageWithURL:[NSURL URLWithString:art.imgUrl]];
    _textV.text = _art.desc;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *bgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgV.image = [UIImage imageNamed:@"bg.jpg"];
    bgV.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bgV];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;

    
    _bannerV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 240)];
    
    
    float width = 80;
    float y = CGRectGetMaxY(_bannerV.frame);
    _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, y, 80, self.view.height - y) style:UITableViewStyleGrouped];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.backgroundColor = [UIColor clearColor];
    
    CGRect textViewRect = CGRectInset(CGRectMake(width, y, self.view.width - width, self.view.height - y), 10.0, 20.0);
    _textV = [[UITextView alloc] initWithFrame:textViewRect];
    _textV.backgroundColor = [UIColor clearColor];

    
    [self.view addSubview:_bannerV];
    [self.view addSubview:_tableV];
    [self.view addSubview:_textV];
    
//    NSTextStorage *textStorage = [NSTextStorage new];
//    
//    NSLayoutManager *layoutManager = [NSLayoutManager new];
//    [textStorage addLayoutManager: layoutManager];
//    
//    NSTextContainer *textContainer = [NSTextContainer new];
//    [layoutManager addTextContainer: textContainer];
//    
//    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(width, y, self.view.width - width, self.view.height - y)
//                                               textContainer:textContainer];
//    
//    textView.text = @"l;kasjdfl;kajsdf\
//    sdlfkjsdlkfjslkdjflksdjflsdkfsdfsdfj; l;ksjdf;lakjsdflk;j l;sajkf;lksdjf";
//    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
}


#pragma mark - Table view data source





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 45;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier1 = @"Cell1";
    int row = indexPath.row;
    
    //!!!: 可以根据Setting的不同进行不同的工作
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = [UIColor clearColor];
        
        
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = @"aaa";
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

@end
