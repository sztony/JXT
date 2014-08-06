//
//  MapVC.h
//  JXT
//
//  Created by 伍 兵 on 14-8-5.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "RootVC.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface MapVC : RootVC
{
   IBOutlet  MKMapView* _mapView;
}
@end
