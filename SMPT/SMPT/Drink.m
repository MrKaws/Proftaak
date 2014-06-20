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
-(id)initWithName:(NSString *)name categoryID:(NSInteger)catId price:(NSNumber*) price andID:(NSInteger)id withImage:(NSString*) image ofType:(NSString*) imageType{
    self = [super init] ; // or another one ; here you should use the designated init. of the parent class
    
    if (self){
        self.categoryID = catId;
        self.name = name;
        self.id = id;
        self.price =price;
        self.imagePath = image;
        self.imageType = imageType;
    }
    
    return self;}

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
    return [NSString stringWithFormat:@"%i:%i", self.id, self.amount];}

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
