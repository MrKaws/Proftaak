//
//  ViewController.m
//  SMPT
//
//  Created by Anh Tran on 28-05-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "ViewController.h"
#import "WebRequests.h"
#import "User.h"
#import "DataContainer.h"
#import "Drink.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:73.0/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:73.0/255.0 alpha:1.0]];
 [self.navigationController.navigationBar setTranslucent:NO];
    self.view.backgroundColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:73.0/255.0 alpha:1.0];
    self.view.tintColor =[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:73.0/255.0 alpha:1.0];
   	 [self getUserData];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    // self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:72.0/255 green:72.0/255 blue:73.0/255 alpha:1.0];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getUserData{
    void (^getUserBlock)(Boolean, id, NSError*)  =
    ^(Boolean success,id result, NSError* error){
        if(success)
        {
            NSLog(@"%@",[result class]);
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
         NSDictionary* dc = result;
           // NSLog(@"%@",result.description);
            
          //  for (NSDictionary* dc in result){
                NSLog(@"%@", dc.description);
                User* u = [User alloc];
                u.id = [[dc objectForKey:@"id"]integerValue];
                u.first_name = [dc objectForKey:@"voornaam"];
                u.last_name = [dc objectForKey:@"achternaam"];
                u.saldo = [[dc objectForKey:@"saldo"]decimalValue];
                NSLog(@"%@",u.first_name);
            [DataContainer setCurrentUser:u];
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            [formatter setCurrencyCode:@"EUR"];
            [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"nl_NL" ]];
            [self.lbSaldo setText:[NSString stringWithFormat:@"Huidig saldo: %@",[formatter stringFromNumber: [NSDecimalNumber decimalNumberWithDecimal:u.saldo]]]];
                
                
            }
        
    };

    [WebRequests getUserData:1 withBlock:getUserBlock];
}

-(void)getDrink
{
void (^getDrinkBlock)(Boolean, id, NSError*)  =
    ^(Boolean success,id result, NSError* error){
        if(success)
        {
            NSLog(@"%@",[result class]);
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            NSDictionary* dc = result;
            // NSLog(@"%@",result.description);
            
            //  for (NSDictionary* dc in result){
            NSLog(@"%@", dc.description);
        }
        
    };
    NSMutableArray *array = [DataContainer getOrderedDrinks];
    [WebRequests sendOrder:array withBlock:getDrinkBlock];
}

@end
