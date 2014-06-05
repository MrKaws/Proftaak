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
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = requestSerializer;
  // [[manager requestSerializer]set ]
    //AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:  [NSURL URLWithString:url ]];  
  //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
   // manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",[responseObject class]);
       // NSLog(@"Request Successful, response '%@'", responseStr);
       // block(true,responseStr,nil);
        NSLog(@"%@",operation.request);
        NSLog(@"%@",[[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
        block(true, responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",operation.responseString);
        NSLog(@"%@",operation.responseObject);
        NSLog(@"Error: %@", error);
    }];
    
    }
+(void) getNotifications:(void (^)(Boolean, id, NSError*))block {

    NSDictionary *params = @{@"lastid":	@"laatstbekendheid"};
    [WebRequests makeHTTPPostRequest:params url:NotificationString withBlock:block];
}
+(void) getUserData:(NSInteger) userId withBlock:	(void (^)(Boolean, id,NSError*)) block{
    NSDictionary *params = @{@"uid":[@(userId)stringValue]};
                            /*[NSDictionary dictionaryWithObjectsAndKeys:
                             @"id", [[NSNumber alloc] initWithInteger:userId],
                             @"key", @"apikey",
                            nil];*/
    [WebRequests makeHTTPPostRequest:params url:getUserData withBlock:block];
}
+(void) sendOrder:(NSMutableArray*) orderId withBlock:	(void (^)(Boolean, id,NSError*)) block{
    NSInteger userId = [[DataContainer getCurrentUser]getId ];
    //userId = 1;
   // NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //[params addEntriesFromDictionary:@{@"uid": [NSNumber numberWithInteger:userId]}];
    NSMutableArray* paramArray = [[NSMutableArray alloc]init];
    for(Drink* d in orderId){
        [paramArray addObject:[d dictionaryWithIDandAmount]];
    }
    //NSError* error = nil;
    //NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:paramArray options:NSJSONWritingPrettyPrinted error:&error];
    //NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    NSDictionary* params = @{@"uid":[@(userId)stringValue], @"drinks":paramArray};

    [WebRequests makeHTTPPostRequest:params url:sendOrder withBlock:block];

}

@end
