//
//  JsonHandler.m
//  SMPT
//
//  Created by tester on 5/29/14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "WebRequests.h"
#import "AFNetworking.h"
#import "DataContainer.h"
#import "Drink.h"
#pragma clang diagnostic ignored "-Wobjc-root-class"


@implementation WebRequests

#define BASE_URL @"Http://heelveelmeerstuk.nl/"
NSString * const NotificationString = BASE_URL @"getnotifications.php";
NSString * const getUserData = BASE_URL @"userdata.php";
NSString * const sendOrder = BASE_URL @"sendorder.php";

+(void) makeHTTPPostRequest:(NSDictionary*) params url:(NSString*) url withBlock:(void (^)(Boolean, id, NSError*))block{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:  [NSURL URLWithString:url ]];  
   manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",[responseObject class]);
       // NSLog(@"Request Successful, response '%@'", responseStr);
       // block(true,responseStr,nil);
        block(true, responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    }
+(void) getNotifications:(void (^)(Boolean, id, NSError*))block {

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"key", @"apikey",
                            @"lastid", @"laatstbekendheid",
                            nil];
    [WebRequests makeHTTPPostRequest:params url:NotificationString withBlock:block];
}
+(void) getUserData:(NSInteger) userId withBlock:	(void (^)(Boolean, id,NSError*)) block{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"id", [[NSNumber alloc] initWithInteger:userId],
                             @"key", @"apikey",
                            nil];
    [WebRequests makeHTTPPostRequest:params url:getUserData withBlock:block];
}
+(void) sendOrder:(NSMutableArray*) orderId withBlock:	(void (^)(Boolean, id,NSError*)) block{
    NSInteger userId = [[DataContainer getCurrentUser]getId ];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            @"id", [[NSNumber alloc] initWithInteger:userId],
                            nil];
    for(Drink* d in orderId){
        [params addEntriesFromDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"id",d.id, @"amount",d.amount, nil]
         ];
    }
    [WebRequests makeHTTPPostRequest:params url:sendOrder withBlock:block];

}

@end
