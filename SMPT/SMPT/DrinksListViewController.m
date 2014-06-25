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
#import "DataContainer.h"

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
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:73.0/255.0 alpha:1.0]];
  [self.navigationController.navigationBar setTranslucent:NO];
    self.view.backgroundColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:73.0/255.0 alpha:1.0];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.drinks = @[[[Drink alloc] initWithName:@"Cola" categoryID:2 price:@2.50 andID:0 withImage:@"Images.xcassets%d/Cola%d/ColaFlesje_SMARTBAR%d" ofType:@"png"],[[Drink alloc]initWithName:@"ColaLight" categoryID:2 price:@2.50 andID:1 withImage:@"Images.xcassets%d/Cola_Light%d/Cola_Light%d" ofType:@"png"],[[Drink alloc] initWithName:@"Fanta" categoryID:2 price:@2.50 andID:1 withImage:@"Images.xcassets%d/Fanta%d/fanta%d" ofType:@"png"],[[Drink alloc] initWithName:@"7 up" categoryID:2 price:@2.50 andID:3 withImage:@"Images.xcassets%d/7-up%d/7-up%d" ofType:@"png"],[[Drink alloc] initWithName:@"Ice Tea" categoryID:2 price:@3.50 andID:4 withImage:@"Images.xcassets%d/IceTea%d/IceTea%d" ofType:@"png"],[[Drink alloc] initWithName:@"Fles" categoryID:1 price:@3.75 andID:5 withImage:@"Images.xcassets%d/Bier_Fles%d/bierfles%d" ofType:@"png"], [[Drink alloc] initWithName:@"Glas" categoryID:1 price:@2.75 andID:6 withImage:@"Images.xcassets%d/Bier_Glas%d/bierglas%d" ofType:@"png"], [[Drink alloc] initWithName:@"Corona" categoryID:1 price:@4.25 andID:7 withImage:@"Images.xcassets%d/Corona%d/corona%d" ofType:@"png"],[[Drink alloc] initWithName:@"Radler" categoryID:1 price:@4.00 andID:8 withImage:@"Images.xcassets%d/Radler%d/radler%d" ofType:@"png"], [[Drink alloc] initWithName:@"Rose" categoryID:0 price:@3.75 andID:9 withImage:@"Images.xcassets%d/Rose%d/rose%d" ofType:@"png"],[[Drink alloc] initWithName:@"Fristi" categoryID:3 price:@2.50 andID:11 withImage:@"Images.xcassets%d/Fristi%d/Fristi%d" ofType:@"png"],[[Drink alloc] initWithName:@"Chocomel" categoryID:3 price:@2.50 andID:12 withImage:@"Images.xcassets%d/Chocomel%d/Chocomel%d" ofType:@"png"]];
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
-(void) viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
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
    return self.categories.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{	
#warning Incomplete method implementation.
    NSInteger count = 0;
    NSLog(@"Section: %li",(long)section);
  if(section == 0){
      return 1;}
    for(Drink* drink in self.drinks)
    {
        if(drink.categoryID+1 == section)
            count++;	
        
    }
    NSLog(@"count: %li",(long)count);
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"TableCell";
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
       // Configure the cell...
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencyCode:@"EUR"];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"nl_NL"]];

    if(indexPath.section == 0){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
        NSInteger amount =  0;
        for(Drink* d in [DataContainer getOrderedDrinks]){
            amount = amount + d.amount;
        }
        cell.lblDrinksName.text = [NSString stringWithFormat:@"Aantal: %li",(long)amount];
        double saldo = [DataContainer getCurrentUser].theoretical_saldo;
        cell.lblDrinksPrice.text =[NSString stringWithFormat:@"Saldo:%@",[formatter stringFromNumber: [NSNumber numberWithDouble:saldo]]];
        return cell;
    }
    Drink* d =[self getDrinkFromTable:indexPath];
    
    cell.lblDrinksName.text = d.name;
        cell.lblDrinksPrice.text=[formatter stringFromNumber: d.price];
   // cell.lblDrinksPrice.text = [NSString stringWithFormat:@"%@", drinksPrice[row]];
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    if(section == 0)
    {
        return @"Huidige bestelling";
    }
    for(DrinksCategory* cat in self.categories){
        if(cat.categoryID+1 == section){
            sectionName = cat.categoryName;
                    }
    }
    return sectionName;
    }
-(Drink*) getDrinkFromTable:(NSIndexPath *)indexPath{
    int section = indexPath.section;

    NSMutableArray* sectionDrinks = [[NSMutableArray alloc]init];
    for(Drink* d in self.drinks){
        if(d.categoryID+1 == section)
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
