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
  

    
    _bannerV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 240)];
    
    
    float width = 80;
    float y = CGRectGetMaxY(_bannerV.frame);
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, 80, self.view.height - y) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(width, y, self.view.width - width, 30)];
    
    
    CGRect textViewRect = CGRectInset(CGRectMake(width, y, self.view.width - width, self.view.height - y), 10.0, 20.0);
    _textV = [[UITextView alloc] initWithFrame:textViewRect];
    _textV.backgroundColor = [UIColor clearColor];
    _textV.textColor = kColorGray;
    
    [self.view addSubview:_bannerV];
    [self.view addSubview:_tableView];
    [self.view addSubview:_textV];
    [self.view addSubview:_titleL];
    
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
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
        
   
        
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textColor = [UIColor whiteColor];
        
    if (row == 0) {
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 44)];
        label.text = @"作品简介";
        label.textColor = [UIColor whiteColor];

        [cell addSubview:label];
        
    }
    else if(row == 1){ // like
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
        imgV.image = [UIImage imageNamed:@"icon_like2.png"];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 40, 44)];
        label.text = @"111";
        label.textColor = [UIColor whiteColor];
        
        [cell addSubview:imgV];
        [cell addSubview:label];
    }
    else if(row == 2){ // share
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
        imgV.image = [UIImage imageNamed:@"icon_share2.png"];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 40, 44)];
        label.text = @"234";
        label.textColor = [UIColor whiteColor];
        
        [cell addSubview:imgV];
        [cell addSubview:label];

    }
    
    if (row<3) {
        UIImageView *lineV = [[UIImageView alloc] initWithFrame:CGRectMake(0, cell.height -1, cell.width, 1)];
        lineV.image = [UIImage imageNamed:@"line.png"];
        [cell addSubview:lineV];

    }
    
//    cell.textLabel.text = @"aaa";
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    L();
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
