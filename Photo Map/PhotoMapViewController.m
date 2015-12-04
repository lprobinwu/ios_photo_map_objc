//
//  PhotoMapViewController.m
//  Photo Map
//
//  Created by Nicholas Aiwazian on 11/26/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

#import "PhotoMapViewController.h"
#import "LocationsViewController.h"
#import <MapKit/MapKit.h>

@interface PhotoMapViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) UIImage *selectedImage;

@end

// Note: implemented all required step
// none of the bonus steps are implemented yet
@implementation PhotoMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.delegate = self;
    
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667),
                                                         MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cameraButtonTapped:(UIButton *)sender {
    
    UIImagePickerController *vc = [[UIImagePickerController alloc]init];
    vc.delegate = self;
    vc.allowsEditing = YES;
    vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
 
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *originalImage = info[@"UIImagePickerControllerOriginalImage"];
    UIImage *editedImage = info[@"UIImagePickerControllerEditedImage"];
    
    self.selectedImage = originalImage;
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"tagSegue" sender:self];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender {
    if ([segue.identifier isEqualToString:@"tagSegue"]) {
        LocationsViewController *vc = (LocationsViewController *)[segue destinationViewController];
        vc.delegate = self;
    }    
}

- (void)locationsPickedLocation:(LocationsViewController *)locationsViewController
                       latitude:(NSNumber *)latitude
                      longitude:(NSNumber *)longitude {
    NSLog(@"locationsPickedLocation called");
    
    [self.navigationController popToViewController:self animated:YES];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    [annotation setCoordinate:coord];
    [annotation setTitle:@"Title"]; //You can set the subtitle too
    [self.mapView addAnnotation:annotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    NSString *reuseId = @"myAnnotationView";
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        annotationView.canShowCallout = YES;
        annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    }
    
    UIImageView *imageView = (UIImageView *)annotationView.leftCalloutAccessoryView;
    imageView.image = [UIImage imageNamed:@"camera"];
    
    return annotationView;
}



@end
