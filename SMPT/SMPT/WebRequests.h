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
+(NSArray*) getNotifications;
+(void) makeHTTPPostRequest:(NSDictionary*) params url:(NSString*) url;
@end
