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
            if(beacon.accuracy < 0.05)
            {
                NSLog(@"verstuur");
                [WebRequests sendOrder:[DataContainer getOrderedDrinks] withBlock:nil];
                
                
                //beacon uit
                [self.locationManager stopMonitoringForRegion:self.beaconRegion];
                [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
                NSLog(@"Disabled ranging.");
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

- (IBAction)btnHome:(id)sender {
    ViewController *viewController = [[ViewController alloc] init];
    ViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeView"];
    [self presentModalViewController:secondViewController animated:YES];
}
@end
