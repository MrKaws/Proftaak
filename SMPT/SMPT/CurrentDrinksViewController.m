//
//  CurrentDrinksViewController.m
//  SMPT
//
//  Created by Anh Tran on 29-05-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "CurrentDrinksViewController.h"
#import "DrinksListViewController.h"
#import "DataContainer.h"
#import "Drink.h"

@interface CurrentDrinksViewController ()

@end

@implementation CurrentDrinksViewController
@synthesize lblDrinksPrice;
@synthesize drinksModal;
@synthesize lblTotal;
@synthesize alert;
@synthesize scrollView;
@synthesize activeField;
@synthesize lblDrinksAmount;
@synthesize drinksImage;
@synthesize barButtonText;

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
	// Do any additional setup after loading the view.

   [self.navigationController.navigationBar setTranslucent:NO];
    self.view.backgroundColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:73.0/255.0 alpha:1.0];
    [self registerForKeyboardNotifications];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};

    self.scrollView.scrollEnabled = YES;
    
        UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tapped)];
        tapScroll.cancelsTouchesInView = NO;
        [scrollView addGestureRecognizer:tapScroll];
    
    [self.view addGestureRecognizer:tapScroll];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencyCode:@"EUR"];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"nl_NL" ]];
   // cell.lblDrinksPrice.text=[formatter stringFromNumber: drinksPrice[row]];
    [lblDrinksPrice setText: [NSString stringWithFormat:@"%@", [formatter stringFromNumber:@([drinksModal[1]doubleValue])]]];
		    self.navigationItem.title = drinksModal[0];
    drinksImage.image = [UIImage imageNamed:drinksModal[0]];
    [lblDrinksAmount setText:[NSString stringWithFormat:@"%d",1]];
    [lblTotal setText:[NSString stringWithFormat:@"%@", [formatter stringFromNumber:@([drinksModal[1] doubleValue])]]];
    
    int currentValue = [lblDrinksAmount.text intValue];
 
    double drinksPrice = [drinksModal[1] doubleValue];
    double totalprice = currentValue * drinksPrice;
    double saldo = [DataContainer getCurrentUser].theoretical_saldo;
    double newSaldo = saldo - totalprice;
    [self.barButtonText setTitle:[formatter stringFromNumber:[NSNumber numberWithDouble:newSaldo]]];

}
- (void) tapped
{
    NSLog(@"OMG I GOT TAPPED");	
    [self.view endEditing:YES];
}

// Call this method somewhere in your view controller setup code.
- (IBAction)btnPlusOne:(id)sender {
    int currentValue = [lblDrinksAmount.text intValue];
    int newValue = currentValue + 1;
    double drinksPrice = [drinksModal[1] doubleValue];
    double totalprice = newValue * drinksPrice;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencyCode:@"EUR"];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"nl_NL" ]];
    [lblTotal  setText:[formatter stringFromNumber: @(totalprice)]];
    [lblDrinksAmount setText:[NSString stringWithFormat:@"%d", newValue]];
    double saldo = [DataContainer getCurrentUser].theoretical_saldo;
    double newSaldo = saldo - totalprice;
    [self.barButtonText setTitle:[formatter stringFromNumber:[NSNumber numberWithDouble:newSaldo]]];

}

- (IBAction)btnMinusOne:(id)sender {
    
    int currentValue = [lblDrinksAmount.text intValue];
    int newValue = currentValue - 1;
    double drinksPrice = [drinksModal[1] doubleValue];
    double totalprice = newValue * drinksPrice;
    if(currentValue < 1){
        [lblDrinksAmount setText:[NSString stringWithFormat:@"%d", 0]];
    }else{
        [lblDrinksAmount setText:[NSString stringWithFormat:@"%d", newValue]];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [formatter setCurrencyCode:@"EUR"];
        [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"nl_NL" ]];
        [lblTotal  setText:[formatter stringFromNumber: @(totalprice)]];
        double saldo = [DataContainer getCurrentUser].theoretical_saldo;
        double newSaldo = saldo - totalprice;
        [self.barButtonText setTitle:[formatter stringFromNumber:[NSNumber numberWithDouble:newSaldo]]];
    }
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}


// Called when the UIKeyboardDidShowNotification is sent.
/*- (void)keyboardWillBeShown:(NSNotification*)aNotification
{NSDictionary* info = [aNotification userInfo];
    CGRect kbRect = [self.view.window convertRect:[[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue] fromView:self.scrollView];
    CGSize kbSize = kbRect.size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
 self.scrollView.scrollIndicatorInsets = contentInsets;	}*/
- (void)keyboardWasShown:(NSNotification*)aNotification

{
    
    NSDictionary* info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    
    scrollView.contentInset = contentInsets;
    
    scrollView.scrollIndicatorInsets = contentInsets;
    /*
    
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    
    // Your app might not need or want this behavior.
    
  //   CGRect aRect = self.view.frame;
    CGRect aRect = scrollView.frame;
     aRect.size.height -= kbSize.height;
     CGPoint origin = activeField.frame.origin;
    origin.y += self.activeField.frame.size.height;
    
    origin.y -= scrollView.contentOffset.y;
    // self.activeField.frame.origin.y += self.activeField.frame.size.height;
     if (!CGRectContainsPoint(aRect, origin) ) {
     CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-(aRect.size.height));
     [scrollView setContentOffset:scrollPoint animated:YES];
     }*/
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    activeField = textField;
    
}



- (void)textFieldDidEndEditing:(UITextField *)textField

{
    
    activeField = nil;
    
}

// Called when the UIKeyboardWillHideNotification is sent

- (void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    NSLog(@"REMOVING KEYBOARD");
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    
    scrollView.contentInset = contentInsets;
    
    scrollView.scrollIndicatorInsets = contentInsets;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAddDrinks:(id)sender {
    NSLog(@"%@",[lblDrinksAmount text]);
    int amount = [[lblDrinksAmount text] intValue];
    double drinksPrice = [drinksModal[1] doubleValue];
    double totalprice = amount * drinksPrice;
    NSString* title;
    NSString* message;
    double saldo = [DataContainer getCurrentUser].theoretical_saldo;
    saldo = saldo - totalprice;
    NSLog(@"%f",saldo);
    if(saldo<0){
        title= @"Geweigerd";
        message=@"Onvoldoende saldo";
    }
    else{
    [DataContainer getCurrentUser].theoretical_saldo = saldo;
     NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencyCode:@"EUR"];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"nl_NL" ]];
    [lblTotal  setText:[formatter stringFromNumber: @(totalprice)]];
    //[lblTotal setText:[NSString stringWithFormat:@"%.2f", totalprice]];
    
      Drink *drink = [[Drink alloc]init];
    NSString* name = drinksModal[0];
    NSInteger drinksID = [drinksModal[2] integerValue];
    NSNumber *number = [NSNumber numberWithDouble:totalprice];
   // NSLog(@"drinksModal: %@",name);
    drink.name = name;
    drink.amount = amount;
    drink.id = drinksID;
    drink.totalPrice = number;
   //// NSLog(@"drink amoutn %i",drink.amount);
    NSLog(@"drinkName%@",drink.name);
    NSLog(@"drinkID%ld", (long)drink.id);
    
    NSMutableArray* existingDrinks = [DataContainer getOrderedDrinks];
   // NSLog(@"existingdrinks: %i",[existingDrinks count]);
    if (existingDrinks == nil) {
      //  NSLog(@"INITIALIZING DRINKS");
        existingDrinks = [[NSMutableArray alloc]init];
    }
    
    Boolean doNotAdd = false;
    for(Drink *d in existingDrinks){
        if(drink.name == d.name){
            d.amount = d.amount+drink.amount;
            double sumTotalPrice = d.amount * drinksPrice;
            d.totalPrice = [NSNumber numberWithDouble:sumTotalPrice];
            doNotAdd= true;
        }
    }
    if(!doNotAdd){
        [existingDrinks addObject:drink];}
    else{
        doNotAdd = false;
    }
        title = @"Bevestiging";
        message = @"uw bestelling is toegevoegd";
        
    //NSMutableArray *saveDrink = [[NSMutableArray alloc]init];
    //[saveDrink addObject:dvc];
  //  [existingDrinks addObject:drink];
        [DataContainer setOrderedDrinks:existingDrinks];}
   // [dvc.orderedDrinks addObject:dvc];
    alert = [[UIAlertView alloc]initWithTitle: title
                                      message: message
                                     delegate: self
                            cancelButtonTitle:nil
                            otherButtonTitles:nil,nil];
    [alert show];
    [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(closeAlert) userInfo:nil repeats:NO];
    //[self dismissViewControllerAnimated:true completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)closeAlert {
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

@end
