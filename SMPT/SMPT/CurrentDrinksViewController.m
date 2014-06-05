//
//  CurrentDrinksViewController.m
//  SMPT
//
//  Created by Anh Tran on 29-05-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "CurrentDrinksViewController.h"
#import "DrinksListViewController.h"
#import "DataContainer.h"
#import "Drink.h"

@interface CurrentDrinksViewController ()

@end

@implementation CurrentDrinksViewController
@synthesize lblDrinksPrice;
@synthesize drinksModal;
@synthesize lblTotal;
@synthesize tbAmount;
@synthesize alert;

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
    NSLog(@"%@",[tbAmount text]);
    int amount = [[tbAmount text] intValue];
    double drinksPrice = [drinksModal[1] doubleValue];
    double totalprice = amount * drinksPrice;
    [lblTotal setText:[NSString stringWithFormat:@"%.2f", totalprice]];
    
      Drink *drink = [[Drink alloc]init];
    NSString* name = drinksModal[0];
    NSInteger drinksID = [drinksModal[2] integerValue];
    NSNumber *number = [NSNumber numberWithDouble:totalprice];
   // NSLog(@"drinksModal: %@",name);
    drink.name = name;
    drink.amount = amount;
    drink.id = drinksID;
    drink.totalPrice = number;
   //// NSLog(@"drink amoutn %i",drink.amount);
    NSLog(@"drinkName%@",drink.name);
    NSLog(@"drinkID%ld", (long)drink.id);
    
    NSMutableArray* existingDrinks = [DataContainer getOrderedDrinks];
   // NSLog(@"existingdrinks: %i",[existingDrinks count]);
    if (existingDrinks == nil) {
      //  NSLog(@"INITIALIZING DRINKS");
        existingDrinks = [[NSMutableArray alloc]init];
    }
    //NSMutableArray *saveDrink = [[NSMutableArray alloc]init];
    //[saveDrink addObject:dvc];
    [existingDrinks addObject:drink];
    [DataContainer setOrderedDrinks:existingDrinks];
   // [dvc.orderedDrinks addObject:dvc];
    alert = [[UIAlertView alloc]initWithTitle: @"Bevestiging"
                                      message: @"uw bestelling is toegevoegd"
                                     delegate: self
                            cancelButtonTitle:nil
                            otherButtonTitles:nil,nil];
    [alert show];
    [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(closeAlert) userInfo:nil repeats:NO];
    //[self dismissViewControllerAnimated:true completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)closeAlert {
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

@end
