//
//  CurrentDrinksViewController.h
//  SMPT
//
//  Created by Anh Tran on 29-05-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentDrinksViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lblDrinksPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;
@property (strong, nonatomic) NSArray *drinksModal;
@property (strong, nonatomic) IBOutlet UITextField *tbAmount;
- (IBAction)btnAddDrinks:(id)sender;
@property UIAlertView *alert;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property UITextField* activeField;

- (void)registerForKeyboardNotifications;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (void)keyboardWillShow:(NSNotification*)aNotification;
- (void)keyboardWillBeHidden:(NSNotification*)aNotification;


@end
