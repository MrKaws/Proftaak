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
        NSLog(@"%@",operation.responseObject);
        NSLog(@"Error: %@", error);
    }];
    
    }
+(void) getNotifications:(void (^)(Boolean, id, NSError*))block {

    NSDictionary *params = @{@"key": @"apikey",
                             @"lastid":	@"laatstbekendheid"};
    [WebRequests makeHTTPPostRequest:params url:NotificationString withBlock:block];
}
+(void) getUserData:(NSInteger) userId withBlock:	(void (^)(Boolean, id,NSError*)) block{
    NSDictionary *params = @{@"id":[NSNumber numberWithInteger:userId]};
                            /*[NSDictionary dictionaryWithObjectsAndKeys:
                             @"id", [[NSNumber alloc] initWithInteger:userId],
                             @"key", @"apikey",
                            nil];*/
    [WebRequests makeHTTPPostRequest:params url:getUserData withBlock:block];
}
+(void) sendOrder:(NSMutableArray*) orderId withBlock:	(void (^)(Boolean, id,NSError*)) block{
    NSInteger userId = [[DataContainer getCurrentUser]getId ];

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params addEntriesFromDictionary:@{@"id": [NSNumber numberWithInteger:userId],
                             @"orderid":orderId}];

    for(Drink* d in orderId){
        [params addEntriesFromDictionary:@{@"id":[NSNumber numberWithInteger:d.id], @"amount":[NSNumber numberWithInteger:d.amount]}];
    }

    [WebRequests makeHTTPPostRequest:params url:sendOrder withBlock:block];

}

@end
