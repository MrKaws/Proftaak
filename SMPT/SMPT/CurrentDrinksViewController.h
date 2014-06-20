//
//  CurrentDrinksViewController.h
//  SMPT
//
//  Created by Anh Tran on 29-05-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentDrinksViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *ivDrink;

@property (strong, nonatomic) IBOutlet UILabel *lblDrinksPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;
@property (strong, nonatomic) NSArray *drinksModal;
- (IBAction)btnAddDrinks:(id)sender;
@property UIAlertView *alert;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property UITextField* activeField;
@property (strong, nonatomic) IBOutlet UILabel *lblDrinksAmount;
- (IBAction)btnPlusOne:(id)sender;
- (IBAction)btnMinusOne:(id)sender;

- (void)registerForKeyboardNotifications;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (void)keyboardWillShow:(NSNotification*)aNotification;
- (void)keyboardWillBeHidden:(NSNotification*)aNotification;


@end
