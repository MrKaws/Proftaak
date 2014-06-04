//
//  CurrentOrderViewController.m
//  SMPT
//
//  Created by Anh Tran on 28-05-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "CurrentOrderViewController.h"
#import "DataContainer.h"

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
    NSString *temp;
    
    for(int i = 0; i < [array count]; i ++){
        
        temp = [NSString stringWithFormat:@"%@", [array objectAtIndex:i]];
    }
    [lblShowOrder setText:temp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
