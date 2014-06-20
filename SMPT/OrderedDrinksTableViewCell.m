//
//  OrderedDrinksTableViewCell.m
//  SMPT
//
//  Created by Anh Tran on 20-06-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "OrderedDrinksTableViewCell.h"

@implementation OrderedDrinksTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
