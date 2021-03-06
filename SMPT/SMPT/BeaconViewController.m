//
//  BeaconViewController.m
//  SMPT
//
//  Created by Anh Tran on 06-06-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "BeaconViewController.h"
#import "ViewController.h"
#import "WebRequests.h"
#import "DataContainer.h"
#import "CurrentOrderViewController.h"
#import "ViewGeldAnimatie.h"

static NSString * const kProximityUUID = @"7AF66857-FF47-4225-AC7C-B562511DB4CE";
static NSString * const kRegionLookupIdentifier = @"MyBeaconIdentifier";

@interface BeaconViewController ()
    @property (nonatomic, strong) CLLocationManager *locationManager;
    @property (nonatomic, strong) CLBeaconRegion *beaconRegion;
    @property (nonatomic, strong) CBPeripheralManager *peripheralManager;
    @property (nonatomic, strong) NSArray *detectedBeacons;
    @property (nonatomic, strong) NSMutableArray *detectedRegionInfos;
@end

@implementation BeaconViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        [self initLocationManager];
        [self initBeaconRegion];
        [self initPeripheralMgr];
        NSLog(@"Enabling ranging...");
        
        if (![CLLocationManager isRangingAvailable]) {
            NSLog(@"Warning: Ranging is not Available...");
        }
        
        [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
    }
    return self;
}

- (void)initLocationManager
{
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
    }
}

-(void)initPeripheralMgr
{
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
}
- (IBAction)cancelOrder:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.locationManager stopMonitoringForRegion:self.beaconRegion];
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    [self dismissViewControllerAnimated:true completion:nil];

}

-(void)initBeaconRegion
{
    
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:kProximityUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID major:1 minor:0 identifier:kRegionLookupIdentifier];
    self.beaconRegion.notifyEntryStateOnDisplay = NO;
    self.beaconRegion.notifyOnEntry = YES;
    self.beaconRegion.notifyOnExit = YES;
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region {
    
    if (beacons.count == 0) {
        NSLog(@"No beacons found.");
    } else {
        NSLog(@"Located %lu beacon(s).", (unsigned long)[beacons count]);
        for (CLBeacon * beacon in beacons) {
            NSLog(@"%.5f. - %@", beacon.accuracy, beacon.proximityUUID.UUIDString);
            if(beacon.accuracy < 0.10)
            {
                NSLog(@"verstuur");
                void (^getDrinkBlock)(Boolean, id, NSError*)  =
                ^(Boolean success,id result, NSError* error){
                    if(success)
                    {
                        NSLog(@"%@",[result class]);
                        //[MBProgressHUD hideHUDForView:self.view animated:YES];
                        NSDictionary* dc = result;
                        // NSLog(@"%@",result.description);
                        
                        //  for (NSDictionary* dc in result){
                        NSLog(@"%@", dc.description);
                    }
                    
                };

                [WebRequests sendOrder:[DataContainer getOrderedDrinks] withBlock:getDrinkBlock andbID:beacon.proximityUUID.UUIDString];
                if(self.homeBlock != nil){
                    
                }
                
                //beacon uit
                [self.locationManager stopMonitoringForRegion:self.beaconRegion];
                [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
                NSLog(@"Disabled ranging.");
                ViewGeldAnimatie *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"moneyAnimation"];
                secondViewController.homeBlock = ^void(){[self dismissViewControllerAnimated:NO completion:self.homeBlock];};
                [self presentModalViewController:secondViewController animated:YES];
                //[self performSegueWithIdentifier:@"paymentSegue" sender:self];
            }
        }
    }
    //self.detectedBeacons = beacons;
}

#pragma mark - Peripheral Manager
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    //(CBPeripheralManager *)peripheral;
}

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
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:10.0/255.0 green:115.0/225.0 blue:225.0/225.0 alpha:1.0]];
    
    // zet alle plaatjes in array (.GIF idee)
    
    AnimatedPicture.animationImages = [NSArray arrayWithObjects:
                                       [UIImage imageNamed:@"animatieB1.png"],
                                       [UIImage imageNamed:@"animatieB2.png"],
                                       [UIImage imageNamed:@"animatieB3.png"],
                                       [UIImage imageNamed:@"animatieB4.png"],
                                       [UIImage imageNamed:@"animatieB5.png"],
                                       [UIImage imageNamed:@"animatieB6.png"], nil
                                       ];
    
    
    // blijven repeaten:
    [AnimatedPicture setAnimationRepeatCount:0];
    //snelheid
    AnimatedPicture.animationDuration = 1;
    // en starten natuurlijk
    [AnimatedPicture startAnimating];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAnnuleren:(id)sender {
    //beacon uit
    [self.locationManager stopMonitoringForRegion:self.beaconRegion];
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    NSLog(@"Disabled ranging.");
}

- (IBAction)btnHome:(id)sender {
    ViewController *viewController = [[ViewController alloc] init];
    ViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeView"];
    [self presentModalViewController:secondViewController animated:YES];
}

@end
