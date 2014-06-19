//
//  CurrentOrderViewController.m
//  SMPT
//
//  Created by Anh Tran on 28-05-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "CurrentOrderViewController.h"
#import "DataContainer.h"
#import "Drink.h"
#import "ViewController.h"
#import "Drink.h"

@interface CurrentOrderViewController ()

@end

@implementation CurrentOrderViewController
//@synthesize lblShowOrder;
@synthesize lblItems;
@synthesize lblTotalPrice;
@synthesize orders;
@synthesize noOrderAlert;

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
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:73.0/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.view.backgroundColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:73.0/255.0 alpha:1.0];
    self.view.tintColor =[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:73.0/255.0 alpha:1.0];    [self.tvOrders setEditable:false];
     self.view.backgroundColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:73.0/255.0 alpha:1.0];
    self.view.tintColor =[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:73.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};

    NSLog(@"%@", self.view.backgroundColor);
    NSMutableArray *array = [DataContainer getOrderedDrinks];
    orders = array;
    NSString *temp = @"";
    NSString *items = @"";
    NSLog(@"array size %i",[array count]);
    if([array count] == 0){
        temp = @"Er zijn nog geen bestellingen";
        [self.tvOrders setText:temp];
    }
    items = [NSString stringWithFormat:@"%@\t\t\t%@\t\t\t%@", @"Naam", @"Aantal", @"Bedrag"];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencyCode:@"EUR"];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"nl_NL" ]];
   
    for(int i = 0; i < [array count]; i ++){
        Drink* d = (Drink*)[array objectAtIndex:i];
        double totalPrice = [d.totalPrice doubleValue];
       // NSLog(@"name %@ amount %i",d.name,d.amount);
        temp = [NSString stringWithFormat:@"%@%@\t\t\t%i\t\t\t\t%@\n", temp, d.name, d.amount,[formatter stringFromNumber: @(totalPrice)]];
       // temp = [NSString stringWithFormat:@"%@", [array objectAtIndex:i]];
    }
    [self.tvOrders setText:temp];
    [lblItems setText:items];
    double value = 0;
    for(Drink *d in array){
        value =  value + [d.totalPrice doubleValue];
    }
    
    [lblTotalPrice setText:[NSString stringWithFormat:@"%@\t\t\t\t\t\t\t%@", @"Totaal: ", [formatter stringFromNumber:@(value)]]];
    [lblTotalPrice setNumberOfLines:0];
    [lblTotalPrice sizeToFit];
    //[self.tvOrders setEditable:false];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnOrder:(id)sender {
    if ([orders count] > 0) {
        ViewController *vc = [[ViewController alloc]init];
        [vc getDrink];
        ViewController *viewController = [[ViewController alloc] init];
        ViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BeaconView"];
        [self presentModalViewController:secondViewController animated:YES];
        
    }
    
    else{
        noOrderAlert = [[UIAlertView alloc] initWithTitle:@"Melding"
                                                  message:@"Er zijn nog geen drankjes toegevoegd"
                                                 delegate:self
                                        cancelButtonTitle:nil
                                        otherButtonTitles:nil, nil];
        [noOrderAlert show];
        [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(closeAlert) userInfo:nil repeats:NO];
    }
}

- (IBAction)btnRemoveOrder:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Melding"
                                                    message:@"Alle drankjes verwijderen?"
                                                   delegate:self
                                          cancelButtonTitle:@"Nee"
                                          otherButtonTitles:@"Ja", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex]) {

        //replace appname with any specific name you want
        [orders removeAllObjects];
        [self.tvOrders setText:@"Er zijn nog geen bestellingen"];
        [self.lblTotalPrice setText:@""];
    }
}

-(void)closeAlert {
    [noOrderAlert dismissWithClickedButtonIndex:0 animated:YES];
}
@end
