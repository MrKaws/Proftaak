//
//  DrinksCategory.m
//  SMPT
//
//  Created by Anh Tran on 12-06-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "DrinksCategory.h"

@implementation DrinksCategory

-(id)initWithName:(NSString *)name andID:(NSInteger)id{
    self = [super init] ; // or another one ; here you should use the designated init. of the parent class
    
    if (self){
        self.categoryID = id;
        self.categoryName = name;
    }
    
    return self;}
@end
