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

-(NSNumber*)getTotalPrice{
    return self.totalPrice;
}
/*-(NSDictionary*)dictionaryWithIDandAmount{
    return @{@"id":[NSNumber numberWithInteger:self.id], @"amount":[NSNumber numberWithInteger:self.amount]};
}*/
-(NSString*)dictionaryWithIDandAmount
{
    return [NSString stringWithFormat:@"{id:%i,amount:%i}", self.amount, self.amount];}

/*-(void)setName:(NSString *)name{
    name = name;
}

-(void)setAmount:(NSInteger)amount{
    amount = amount;
}
-(NSString*) getName{
    return self.name;
}

-(void)setId:(NSInteger)id{
    self.id = id;
}*/
@end
