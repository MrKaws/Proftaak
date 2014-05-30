//
//  CurrentDrinksViewController.m
//  SMPT
//
//  Created by Anh Tran on 29-05-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "CurrentDrinksViewController.h"
#import "DrinksListViewController.h"
@interface CurrentDrinksViewController ()

@end

@implementation CurrentDrinksViewController
@synthesize lblDrinksPrice;
@synthesize drinksModal;
@synthesize lblTotal;
@synthesize tbAmount;

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
    [lblDrinksPrice setText: [NSString stringWithFormat:@"%@", drinksModal[1]]];
    self.navigationItem.title = drinksModal[0];
    [tbAmount setText:[NSString stringWithFormat:@"%d", 1]];
    [lblTotal setText:[NSString stringWithFormat:@"%@", drinksModal[1]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAddDrinks:(id)sender {
    int amount = [[tbAmount text] intValue];
    double drinksPrice = [drinksModal[1] doubleValue];
    double totalprice = amount * drinksPrice;
    [lblTotal setText:[NSString stringWithFormat:@"%.2f", totalprice]];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Bevestiging"
                                                   message: @"uw bestelling is toegevoegd"
                                                  delegate: self
                                         cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil,nil];
    
    
    [alert show];
    DrinksListViewController *dvc = [[DrinksListViewController alloc]init];
    dvc.drinksName = drinksModal[0];
    dvc.drinksPrice = drinksModal[1];
    dvc.drinksAmount = [[tbAmount text]intValue];
    dvc.totalPrice = [NSNumber numberWithDouble:totalprice];
    [dvc.orderedDrinks addObject:dvc];
    
}
@end
