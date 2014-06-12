//
//  BeaconViewController.m
//  SMPT
//
//  Created by Anh Tran on 06-06-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "BeaconViewController.h"
#import "ViewController.h"

@interface BeaconViewController ()

@end

@implementation BeaconViewController

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
