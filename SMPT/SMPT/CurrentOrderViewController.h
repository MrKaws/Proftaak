//
//  CurrentOrderViewController.h
//  SMPT
//
//  Created by Anh Tran on 28-05-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *mijnSUPERtabel;
}
//@property (strong, nonatomic) IBOutlet UILabel *lblShowOrder;
- (IBAction)btnOrder:(id)sender;
- (IBAction)btnRemoveOrder:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblItems;
@property NSMutableArray *orders;
@property UIAlertView *noOrderAlert;


@end
