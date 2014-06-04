//
//  ViewController.m
//  SMPT
//
//  Created by Anh Tran on 28-05-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "ViewController.h"
#import "WebRequests.h"
#import "User.h"
#import "DataContainer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getUserData];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getUserData{
    void (^getUserBlock)(Boolean, id, NSError*)  =
    ^(Boolean success,id result, NSError* error){
        if(success)
        {
            NSLog(@"%@",[result class]);
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
         NSDictionary* dc = result;
           // NSLog(@"%@",result.description);
            
          //  for (NSDictionary* dc in result){
                NSLog(@"%@", dc.description);
                User* u = [User alloc];
                u.id = [[dc objectForKey:@"id"]integerValue];
                u.first_name = [dc objectForKey:@"voornaam"];
                u.last_name = [dc objectForKey:@"achternaam"];
                u.saldo = [[dc objectForKey:@"saldo"]integerValue];
                NSLog(@"%@",u.first_name);
            [DataContainer setCurrentUser:u];
                
                
            }
        
    };

    [WebRequests getUserData:1 withBlock:getUserBlock];
}
@end
