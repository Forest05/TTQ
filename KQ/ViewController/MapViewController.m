//
//  MapViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-19.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "MapViewController.h"
#import "UIImageView+WebCache.h"

@interface ShopAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;


- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end


@implementation ShopAnnotation

- (NSString*)title{
    return @"1933老场坊";
}

- (NSString*)subtitle{
    return @"上海市虹口区溧阳路611号";
}

- (id)initWithLocation:(CLLocationCoordinate2D)coord{

    if (self = [super init]) {
        _coordinate = coord;
    
    }
    
    return self;
}


@end

#pragma mark - MapViewController

@interface MapViewController (){


    ShopAnnotation *_shopAnnotation;
}


@end

@implementation MapViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"地图";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _shopAnnotation = [[ShopAnnotation alloc] initWithLocation:CLLocationCoordinate2DMake(31.260334,121.49851)];
   
    
    self.navigationController.navigationBar.translucent = NO;
    _mapView.delegate = self;
    
    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
 
    [_mapView setRegion:MKCoordinateRegionMakeWithDistance(_shopAnnotation.coordinate, 10000, 10000) animated:YES];
    [_mapView addAnnotation:_shopAnnotation];
  

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(ShopAnnotation*)annotation{

    // If the annotation is the user location, just return nil.
    
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        
        return nil;
    }
        // Try to dequeue an existing pin view first.
        
    MKPinAnnotationView*  pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        
    if (!pinView){
            // If an existing pin view was not available, create one.
            
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:@"CustomPinAnnotationView"];
        
         pinView.annotation = annotation;
        
            pinView.pinColor = MKPinAnnotationColorRed;
            
            pinView.animatesDrop = YES;
            
            pinView.canShowCallout = YES;
        
    }
    
        
        return pinView;
        
    
}
@end
