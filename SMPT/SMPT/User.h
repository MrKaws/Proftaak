//
//  User.h
//  SMPT
//
//  Created by tester on 5/30/14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property NSInteger id;
@property NSString* first_name;
@property NSString* last_name;
@property NSInteger saldo;
-(NSInteger) getId;

@end
