//
//  DataContainer.m
//  SMPT
//
//  Created by tester on 6/1/14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "DataContainer.h"

@implementation DataContainer

static User* currentUser;
static NSMutableArray* orderedDrinks;
+(void)setCurrentUser:(User*) user{
    currentUser = user;
    
}
+(User*)getCurrentUser{
    return currentUser;
}
+(void) setOrderedDrinks: (NSMutableArray*) drinks
{
    orderedDrinks = drinks;
}
+(NSMutableArray*)getOrderedDrinks {
   // static NSMutableArray *statArray;
    //static dispatch_once_t onceToken;
    //dispatch_once(&onceToken, ^{
    //    statArray = [NSMutableArray array];
    //});
   // return statArray;
    return orderedDrinks;
}
@end
