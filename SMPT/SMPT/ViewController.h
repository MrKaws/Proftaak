//
//  ViewController.h
//  SMPT
//
//  Created by Anh Tran on 28-05-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbSaldo;
-(void) getUserData;
-(void) getDrink;
@end
