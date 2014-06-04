//
//  Order.m
//  SMPT
//
//  Created by Anh Tran on 04-06-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "Drink.h"

@implementation Drink

//-(NSString*)getName{
//    return self.name;
//}

-(NSInteger)getAmount{
    return self.amount;
}

-(NSInteger)getId{
    return self.id;
}
//
//-(void)setName:(NSString *)name{
//    self.name = name;
//}

-(void)setAmount:(NSInteger)amount{
    self.amount = amount;
}

-(void)setId:(NSInteger)id{
    self.id = id;
}
@end
