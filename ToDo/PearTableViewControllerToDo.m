//
//  PearTableViewControllerToDo.m
//  Schedule
//
//  Created by Sven Bär on 22.03.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import "PearTableViewControllerToDo.h"

@interface PearTableViewControllerToDo ()


@end

@implementation PearTableViewControllerToDo

@synthesize tableViewToDo;
@synthesize selectedRow, prepareSegueCounter, pearViewControllerToDoDetail, isInitialized;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self refreshTableViewReference];
        
    }
    self.tableViewToDo.dataSource = self;
    return self;
}

//-(id)initWithStyle:(UITableViewStyle)style{
//    self = [super initWithStyle:style];
//    if(self){
//        just an test
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    prepareSegueCounter = 0;
    
    PearAppDelegate *pearAppDelegate = (PearAppDelegate *)[[UIApplication sharedApplication]delegate];
    if([pearAppDelegate.tableViewCollector valueForKey:@"todo"] == nil){
        [pearAppDelegate.tableViewCollector addTableView: @"todo" table:self];
    }
    
    tableViewToDo.dataSource = self;
    tableViewToDo.delegate = self;
//    for (int i=0; i<entriesToShow.count; i++) {
//        if([entriesToShow objectAtIndex:i] != nil){
//            NSIndexPath * path = [NSIndexPath indexPathForRow:i inSection:0];
//            [self tableView:self.view cellForRowAtIndexPath:path];
//        }
//    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.leftBarButtonItem = self.editButtonItem;
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    PearAppDelegate *pearAppDelegate = (PearAppDelegate *)[[UIApplication sharedApplication]delegate];
    [pearAppDelegate initToDo];
    if(pearAppDelegate.entriesToShowToDo.count == 0){
        NSLog(@"Error during loading of detail data");
    }
    NSLog(@"celltodo count: %@", [NSString stringWithFormat:@"%d", pearAppDelegate.entriesToShowToDo.count]);
    return pearAppDelegate.entriesToShowToDo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellToDo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    PearAppDelegate *pearAppDelegate = (PearAppDelegate *)[[UIApplication sharedApplication]delegate];
    cell.textLabel.text = [[pearAppDelegate.entriesToShowToDo objectAtIndex:indexPath.row] subject];
    cell.detailTextLabel.text = [[pearAppDelegate.entriesToShowToDo objectAtIndex:indexPath.row] dueDate];
    
    NSLog(@"cellToDo with content %@", cell.textLabel.text);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    PearAppDelegate *pearAppDelegate = (PearAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *colorize =  [[pearAppDelegate.entriesToShowToDo objectAtIndex:indexPath.row] col];
    [cell setBackgroundColor:[pearAppDelegate getHexColorFromString:colorize]];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
        NSManagedObjectContext * context = pearAppDelegate.managedObjectContext;
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        NSEntityDescription * entity = [NSEntityDescription entityForName:@"Homework" inManagedObjectContext:context];
        [request setEntity:entity];
        NSError * error = nil;
        
        
        NSManagedObject * changedEntry = [[context executeFetchRequest:request error:&error] objectAtIndex:indexPath.row];
        if(error != nil){
            NSLog(@"Errror");
        }
        [context deleteObject:changedEntry];
        
        if (![context save:&error])
        {
            NSLog(@"Änderungen konnten nicht gespeichert werden!");
        }
        [pearAppDelegate initToDo];
        [self viewWillAppear:YES];

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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    // PearViewControllerToDoDetail *detailViewController = [[PearViewControllerToDoDetail alloc] bundle:nil];
    // PearViewControllerToDoDetail *detailViewController = [[PearViewControllerToDoDetail alloc] init];
    
    // Pass the selected object to the new view controller.
    // [self.navigationController pushViewController:detailViewController animated:YES];
    prepareSegueCounter++;
    self.selectedRow = indexPath;
    
    PearAppDelegate *pearAppDelegate = (PearAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    PearEntryToDo * target = [pearAppDelegate.entriesToShowToDo objectAtIndex:selectedRow.row];
    
    if(pearViewControllerToDoDetail != nil){
        [pearViewControllerToDoDetail setCurrentItem:target index:self.selectedRow];
        [pearViewControllerToDoDetail updateData];
    }
    else{
        NSLog(@"No todo detail controller found");
    }
    
    [self performSegueWithIdentifier:@"ToDoEditSegue" sender:self];
    //[pearViewControllerToDoDetail updateData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepageForSegue: %@", segue.identifier);
    
    if ([segue.identifier isEqualToString:@"ToDoEditSegue"] ){
        
        //just get the controller here, celldate is handled in didSelectRowAtIndexPath method
        pearViewControllerToDoDetail = segue.destinationViewController;
      
    }
    else {
       NSLog(@"prepageForSegue without setting data: %@", segue.identifier);
    }
}

- (void) viewWillAppear:(BOOL)animated{
//    [self.tableViewToDo beginUpdates];
//    [self.tableViewToDo endUpdates];
    
    //[self.tableViewToDo insertRowsAtIndexPaths:pearAppDelegate.entriesToShowToDo.lastObject withRowAnimation:YES];
    //[self reload];
    [self performSelectorOnMainThread:@selector(reload) withObject:tableViewToDo waitUntilDone:NO];

    //[self performSelector:(@selector(reload)) withObject:tableViewToDo afterDelay:0.5];
    
    //[self reload];    
    [super viewWillAppear:animated];
    
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self updateData];
}

- (void) reload{
    //[self.tableViewToDo beginUpdates];
    //PearAppDelegate *pearAppDelegate = (PearAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSLog(@"reload");
    //[pearAppDelegate initToDo];
    [self refreshTableViewReference];
    [[self tableViewToDo] reloadData];
    
    //[self.tableViewToDo endUpdates];
    [self.tableViewToDo reloadData];
    [self.tableViewToDo setNeedsDisplay];
    [self.tableViewToDo setNeedsLayout];
}

- (void) updateData{
    
    [self.tableViewToDo reloadData];
}

-(void) refreshTableViewReference{
           for(int i = 0; i < self.view.subviews.count; i++){
                if([[self.view.subviews objectAtIndex:i] class] == tableViewToDo.class){
                    self.tableViewToDo =  [self.view.subviews objectAtIndex:i];
                    if(tableViewToDo != nil){
                        break;
                    }
                }
               
                  }
                  for (UIView *subview in [self.view subviews]) {
                      if (subview.tag == 10) {
                          tableViewToDo = (UITableView *) subview;
                          break;
                      }
                  }

    
    if(self.tableViewToDo == nil){
        NSLog(@"no tableview found");
    }
}

@end
