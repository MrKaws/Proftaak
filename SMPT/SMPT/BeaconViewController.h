//
//  BeaconViewController.h
//  SMPT
//
//  Created by Anh Tran on 06-06-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;
@import CoreBluetooth;


@interface BeaconViewController : UIViewController<
    CLLocationManagerDelegate,
    CBPeripheralManagerDelegate>
{
  IBOutlet UIImageView *AnimatedPicture;
}
- (IBAction)btnHome:(id)sender;
@end
