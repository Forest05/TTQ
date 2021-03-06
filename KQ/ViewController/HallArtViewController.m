//
//  HallArtViewController.m
//  DDX
//
//  Created by Forest on 14-12-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "HallArtViewController.h"
#import "MapViewController.h"
#import "UIImageView+WebCache.h"

@interface HallArtViewController ()

@end

@implementation HallArtViewController

- (void)setArt:(Art *)art{

    _art = art;
    

    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
    
    _1933keys = @[lang(@"地址：上海溧阳路611号1933老场房1-311单元"),lang(@"电话：32582558"),lang(@"展期：2014.10.18 - 12.28"),lang(@"开放时间：周二至周日 10：30 - 18：30")];
    _1933keys2 = @[lang(@"地址：上海溧阳路611号1933老场坊"),lang(@"电话：32582558")];
    
    _manager = [AppManager sharedInstance];
    
    self.hall = _manager.hall;
    _constraint  = CGSizeMake(300, 10000);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
//
}


#pragma mark - TableView


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 13;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int row = 1;
    if (section == 4) { // 1933画廊信息
        row = 4;
    }
    else if(section == 8){
        row = 2;
    }
    
    return row;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int section = indexPath.section;
    CGFloat height = 50;
    if (section == 0) {
        height = 200;
    }
    else if(section == 2){ //desc
   
        CGSize constraint = _constraint;
        NSString *text = isZH?_art.desc:_art.description_en;
        UIFont *font = _descFont;
        CGRect textRect = [text boundingRectWithSize:constraint options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil];
        height = textRect.size.height + 20;
    }
    else if(section == 4){
        height = 30;
    }
    else if (section == 5){
        height = 200;
    }
    else if (section == 6){
        ImageText *it = self.hall.imageTexts[3];
        CGSize constraint = _constraint;
    
        NSString *text = isZH?it.text:it.text_en;
        
        UIFont *font = _descFont;
        CGRect textRect = [text boundingRectWithSize:constraint options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil];
        height = textRect.size.height +20;
    }
    else if (section == 9){
        height = 200;
    }
    
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//    static NSString *CellIdentifier1 = @"Cell1";
    
    int section = indexPath.section;
    int row = indexPath.row;
    
    //!!!: 可以根据Setting的不同进行不同的工作
    UITableViewCell *cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    cell.backgroundColor = [UIColor clearColor];
   
    
    
    float width = self.view.width;
    
    if (section == 0) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 200)];
        [imgV  setImageWithURL:[NSURL URLWithString:_art.imgUrl] placeholderImage:nil];

        [cell addSubview:imgV];
    
    }
    else if(section == 1){ // title & author
        cell.textLabel.text = isZH?_art.name:_art.name_en;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textColor = [UIColor whiteColor];

    }
    else if(section == 2){  // desc
        CGSize constraint = CGSizeMake(300, 10000);
        NSString *text = isZH?_art.desc:_art.description_en;
        UIFont *font = _descFont;
        CGRect textRect = [text boundingRectWithSize:constraint options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil];


        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, textRect.size.height)];
        label.font = _descFont;
        label.text =text;
        label.numberOfLines = 0;
        label.textColor = kColorTextWhite;

        [cell addSubview:label];
    }
    else if(section == 3){  // 更多
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.width, 50)];
        v.backgroundColor = [UIColor colorWithWhite:1 alpha:.1];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 50)];
        label.font = _descFont;
        label.text = lang(@"更多精彩作品展于： 1933当代艺术中心，《石头、木头和天堂症候群》");
        label.numberOfLines = 0;
        label.textColor = kColorWhite;
        [v addSubview:label];
        [cell addSubview:v];
    }
    else if(section == 4){  // 1933画廊信息
        
        cell.textLabel.text = _1933keys[row];
        cell.textLabel.font = _descFont;
        cell.textLabel.textColor = kColorTextWhite;
        if (row == 0) {
            UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_location2.png"]];
            cell.accessoryView = imgV;
        }
        else if(row == 1){
            UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_telephone.png"]];
            cell.accessoryView = imgV;
        }
    }
    else if(section == 5){ // 1933 图片
    
        ImageText *it = self.hall.imageTexts[3];
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 200)];
        [imgV  setImageWithURL:[NSURL URLWithString:it.imageUrl] placeholderImage:nil];
        
        [cell addSubview:imgV];

    }
    else if(section == 6){  // 1933 desc
        ImageText *it = self.hall.imageTexts[3];
        CGSize constraint = CGSizeMake(300, 10000);
        NSString *text = isZH?it.text:it.text_en;
        UIFont *font = _descFont;
        CGRect textRect = [text boundingRectWithSize:constraint options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, textRect.size.height)];
        label.font = _descFont;
        label.text = text;
        label.numberOfLines = 0;
        label.textColor = kColorTextWhite;
        
        [cell addSubview:label];
    }
    else if(section == 7){  // 1933 更多
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.width, 50)];
        v.backgroundColor = [UIColor colorWithWhite:1 alpha:.1];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 50)];
        label.font = _descFont;
        label.text = lang(@"还有更多精彩等着你： 1933老场坊，顶尖时尚创意生活的终极目的地");
        label.numberOfLines = 0;
        label.textColor = kColorWhite;
        [v addSubview:label];
        [cell addSubview:v];
    }
    else if(section == 8){ // 1933 地址，电话
    
        cell.textLabel.text = _1933keys2[row];
        cell.textLabel.font = _descFont;
        cell.textLabel.textColor = kColorTextWhite;
        if (row == 0) {
            UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_location2.png"]];
            cell.accessoryView = imgV;
        }
        else if(row == 1){
            UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_telephone.png"]];
            cell.accessoryView = imgV;
        }

    }
    else if(section == 9){ // 1933 图片
        ImageText *it = self.hall.imageTexts[1];
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 200)];
        [imgV  setImageWithURL:[NSURL URLWithString:it.imageUrl] placeholderImage:nil];
        
        [cell addSubview:imgV];
    }
   
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4 || indexPath.section == 8) {
        if (indexPath.row == 0) { // goto map
            [self toMap];
        }
        else if(indexPath.row == 1){ // dial phone
            
            [self dial];

        }
    }
}

- (void)toMap{
    MapViewController *vc = [[MapViewController alloc] init];
    vc.view.alpha = 1;
//    vc.shop = _shop;
    
    [self.parent.navigationController pushViewController:vc animated:YES];
    
}

- (void)dial{
    NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",@"32582558"];
    
    NSURL *url = [[NSURL alloc] initWithString:telUrl];
    
    
    [[UIApplication sharedApplication] openURL:url];
}
@end
