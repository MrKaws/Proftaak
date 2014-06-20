//
//  TableCell.h
//  SMPT
//
//  Created by Anh Tran on 28-05-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblDrinksName;
@property (strong, nonatomic) IBOutlet UILabel *lblDrinksPrice;
//@property (strong, nonatomic) IBOutlet UILabel *lblDrinksAmount;
@end
