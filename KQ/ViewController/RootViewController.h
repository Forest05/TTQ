//
//  RootViewController.h
//  Test
//
//  Created by AppDevelopper on 14-4-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UtilLib.h"

@interface RootViewController : UIViewController{
    
    BOOL rootLoadViewFlag;  //如果flag为true，说明root还没有load，也就是本次应用的第一次load
    
    NSMutableArray *testObjs;
    
}


+ (id)sharedInstance;



//inherit
- (void)registerNotification;
- (void)handleAppFirstTimeOpen;
- (void)handleRootFirstWillAppear;


- (void)test;
- (void)testViewController:(NSString*)className;
- (void)testNav:(NSString*)className;

@end
