//
//  JsonHandler.h
//  SMPT
//
//  Created by tester on 5/29/14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebRequests : NSObject

extern NSString * const NotificationString ;
+(void) getNotifications:(void (^)(Boolean, id, NSError*))block;
+(void) makeHTTPPostRequest:(NSDictionary*) params url:(NSString*) url withBlock: (void (^)(Boolean, id, NSError*))block;
@end
