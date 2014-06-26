//
//  ViewGeldAnimatie.h
//  SMPT
//
//  Created by FHICT on 20/06/14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewGeldAnimatie : UIViewController
{
    IBOutlet UIImageView *AnimatedPicture2;
}
@property (nonatomic, copy) void (^homeBlock)();
@property UIAlertView *alert;
@property NSTimer *timer;
@property int seconds;

@end
