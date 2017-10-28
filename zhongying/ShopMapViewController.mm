//
//  ShopMapViewController.m
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ShopMapViewController.h"

@interface ShopMapViewController ()

@end

@implementation ShopMapViewController

@synthesize shopName, latitude, longitude;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labelName.text = self.shopName;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.mapView removeFromSuperview];
    self.mapView = [[BMKMapView alloc]initWithFrame:self.mapView.frame];
    [self.view addSubview:self.mapView];
    
    [self.mapView setZoomLevel:16];
    BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = self.latitude;
    coor.longitude = self.longitude;
    pointAnnotation.coordinate = coor;
    pointAnnotation.title = self.shopName;
    [self.mapView addAnnotation:pointAnnotation];
    
    self.mapView.centerCoordinate = coor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
