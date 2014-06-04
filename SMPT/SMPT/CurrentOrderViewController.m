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

@interface CurrentOrderViewController ()

@end

@implementation CurrentOrderViewController
@synthesize lblShowOrder;

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
    NSLog(@"array size %i",[array count]);
    
    for(int i = 0; i < [array count]; i ++){
        Drink* d = (Drink*)[array objectAtIndex:i];
        NSLog(@"name %@ amount %i",d.name,d.amount);
        temp = [NSString stringWithFormat:@"%@%@\t%i\n", temp, d.name, d.amount];
       // temp = [NSString stringWithFormat:@"%@", [array objectAtIndex:i]];
    }
    [lblShowOrder setText:temp];
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
@end
