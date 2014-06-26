//
//  ViewGeldAnimatie.m
//  SMPT
//
//  Created by FHICT on 20/06/14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "ViewGeldAnimatie.h"

@interface ViewGeldAnimatie()
@end


@implementation ViewGeldAnimatie
@synthesize alert;
@synthesize timer;
@synthesize seconds;

- (void)viewDidLoad
{
    // verander de animatie strings met een b voor andere animatie: animatie1.jpg is geld animatieB1.png is ibeacon
    
    AnimatedPicture2.animationImages = [NSArray arrayWithObjects:
                                       [UIImage imageNamed:@"animatie11.png"],
                                       [UIImage imageNamed:@"animatie21.png"],
                                       [UIImage imageNamed:@"animatie31.png"],
                                       [UIImage imageNamed:@"animatie41.png"],
                                       [UIImage imageNamed:@"animatie51.png"],
                                       [UIImage imageNamed:@"animatie11.png"], nil
                                       ];
    
    
    // blijven repeaten:
    [AnimatedPicture2 setAnimationRepeatCount:0];
    //snelheid
    AnimatedPicture2.animationDuration = 1;
    [AnimatedPicture2 startAnimating];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void) viewDidAppear:(BOOL)animated{
    if(self.homeBlock !=nil){
        timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                 target:self
                                               selector:@selector(countDown)
                                               userInfo:nil
                                                repeats:YES];
        seconds = 4;
           }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)countDown {
    if (--seconds == 2) {
        alert = [[UIAlertView alloc] initWithTitle:@"Melding"
                                           message:@"Uw bestelling is doorgevoerd"
                                          delegate:self
                                 cancelButtonTitle:nil
                                 otherButtonTitles:nil, nil];
            
        [alert show];
        
            }
    if(--seconds == 0){
        [timer invalidate];
        
        //[NSTimer scheduledTimerWithTimeInterval:1.4 target:self selector:@selector(closeAlert) userInfo:nil repeats:NO];
        [self closeAlert];
    }
}

-(void)closeAlert {
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

@end
