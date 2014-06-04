//
//  Order.h
//  SMPT
//
//  Created by Anh Tran on 04-06-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Drink : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic) NSInteger id;
@property (nonatomic) NSInteger amount;

-(NSString*)getName;
-(NSInteger)getId;
-(NSInteger)getAmount;

-(void)setName:(NSString*) name;
-(void)setId:(NSInteger) id;
-(void)setAmount:(NSInteger) amount;

@end
