//
//  DrinksListViewController.m
//  SMPT
//
//  Created by Anh Tran on 28-05-14.
//  Copyright (c) 2014 Fontys. All rights reserved.
//

#import "DrinksListViewController.h"
#import "TableCell.h"
#import "CurrentDrinksViewController.h"
#import "DrinksCategory.h"
#import "Drink.h"

@interface DrinksListViewController ()

@end

@implementation DrinksListViewController
@synthesize drinksID;
@synthesize drinksName;
@synthesize drinksPrice;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:73.0/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:73.0/255.0 alpha:1.0]];
  [self.navigationController.navigationBar setTranslucent:NO];
    self.view.backgroundColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:73.0/255.0 alpha:1.0];
    self.view.tintColor =[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:73.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.drinks = @[[[Drink alloc] initWithName:@"Cola" categoryID:2 andID:0],[[Drink alloc] initWithName:@"ColaLight" categoryID:2 andID:1],[[Drink alloc] initWithName:@"Fanta" categoryID:2 andID:1],[[Drink alloc] initWithName:@"7 up" categoryID:2 andID:3],[[Drink alloc] initWithName:@"Ice Tea" categoryID:2 andID:4],[[Drink alloc] initWithName:@"Fles" categoryID:1 andID:5], [[Drink alloc] initWithName:@"Glas" categoryID:1 andID:6], [[Drink alloc] initWithName:@"Corona" categoryID:1 andID:7],[[Drink alloc] initWithName:@"Radler" categoryID:1 andID:8], [[Drink alloc] initWithName:@"Rose" categoryID:0 andID:9],[[Drink alloc] initWithName:@"Fristi" categoryID:3 andID:11],[[Drink alloc] initWithName:@"Chocomel" categoryID:3 andID:12]];
    NSSortDescriptor* sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
  //  NSSortDescriptor* catDescriptor = [[NSSortDescriptor alloc]initWithKey:@"categoryId" ascending:YES];
    
    self.drinks = [self.drinks sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
  //  drinksID = @[@1,@2,@3,@4,@5,@6,@7,@8,@9];
  //  drinksName = @[@"Cola", @"Fanta", @"7 up", @"Ice Tea", @"Bier", @"Thee", @"Koffie",
  //                 @"Fristy", @"Whisky"];
 //   NSNumber *doubleNumber = [NSNumber numberWithDouble:0.2f];
 //   drinksPrice = @[@2.50, @2.50, @2.50, @2.50, @3.50, @2.00, @1.50, @2.00, @4.00];
    self.categories=@[[[DrinksCategory alloc] initWithName:@"Frisdrank" andID:2],[[DrinksCategory alloc] initWithName:@"Bier" andID:1], [[DrinksCategory alloc] initWithName:@"Alcohol" andID:0],[[DrinksCategory alloc] initWithName:@"Speciaal" andID:3]];
   // drinksPrice = @[@"2.50", @"2.50", @"2.50", @"2.50", @"3.50", @"2.00", @"1.50", @"3.25", @"2.00", @"4.00"];
    //drinksName = [drinksName sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return self.categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{	
#warning Incomplete method implementation.
    NSInteger count = 0;NSLog(@"Section: %i",(long)section);
    
    for(Drink* drink in self.drinks)
    {
        if(drink.categoryID == section)
            count++;
        
    }
    NSLog(@"count: %i",count);
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableCell";
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
       // Configure the cell...
    Drink* d =[self getDrinkFromTable:indexPath];
    
    cell.lblDrinksName.text = d.name;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencyCode:@"EUR"];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"nl_NL"]];
    cell.lblDrinksPrice.text=[formatter stringFromNumber: d.price];
   // cell.lblDrinksPrice.text = [NSString stringWithFormat:@"%@", drinksPrice[row]];
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    for(DrinksCategory* cat in self.categories){
        if(cat.categoryID == section){
            sectionName = cat.categoryName;
                    }
    }
    return sectionName;
    }
-(Drink*) getDrinkFromTable:(NSIndexPath *)indexPath{
    int section = indexPath.section;

    NSMutableArray* sectionDrinks = [[NSMutableArray alloc]init];
    for(Drink* d in self.drinks){
        if(d.categoryID == section)
            [sectionDrinks addObject: d];
    }
    Drink* d = [sectionDrinks objectAtIndexedSubscript:indexPath.row];
    return d;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"ShowDetails"])
    {
        CurrentDrinksViewController *cdv = [segue destinationViewController];
         Drink* d =[self getDrinkFromTable:[self.tableView indexPathForSelectedRow]];
             // self.drinksName = [self.drinksName objectAtIndex:selectedRow.row];
        cdv.drinksModal = @[d.name,d.price, [NSNumber numberWithInteger:d.id]];
    }

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
