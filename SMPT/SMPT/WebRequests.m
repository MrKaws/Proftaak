//
//  JsonHandler.m
//  SMPT
//
//  Created by tester on 5/29/14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "WebRequests.h"
#import "AFNetworking.h"
#pragma clang diagnostic ignored "-Wobjc-root-class"


@implementation WebRequests

#define BASE_URL @"Http://heelveelmeerstuk.nl/"
NSString * const NotificationString = BASE_URL @"getnotifications.php";

+(void) makeHTTPPostRequest:(NSDictionary*) params url:(NSString*) url {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:  [NSURL URLWithString:url ]];
   manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject	) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Request Successful, response '%@'", responseStr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    }
+(NSArray*) getNotifications {

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"key", @"apikey",
                            @"lastid", @"laatstbekendheid",
                            nil];
    [WebRequests makeHTTPPostRequest:params url:NotificationString];
    return nil;
  
}
@end
