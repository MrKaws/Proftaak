//
//  DataContainer.h
//  SMPT
//
//  Created by tester on 6/1/14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma clang diagnostic ignored "-Wobjc-root-class"
#import "User.h"

@interface DataContainer : NSObject

+(void)setCurrentUser:(User*) user;
+(User*)getCurrentUser;
+(NSMutableArray*)getOrderedDrinks;
+(void) setOrderedDrinks:(NSMutableArray*) drinks;
@end
