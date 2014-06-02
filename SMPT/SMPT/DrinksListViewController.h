//
//  DrinksListViewController.h
//  SMPT
//
//  Created by Anh Tran on 28-05-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrinksListViewController : UITableViewController
@property NSArray *drinksID;
@property NSArray *drinksName;
@property NSArray *drinksPrice;
@property NSMutableArray *orderedDrinks;
@property NSNumber *totalPrice;
@property NSInteger drinksAmount;
@end
