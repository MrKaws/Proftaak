//
//  CurrentDrinksViewController.h
//  SMPT
//
//  Created by Anh Tran on 29-05-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentDrinksViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lblDrinksPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;
@property (strong, nonatomic) NSArray *drinksModal;
@property (strong, nonatomic) IBOutlet UITextField *tbAmount;
- (IBAction)btnAddDrinks:(id)sender;

@end
