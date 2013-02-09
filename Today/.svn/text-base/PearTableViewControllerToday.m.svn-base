//
//  PearTableViewControllerToday.m
//  Schedule
//
//  Created by Sven Bär on 22.03.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import "PearTableViewControllerToday.h"

@interface PearTableViewControllerToday ()

@end
 
@implementation PearTableViewControllerToday

@synthesize tableViewToday, detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        for(int i = 0; i < self.view.subviews.count; i++){
           if([[self.view.subviews objectAtIndex:i] class] == UITableView.class){
                self.tableViewToday =  [self.view.subviews objectAtIndex:i];
                if(tableViewToday != nil){
                    break;
                }
           }
        }
        PearAppDelegate *pearAppDelegate = (PearAppDelegate *)[[UIApplication sharedApplication]delegate];
        [pearAppDelegate.tableViewCollector addTableView:@"today" table:self];
        
    }
    
    
    
    return self;
}


//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    PearAppDelegate *pearAppDelegate = (PearAppDelegate *)[[UIApplication sharedApplication]delegate];
    if(pearAppDelegate.entriesToShowToday.count == 0){
        NSLog(@"Error during loading of detail data");
    }
    return pearAppDelegate.entriesToShowToday.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellToday";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    PearAppDelegate *pearAppDelegate = (PearAppDelegate *)[[UIApplication sharedApplication]delegate];
    cell.textLabel.text = [[pearAppDelegate.entriesToShowToday objectAtIndex:indexPath.row] schoolSubject];
    cell.detailTextLabel.text = [[pearAppDelegate.entriesToShowToday objectAtIndex:indexPath.row] room];
    NSString *colorize =  [[pearAppDelegate.entriesToShowToday objectAtIndex:indexPath.row] col];
    [cell setBackgroundColor:[pearAppDelegate getHexColorFromString:colorize]];
    

    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    PearAppDelegate *pearAppDelegate = (PearAppDelegate *)[[UIApplication sharedApplication]delegate];
        NSString *colorize =  [[pearAppDelegate.entriesToShowToday objectAtIndex:indexPath.row] col];
        [cell setBackgroundColor:[pearAppDelegate getHexColorFromString:colorize]];
        
    
}

-(void) viewWillAppear:(BOOL)animated{
    [self updateReference];
    [self performSelectorOnMainThread:@selector(reload) withObject:tableViewToday waitUntilDone:NO];
    [super viewWillAppear:animated];
}

-(void) reload{
    [self updateReference];
    [[self tableViewToday] reloadData];
    [self.tableViewToday setNeedsDisplay];
    [self.tableViewToday setNeedsLayout];
}

-(void) viewDidAppear:(BOOL)animated{
    [self reload];
}

-(void) updateReference{
    for(UIView * view in [self.view subviews]){
        if(view.class == UITableView.class){
            self.tableViewToday = (UITableView *) view;
        }
        
        if(view.tag == 12){
            self.tableViewToday = (UITableView *) view;
        }
        for(UIView * subview in [view subviews]){
            if(subview.tag == 12){
                self.tableViewToday = (UITableView *) subview;
            }
        }
    }
    if(self.tableViewToday == nil){
        NSLog(@"no dash tableview found");
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    PearAppDelegate *pearAppDelegate = (PearAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    PearEntryToday * currentEntry = [pearAppDelegate.entriesToShowToday objectAtIndex:indexPath.row];
    
    if(detailViewController != nil){
        [detailViewController setCurrentItem:currentEntry index:indexPath];
        [detailViewController updateData];
    }
    else{
        NSLog(@"No today detail controller found");
    }
    
    [self performSegueWithIdentifier:@"TodayEditSegue" sender:self];

    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepageForSegue: %@", segue.identifier);
    
    if ([segue.identifier isEqualToString:@"TodayEditSegue"] ){
        
        //just get the controller here, celldate is handled in didSelectRowAtIndexPath method
        detailViewController = segue.destinationViewController;
        
    }
    else {
        NSLog(@"prepageForSegue without setting data: %@", segue.identifier);
    }
}


@end
