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

+(void)setCurrentUser:(User*) user{
    currentUser = user;
    
}
+(User*)getCurrentUser{
    return currentUser;
}
@end
