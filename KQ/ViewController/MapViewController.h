//
//  MapViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-19.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MapViewController : UIViewController<MKMapViewDelegate>{

}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;




@end


