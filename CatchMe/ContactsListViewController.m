//
//  ContactsListViewController.m
//  CatchMe
//
//  Created by Brian Mo on 11/18/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "ContactsListViewController.h"
#import "ContactsViewController.h"
#import "ContactEdit.h"
#import "ContactAddViewController.h"
#import "ContactEditViewController.h"


@interface ContactsListViewController ()

@end

@implementation ContactsListViewController

@synthesize contacts = _contacts;



// Cancels any changes and goes back to the settings menu
- (IBAction)cancelChanges {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
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
    char* buf;
    int uuid;
    NSString* url;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.contacts = [[NSMutableArray alloc] init];
    
    responseData = [NSMutableData data];
    
    buf = calloc(2000,1);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    uuid = [defaults integerForKey:@"userid"];
    
    sprintf(buf,"http://www.jnsj.ca/catchme/getcontacts.php?userid=%d",uuid);
    
    url = [[NSString alloc] initWithUTF8String:buf];
    
    free(buf);
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.contacts removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


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

- (void)doneButton:(id)sender {   

    
    [self dismissModalViewControllerAnimated:YES];

    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // Show error
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ContactEdit* loadedContact;
    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    bool sSMS;
    bool sCall;
    bool sEmail;
    int cgid;
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON");
    } else {
        for(NSDictionary *item in jsonArray) {
            NSNumber* cGID = [item objectForKey:@"id"];
            cgid = [cGID intValue];
            
            NSNumber* cSMS = [item objectForKey:@"shouldsms"];
            NSNumber* cCall = [item objectForKey:@"shouldcall"];
            NSNumber* cEmail = [item objectForKey:@"shouldemail"];
            
            if([cSMS intValue] == 1) { sSMS = true; } else { sSMS = false; }
            if([cCall intValue] == 1) { sCall = true; } else { sCall = false; }
            if([cEmail intValue] == 1) { sEmail = true; } else { sEmail = false; }
            
            loadedContact = [[ContactEdit alloc] initWithName:[item objectForKey:@"name"] number:[item objectForKey:@"phone"] email:[item objectForKey:@"email"] shouldcall:sCall shouldsms:sSMS shouldemail:sEmail];
            loadedContact.gid = cgid;
            
            [self.contacts addObject:loadedContact];
        }
    }
    
[self.tableView reloadData];
}



@end
