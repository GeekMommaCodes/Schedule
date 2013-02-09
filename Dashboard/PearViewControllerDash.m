//
//  PearViewControllerDash.m
//  Schedule
//
//  Created by Sven Bär on 16.06.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import "PearViewControllerDash.h"
#import <QuartzCore/QuartzCore.h>

@interface PearViewControllerDash ()

@end

@implementation PearViewControllerDash
@synthesize labelDate, pearViewControllerToDoDetail, selectedRow;

@synthesize tableViewDash, pearAppDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"init Dash");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            NSLog(@"init Dash delegate");
        pearAppDelegate = (PearAppDelegate *)[[UIApplication sharedApplication]delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        NSLog(@"did load Dash");
    pearAppDelegate = (PearAppDelegate *)[[UIApplication sharedApplication]delegate];
	[pearAppDelegate initToDo];
    [pearAppDelegate initToday];
    [pearAppDelegate.tableViewCollector setValue:tableViewDash forKey:@"dash"];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate * now = [NSDate date];
        
    NSDateComponents *dateComponents = [calendar components:(NSDayCalendarUnit  | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:now];
    NSInteger day = [dateComponents day];
    NSInteger month = [dateComponents month];
    NSInteger year = [dateComponents year];
       
    NSString * dateString = [NSString stringWithFormat:@"%d.%d.%d", day, month, year];
    labelDate.text = dateString;
    
    NSLog(@"label.Date.text: %@", labelDate.text);
    
}

- (void)viewDidUnload
{
    [self setLabelDate:nil];
    self.pearViewControllerToDoDetail = nil;
    self.tableViewDash = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        //NSLog(@"Anzahl von Today-Entrys - %@",pearAppDelegate.entriesToShowToday.count);
        return pearAppDelegate.entriesToShowToday.count;
        
    }else {
        //NSLog(@"Anzahl von ToDo-Entrys - %@",pearAppDelegate.entriesToShowToDo.count);
        return pearAppDelegate.entriesToShowToDo.count;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellDashboard";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(indexPath.section == 0){
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = [[pearAppDelegate.entriesToShowToday objectAtIndex:indexPath.row] schoolSubject];
        cell.detailTextLabel.text = [[pearAppDelegate.entriesToShowToday objectAtIndex:indexPath.row] room];
    }else {
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = [[pearAppDelegate.entriesToShowToDo objectAtIndex:indexPath.row] subject];
        cell.detailTextLabel.text = [[pearAppDelegate.entriesToShowToDo objectAtIndex:indexPath.row] dueDate];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        NSString *colorize =  [[pearAppDelegate.entriesToShowToday objectAtIndex:indexPath.row] col];
        [cell setBackgroundColor:[pearAppDelegate getHexColorFromString:colorize]];

    }
    else{
    NSString *colorize =  [[pearAppDelegate.entriesToShowToDo objectAtIndex:indexPath.row] col];
    [cell setBackgroundColor:[pearAppDelegate getHexColorFromString:colorize]];
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] ;
    if (section == 0){
        UIColor * color = [pearAppDelegate getHexColorFromString:NSLocalizedString(@"Dash.sectionheader.color",@"")];
        [headerView setBackgroundColor: color] ;
        headerView.text = NSLocalizedString(@"Dash.sections.today",@"");
    }
    else{
        [headerView setBackgroundColor:[UIColor blueColor]];
        headerView.text = NSLocalizedString(@"Dash.sections.todo",@"");
    }
    
    CALayer * layer = [headerView layer];
    layer.masksToBounds = YES;
    // layer.cornerRadius = 5;
    
    return headerView;

    
}

-(void) viewDidAppear:(BOOL)animated{
    [self reload];
}

- (void) viewWillAppear:(BOOL)animated{
    [self updateReference];
    
    [self performSelectorOnMainThread:@selector(reload) withObject:tableViewDash waitUntilDone:NO];
    [super viewWillAppear:animated];
}


-(void) reload{
    [self updateReference];
    [self.tableViewDash reloadData];
    [self.tableViewDash setNeedsDisplay];
    [self.tableViewDash setNeedsLayout];
}

-(void) updateReference{
    for(UIView * view in [self.view subviews]){
        if(view.class == UITableView.class){
            self.tableViewDash = (UITableView *) view;
            return;
        }
            
        if(view.tag == 11){
            self.tableViewDash = (UITableView *) view;
            return;
        }
        for(UIView * subview in [view subviews]){
            if(subview.tag == 11){
                self.tableViewDash = (UITableView *) subview;
                return;
            }
        }
    }
    if(self.tableViewDash == nil){
        NSLog(@"no dash tableview found");
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
    if(indexPath != self.selectedRow){
        if(indexPath.section == 0){
            
        }
        else if(indexPath.section == 1){
            self.selectedRow = indexPath;
            
            
            //        [pearViewControllerToDoDetail presentModalViewController:self animated:YES];
            
            [self performSegueWithIdentifier:@"DashToDoSegue" sender:self];
            
        }
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepageForSegue: %@", segue.identifier);
    
    if ([segue.identifier isEqualToString:@"DashToDoSegue"] ){
        
        
        pearViewControllerToDoDetail = segue.destinationViewController;
        
        PearEntryToDo * target = [pearAppDelegate.entriesToShowToDo objectAtIndex:selectedRow.row];
        
        if(pearViewControllerToDoDetail == nil){
            NSLog(@"DashTodo - Detail controller is null!");
            return;
        }
        else{
            [pearViewControllerToDoDetail setCurrentItem:target index:self.selectedRow];
            [pearViewControllerToDoDetail updateData];
        }
        

        
    }
    else {
        NSLog(@"prepageForSegue without setting data: %@", segue.identifier);
    }
}



@end
