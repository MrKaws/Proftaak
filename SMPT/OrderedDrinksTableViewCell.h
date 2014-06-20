//
//  OrderedDrinksTableViewCell.h
//  SMPT
//
//  Created by Anh Tran on 20-06-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderedDrinksTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblDrinksName;
@property (strong, nonatomic) IBOutlet UILabel *lblDrinksAmount;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalPrice;

@end
