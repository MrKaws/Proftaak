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
@synthesize lblShowOrder;
@synthesize lblItems;
@synthesize lblTotalPrice;

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
    NSMutableArray *array = [DataContainer getOrderedDrinks];
    NSString *temp = @"";
    NSString *items = @"";
    NSLog(@"array size %i",[array count]);
    if([array count] == 0){
        temp = @"Er zijn nog geen bestellingen";
        [lblShowOrder setText:temp];
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
    [lblShowOrder setText:temp];
    [lblItems setText:items];
    double value = 0;
    for(Drink *d in array){
        value =  value + [d.totalPrice doubleValue];
    }
    
    [lblTotalPrice setText:[NSString stringWithFormat:@"%@\t\t\t\t\t\t\t%@", @"Totaal: ", [formatter stringFromNumber:@(value)]]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnOrder:(id)sender {
    ViewController *vc = [[ViewController alloc]init];
    [vc getDrink];
}

- (IBAction)btnRemoveOrder:(id)sender {
    NSMutableArray *array = [DataContainer getOrderedDrinks];
    [array removeAllObjects];
    if([array count] == 0)
    {
        [lblShowOrder setText:@"Er zijn nog geen bestellingen"];
        NSLog(@"array size: %i", [array count]);
    }
}

@end
