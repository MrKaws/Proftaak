		//
//  NotificationViewController.m
//  SMPT
//
//  Created by tester on 5/29/14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "NotificationViewController.h"
#import "WebRequests.h"
#import "NotificationItem.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    void (^notificationBlock)(Boolean, id, NSError*)  =
    ^(Boolean success,id result, NSError* error){
        if(success)
        {
            NSMutableString* notificationString = [[NSMutableString alloc]init];
       
            NSMutableArray* notifications = [[NSMutableArray alloc]init];
            for (NSDictionary* dc in result){
                NSLog(@"%@", dc.description);
                NotificationItem* n = [NotificationItem alloc];
                n.notificationID = [[dc objectForKey:@"type"]integerValue];
                n.title = [dc objectForKey:@"titel"];
                n.content = [dc objectForKey:@"content"];
                NSLog(@"%@",n.content);
                [notifications  addObject:n];
                [notificationString appendString:[NSString stringWithFormat:@"- %@\n\n",n.content]];
                 }
            [self.tvNotifications setText:notificationString];
            
            
        }
        
        else{
            // tijdelijke error
           // [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                            message:@"You must be connected to the internet to use this app."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
    };
    [WebRequests getNotifications :notificationBlock	];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
