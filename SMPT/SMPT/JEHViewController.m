//
//  JEHViewController.m
//  MyBeacon
//
//  Created by Justin Hyland on 2/4/14.
//  Copyright (c) 2014 Justin Hyland. All rights reserved.
//

#import "JEHViewController.h"
#import "AFNetworking.h"

static NSString * const kProximityUUID = @"7AF66857-FF47-4225-AC7C";
static NSString * const kRegionLookupIdentifier = @"MyBeaconIdentifier";

@interface JEHViewController ()
    @property (nonatomic, strong) CLLocationManager *locationManager;
    @property (nonatomic, strong) CLBeaconRegion *beaconRegion;
    @property (nonatomic, strong) CBPeripheralManager *peripheralManager;
    @property (nonatomic, strong) NSArray *detectedBeacons;
    @property (nonatomic, strong) NSMutableArray *detectedRegionInfos;
    @property int sgSelectedIndex;
    @property BOOL orderVerstuurd;
@end


@implementation JEHViewController

//@synthesize orderVerstuurd;
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        [self initLocationManager];
        [self initBeaconRegion];
        [self initPeripheralMgr];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
	// Do any additional setup after loading the view, typically from a nib.
    self.orderVerstuurd = true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)orderButtonClick:(id)sender {
    self.orderVerstuurd = false;
}


- (IBAction)sgbtnBeaconType_Clicked:(id)sender {
    UISegmentedControl *ctrl = (UISegmentedControl*)sender;
    
    self.sgSelectedIndex = ctrl.selectedSegmentIndex;
    [self iBeaconRangingIsEnabled:NO];
    [self iBeaconMonitoringIsEnabled:NO];
    [self iBeaconAdvertisingIsEnabled:NO];
    
    switch (ctrl.selectedSegmentIndex) {
        case 1:
            [self iBeaconRangingIsEnabled:YES];
            break;
        case 2:
            [self iBeaconAdvertisingIsEnabled:YES];
            break;
        case 3:
            if([self isDeviceConfiguredForBeaconMonitoring])
                [self iBeaconMonitoringIsEnabled:YES];
            else{
                [[[UIAlertView alloc] initWithTitle:@"Monitoring" message:@"This device's settings explicity restricts Background App Refresh.  Enable 'Background App Refresh' in your device's General Settings to use Monitoring." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                [ctrl setSelectedSegmentIndex:0];
            }
        default:
            //Clear tableview data...
            [self.mainTblView reloadData];
            break;
    }
}
-(void)iBeaconRangingIsEnabled:(BOOL)isEnabled
{
    self.detectedBeacons = [NSArray array];
    if(isEnabled)
    {
        NSLog(@"Enabling ranging...");
        
        if (![CLLocationManager isRangingAvailable]) {
            NSLog(@"Warning: Ranging is not Available...");
            return;
        }
        
        if (self.locationManager.rangedRegions.count > 0) {
            return;
        }
        self.lblSearchDesc.text = @"Searching for Beacons...";
        [self.aiSearching setHidden:NO];
        
        [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
    }
    else
    {
        self.lblSearchDesc.text = @"";
        [self.aiSearching setHidden:YES];
        [self.locationManager stopMonitoringForRegion:self.beaconRegion];
        
        
        if (self.locationManager.rangedRegions.count == 0) {
            return;
        }
        
        [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
        
        
        [self.mainTblView reloadData];
        NSLog(@"Disabled ranging.");
    }
}
-(void)iBeaconMonitoringIsEnabled:(BOOL)isEnabled
{
    self.detectedRegionInfos = [NSMutableArray array];
    if(isEnabled)
    {
        
        if (![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
            NSLog(@"Warning unable to start monitoring due to deivce not supporting CLBeaconRegion class.");
            return;
        }
        self.lblSearchDesc.text = @"Monitoring for Beacons...";
        [self.aiSearching setHidden:NO];
        [self.locationManager startMonitoringForRegion:self.beaconRegion];
        NSLog(@"Monitoring started..");
    }
    else
    {
        self.lblSearchDesc.text = @"";
        [self.aiSearching setHidden:YES];
        [self.locationManager stopMonitoringForRegion:self.beaconRegion];
        NSLog(@"Disabled monitoring");
    }
}
-(void)iBeaconAdvertisingIsEnabled:(BOOL)isEnabled
{
    if(isEnabled)
    {
        time_t t;
        srand((unsigned) time(&t));
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:self.beaconRegion.proximityUUID
                                                                         major:1
                                                                         minor:0
                                                                    identifier:self.beaconRegion.identifier];
        NSDictionary *beaconPeripheralData = [region peripheralDataWithMeasuredPower:nil];
        self.lblSearchDesc.text = @"Advertising as an iBeacon...";
        [self.aiSearching setHidden:NO];
        [self.peripheralManager startAdvertising:beaconPeripheralData];
        
        NSLog(@"Advertising Started....");
    }
    else
    {
        [self.peripheralManager stopAdvertising];
        self.lblSearchDesc.text = @"";
        [self.aiSearching setHidden:YES];
        NSLog(@"Turned off advertising.");
    }

}
#pragma mark - Location manager delegate methods
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"Couldn't turn on ranging: Location services are not enabled.");
    }
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized) {
        NSLog(@"Couldn't turn on monitoring: Location services not authorised.");
    }
}
- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region {
    
    if (beacons.count == 0) {
        NSLog(@"No beacons found.");
    } else {
        NSLog(@"Located %lu beacon(s).", (unsigned long)[beacons count]);
    }
    self.detectedBeacons = beacons;
    [self.mainTblView reloadData];
    
    
}
- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"monitoringDidFailForRegion - error: %@", [error localizedDescription]);
}
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    JEHRegionInfo *info = [[JEHRegionInfo alloc] init];
    info.region = (CLBeaconRegion*)region;
    info.RegionDescription = @"Entered Region";
    [self.detectedRegionInfos addObject:info];
    
    [self.mainTblView reloadData];
    NSLog(@"didEnterRegion: %@", region);
    
    //[self sendLocalNotificationForBeaconRegion:(CLBeaconRegion *)region];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    JEHRegionInfo *info = [[JEHRegionInfo alloc] init];
    info.region = (CLBeaconRegion*)region;
    info.RegionDescription = @"Exited Region";
    [self.detectedRegionInfos addObject:info];
    
    [self.mainTblView reloadData];
    NSLog(@"Region Exited: %@", region);
}
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    NSString *stateString = nil;
    switch (state) {
        case CLRegionStateInside:
            stateString = @"inside";
            break;
        case CLRegionStateOutside:
            stateString = @"outside";
            break;
        case CLRegionStateUnknown:
            stateString = @"unknown";
            break;
    }
    
//    JEHRegionInfo *info = [[JEHRegionInfo alloc] init];
//    info.region = (CLBeaconRegion*)region;
//    info.RegionDescription = [[NSString alloc] initWithFormat:@"State Changed %@", stateString];
//    [self.detectedRegionInfos addObject:info];
//    
//    [self.mainTblView reloadData];
    NSLog(@"State changed to %@ for region %@.", stateString, region);
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.sgSelectedIndex == 1)
    {
        if(self.detectedBeacons.count == 0)
            return 1;
        else
            return self.detectedBeacons.count;
    }
    else if(self.sgSelectedIndex == 3)
    {
        if(self.detectedRegionInfos.count == 0)
            return 1;
        else
            return self.detectedRegionInfos.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"RangingCell"];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"RangingCell"];
    
    if(self.sgSelectedIndex == 1)
    {
        if(self.detectedBeacons.count > 0)
        {
            CLBeacon *beacon = self.detectedBeacons[indexPath.row];
            cell.textLabel.text = beacon.proximityUUID.UUIDString;
            NSString * booleanString = (self.orderVerstuurd) ? @"Verstuurd" : @"Niet Verstuurd";
            if(beacon.accuracy <= 0.05 && beacon.accuracy >= 0)
            {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%.5f - %@ - order versturen", beacon.accuracy, booleanString];
                cell.backgroundColor = [UIColor greenColor];
                
                if(!self.orderVerstuurd)
                {
                    //parameters in url zetten
                    NSString * requestURL = [[NSString stringWithFormat:@"http://iris.da-syntax.nl/writetodb.php?bid=%@&order=%@", beacon.proximityUUID.UUIDString,self.orderInput.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
                    //request doen
                    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                    
                    manager.responseSerializer .acceptableContentTypes = [manager.responseSerializer .acceptableContentTypes setByAddingObject:@"application/x-javascript"];
                    
                    [manager GET:requestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        
                        //This code is executed when the result was ok.
                        NSLog(@"JSON: %@", responseObject);
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        
                        
                        //This code is executed when there was an error.
                        NSLog(@"Error: %@", error);
                        
                    }];
                    //melding geven
                    NSString * orderText = self.orderInput.text;
                    
                    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"uw order is verstuurd:" message:orderText delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
                    [alertView show];
                    self.orderVerstuurd = true;
                }
            }
            else
            {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%.5f - %@ - niet in range", beacon.accuracy, booleanString];
                cell.backgroundColor = [UIColor redColor];
            }
            //cell.detailTextLabel.text = @"test";
            cell.detailTextLabel.textColor = [UIColor grayColor];
            
        }
        else
        {
            cell.textLabel.text = @"No beacons in range.";
            cell.detailTextLabel.text = @"";
            cell.backgroundColor = [UIColor clearColor];
        }
    }
    else if(self.sgSelectedIndex == 3)
    {
        
        if(self.detectedRegionInfos.count > 0)
        {
            JEHRegionInfo *info = (JEHRegionInfo*)self.detectedRegionInfos[indexPath.row];
            cell.textLabel.text = info.RegionDescription;
            cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@ | %@ | %@", info.region.proximityUUID.UUIDString, info.region.major, info.region.minor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.backgroundColor = [UIColor clearColor];
        }
        else
        {
            cell.textLabel.text = @"No beacons within range.";
            cell.detailTextLabel.text = @"";
            cell.backgroundColor = [UIColor clearColor];
        }

    }
    else
    {
        cell.textLabel.text = @"No information available.";
        cell.detailTextLabel.text = @"";
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}
// detailsStringForBeacon  Copyright (c) 2013-2014 Nick Toumpelis.
- (NSString *)detailsStringForBeacon:(CLBeacon *)beacon
{
    NSString *proximity;
    switch (beacon.proximity) {
        case CLProximityNear:
            proximity = @"Near";
            break;
        case CLProximityImmediate:
            proximity = @"Immediate";
            break;
        case CLProximityFar:
            proximity = @"Far";
            break;
        case CLProximityUnknown:
        default:
            proximity = @"Unknown";
            break;
    }
    
    NSString *format = @"%@, %@ • %@ • %f • %li";
    return [NSString stringWithFormat:format, beacon.major, beacon.minor, proximity, beacon.accuracy, beacon.rssi];
}
-(UIColor*)getColorViaProximityForBeacon:(CLBeacon *)beacon
{
    switch (beacon.proximity) {
        case CLProximityImmediate:
            return [UIColor greenColor];
        case CLProximityNear:
            return [UIColor yellowColor];
        case CLProximityFar:
            return [UIColor redColor];
        case CLProximityUnknown:
            return [UIColor lightGrayColor];
        default:
            return [UIColor lightGrayColor];
    }
}
#pragma mark - Peripheral Manager
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    
}

#pragma mark - Init

- (void)initLocationManager
{
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;

    }
}
-(void)setupTableView
{
    self.detectedBeacons = [[NSArray alloc] init];
    [self.mainTblView setDelegate:self];
    [self.mainTblView setDataSource:self];
}
-(void)initBeaconRegion
{
    
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:kProximityUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID major:1 minor:0 identifier:kRegionLookupIdentifier];
    self.beaconRegion.notifyEntryStateOnDisplay = NO;
    self.beaconRegion.notifyOnEntry = YES;
    self.beaconRegion.notifyOnExit = YES;
}
-(void)initPeripheralMgr
{
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
}
-(void)initAvailableServices
{
}
-(BOOL)isDeviceConfiguredForBeaconMonitoring
{
    if ([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusAvailable) {
        return YES;

    }else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied)
    {
        NSLog(@"The user explicitly disabled background behavior for this app or for the whole system.");
        return NO;
    }else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted)
    {
        NSLog(@"Background updates are unavailable and the user cannot enable them again. For example, this status can occur when parental controls are in effect for the current user.");
        return NO;
    }
    return NO;
}

@end
