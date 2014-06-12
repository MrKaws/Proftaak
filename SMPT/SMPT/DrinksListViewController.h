//
//  DrinksListViewController.h
//  SMPT
//
//  Created by Anh Tran on 28-05-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drink.h"

@interface DrinksListViewController : UITableViewController
@property NSArray *drinksID;
@property NSArray *drinksName;
@property NSArray *drinksPrice;
@property NSNumber *totalPrice;
@property NSInteger drinksAmount;
@property NSArray* categories;
@property NSArray* drinks;
-(Drink*) getDrinkFromTable:(NSIndexPath *)indexPath;
@end
