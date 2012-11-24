//
//  ContactsListViewController.m
//  CatchMe
//
//  Created by Brian Mo on 11/18/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "ContactsListViewController.h"
#import "ContactsDataController.h"
#import "Contact.h"
#import "ContactsViewController.h"
#import "ContactEdit.h"
#import "ContactAddViewController.h"
#import "ContactEditViewController.h"


@interface ContactsListViewController ()

@end

@implementation ContactsListViewController

@synthesize contacts = _contacts;

//done button to save a new contact
- (IBAction)done:(UIStoryboardSegue *)segue {
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
        ContactsViewController *addController = [segue sourceViewController];
        if (addController.contact) {
            [self.dataController addContact:addController.contact];
            [[self tableView] reloadData];
        }
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

// Cancels any changes and goes back to the settings menu
- (IBAction)cancelChanges {
    [self dismissModalViewControllerAnimated:YES];
}

//associate new data controller object with dataController property
- (void) awakeFromNib {
    [super awakeFromNib];
    self.dataController = [[ContactsDataController alloc]init];
}



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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.contacts = [[NSMutableArray alloc] init];
    
}

- (void)viewDidUnload
{
    //[self setCancel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddContactSegue"]) {
        UINavigationController *navCon = segue.destinationViewController;
        
        ContactAddViewController *addContactViewController = [navCon.viewControllers objectAtIndex:0];
        addContactViewController.contactListView = self;
    }
    else if ([segue.identifier isEqualToString:@"EditContactSegue"]) {
        ContactEditViewController *editContactViewController = segue.destinationViewController;
        editContactViewController.contact = [self.contacts objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactCell";
    
    ContactEdit *currentContact = [self.contacts objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    //set text of cell
    
    cell.textLabel.text = currentContact.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",currentContact.number,currentContact.email];
    
    return cell;

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
}

@end
