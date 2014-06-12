//
//  Order.h
//  SMPT
//
//  Created by Anh Tran on 04-06-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Drink : NSObject

@property NSString* name;
@property  NSInteger id;
@property  NSInteger amount;
@property NSNumber* price;
@property NSNumber *totalPrice;
@property NSInteger categoryID;
-(id)initWithName:(NSString *)name categoryID:(NSInteger)id andID:(NSInteger)id;
//-(NSDictionary*)dictionaryWithIDandAmount;
-(NSString*)dictionaryWithIDandAmount;
/*-(NSString*)getName;
-(NSInteger)getId;
-(NSInteger)getAmount;

-(void)setName:(NSString*) name;
-(void)setId:(NSInteger) id;
-(void)setAmount:(NSInteger) amount;*/

@end
