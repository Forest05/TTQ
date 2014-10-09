//
//  ChooseLangViewController.h
//  DDX
//
//  Created by Forest on 14-10-5.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DKLiveBlurView.h"

@interface ChooseLangViewController : UIViewController{
    
    DKLiveBlurView *_blurView;
    
    UIButton *_zhBtn;
    UIButton *_enBtn;
}

- (void)setLang:(int)lang;
- (void)toHallEntrance;

@end
