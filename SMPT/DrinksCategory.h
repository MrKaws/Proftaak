//
//  DrinksCategory.h
//  SMPT
//
//  Created by Anh Tran on 12-06-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrinksCategory : NSObject
@property NSInteger categoryID;
@property NSString *categoryName;

-(id)initWithName:(NSString*)name andID:(NSInteger) id;

@end
