//
//  ViewController.m
//  TmapMarkerTest
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import "TMapView.h"
#import "DetailViewController.h"

@interface ViewController () <TMapViewDelegate>
@property (strong, nonatomic) TMapView *mapView;

@end



@implementation ViewController

#pragma mark T-MAP DELEGATE

- (void)onClick:(TMapPoint *)point{
    NSLog(@"Tapped Point : %@", point);
}

- (void)onLongClick:(TMapPoint *)point{
    NSLog(@"Long Clicked : %@", point);
}

// 콜아웃 버튼을 누른경우
- (void)onCalloutRightbuttonClick:(TMapMarkerItem *)markerItem{
    NSLog(@"Market ID : %@", [markerItem getID]);
    if ([@"T-ACADEMY" isEqualToString:[markerItem getID]]) {
        DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
        detailVC.urlStr = @"https://oic.skplanet.com";
        
        // 모달로 표시
        [self presentViewController:detailVC animated:YES completion:nil];
    }
}

- (void)onCustomObjectClick:(TMapObject *)obj{
    if ([obj isKindOfClass:[TMapMarkerItem class]]) {
        TMapMarkerItem *market = (TMapMarkerItem *)obj;
        NSLog(@"Market Clicked.. %@", [market getID]);
    }
}
- (IBAction)addOverlay:(id)sender {
    CLLocationCoordinate2D coord[5] ={
        CLLocationCoordinate2DMake(37.460143, 126.914062),CLLocationCoordinate2DMake(37.469136, 126.981869),CLLocationCoordinate2DMake(37.437930, 126.989937),CLLocationCoordinate2DMake(37.413255, 126.959038),CLLocationCoordinate2DMake(37.426752, 126.913548)
    };
    
    TMapPolygon *polygon = [[TMapPolygon alloc] init];
    [polygon setLineColor:[UIColor redColor]];
    [polygon setPolygonAlpha:0];
    [polygon setLineWidth:8.0];
    
    for (int i = 0; i < 5; i++) {
        [polygon addPolygonPoint:[TMapPoint mapPointWithCoordinate:coord[i]]];
    }
    
    [_mapView addTMapPolygonID:@"관악산" Polygon:polygon];
}
- (IBAction)addMarker:(id)sender {
    NSString *itemID = @"T-ACADEMY";
    
    TMapPoint *point = [[TMapPoint alloc] initWithLon:126.96 Lat:37.466];
    TMapMarkerItem *marker = [[TMapMarkerItem alloc] initWithTMapPoint:point];
    [marker setIcon:[UIImage imageNamed:@"icon_clustering@2x.png"]];
    
    // 콜 아웃 설정
    [marker setCanShowCallout:YES];
    [marker setCalloutTitle:@"티 아카데미"];
    [marker setCalloutRightButtonImage:[UIImage imageNamed:@"TrackingDot@2x.png"]];
    
    [_mapView addTMapMarkerItemID:itemID Marker:marker];
}

- (IBAction)moveToSeoul:(id)sender {
    TMapPoint *centerPoint = [[TMapPoint alloc]initWithLon:126.96 Lat:37.466];
    [_mapView setCenterPoint:centerPoint];
}






- (void)viewDidLoad
{
    [super viewDidLoad];
    // 툴바의 크기를 고려한 mapView
    CGRect rect = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60);
    _mapView = [[TMapView alloc] initWithFrame:rect];
    [_mapView setSKPMapApiKey:@"7b7b1456-6496-3c3e-ae92-3cf87fd15065"];
    _mapView.zoomLevel = 12.0;
    
    // 델리게이트 지정
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
