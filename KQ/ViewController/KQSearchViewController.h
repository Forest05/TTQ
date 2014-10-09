//
//  KQSearchViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-27.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//


#import "UserController.h"
#import "TTQRootViewController.h"
#import "NetworkClient.h"
#import "LibraryManager.h"
#import "ConfigCell.h"

#import "DistrictsTableView.h"
#import "TagsView.h"
#import "District.h"
#import "CouponType.h"

typedef enum {
    SearchCouponType,
    SearchDistrict
}SearchType;

@interface KQSearchViewController : UIViewController<UISearchBarDelegate>{

    TTQRootViewController *_root;
    UserController *_userController;
    NetworkClient *_networkClient;
    LibraryManager *_libraryManager;

    
    
    IBOutlet UISearchBar *_searchBar;
    IBOutlet TagsView *_hotSearchView;
    IBOutlet DistrictsTableView *_tableView;
    

    NSArray *_districtHotKeywords, *_couponTypeHotKeywords;
    NSDictionary *_districtDataSource, *_couponTypeDataSource; // district -> array of subdistrict
    
    
    
}

@property (nonatomic, assign) SearchType searchType; //
@property (nonatomic, strong) DistrictsTableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSArray *districtHotKeywords;
@property (nonatomic, strong) NSArray *couponTypeHotKeywords;

@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, strong) NSString *districtId;
@property (nonatomic, strong) NSString *subDistrictId;
@property (nonatomic, strong) NSString *couponTypeId;
@property (nonatomic, strong) NSString *subTypeId;
@property (nonatomic, strong) NSMutableDictionary *searchParams;
@property (nonatomic, strong) NSMutableArray *searchResults;


- (IBAction)segmentChanged:(id)sender;

- (void)startSearch;


@end
