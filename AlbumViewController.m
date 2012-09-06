//
//  AlbumViewController.m
//  kidsArt
//
//  Created by Andrea Terzani on 08/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "AlbumViewController.h"

@interface AlbumViewController ()

@end

@implementation AlbumViewController
@synthesize titleLabel;
@synthesize toolBar;
@synthesize addAlbumButtonAction;
@synthesize addAlbumAction;
@synthesize tableView;


-(void)creaToolBar{
    
    int toolbarheight=37;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    [toolBar setFrame:CGRectMake(0, 0, 320, toolbarheight)];
    [toolBar setBackgroundImage:[UIImage imageNamed:@"greyBar.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    [titleLabel setText:NSLocalizedString(@"ALBUMS", nil)];
    
    [titleLabel setFont:[UIFont fontWithName:@"Snickles" size:28]];
    
}


-(void)caricaAlbum{


    DataManager *dm = [DataManager sharedDataManager];
    
    
    NSManagedObjectContext *moc = [dm managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Album" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"order" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    
    
    if (array == nil)
    {
        // Deal with error...
    }

    for (Album *a in array) {
        NSLog(@"Fetched : Disegni %u in Album : %@ ",[a.album2sketch count],a.titolo);
        
    }
    
    
    [albumArray removeAllObjects];

    [albumArray addObjectsFromArray:array];
    
    

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"newAlbum"])
    {
        newAlbumViewController * newAlbumView=(newAlbumViewController*) [segue destinationViewController];
        [newAlbumView setDelegate:self];
    }
}


-(void)reloadData{
    
    [self caricaAlbum];
    [tableView reloadData];
    
}


- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    AlbumManager *am =[AlbumManager sharedAlbumManager];
    
    [am setIstanceOfAlbumViewController:self];
    
    albumArray = [[NSMutableArray alloc]init];
    
    isEditing=false;
    
    [self caricaAlbum];
    [self creaToolBar];
    
    

}

- (void)viewDidUnload
{
    [self setAddAlbumButtonAction:nil];
    [self setAddAlbumAction:nil];
    [self setTableView:nil];
    [self setToolBar:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [albumArray count];
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AlbumCell";
    
    AlbumCell *cell = (AlbumCell*)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
  /* if (cell == nil) {
    cell = [[AlbumCell alloc] init];
    }*/

    Album * t = [albumArray objectAtIndex:indexPath.row];
    
    [cell initWithAlbum:t];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
	
        toDelete = [albumArray objectAtIndex:indexPath.row];
        if (toDelete.isDefault) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ALLERT", nil) message:NSLocalizedString(@"ALLERT_CANCELLA_ALBUM_DISEGNO", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ANNULLA", nil) otherButtonTitles:nil, nil];
            [alertView show];
        }else{
           
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ALLERT", nil) message:NSLocalizedString(@"TUTTI_DISEGNI_IN_DEFAULT", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ANNULLA", nil) otherButtonTitles:@"OK", nil];
            [alertView show];
        
        
        
        
        }
    
    }
}


- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        // È stato premuto il bottone Cancel
    } else if (buttonIndex == 1){
        
        //-------CANCELLA ALBUM
        
        
        NSError *error;
        
        DataManager *dm = [DataManager sharedDataManager];
        AlbumManager *am = [AlbumManager sharedAlbumManager];

        Album * defaullAlbum = am.defaultAlbum;
        
        for (Sketch * s in toDelete.album2sketch) {
            
            [defaullAlbum addAlbum2sketchObject:s];
        }
        
        
        NSManagedObjectContext *moc = [dm managedObjectContext];
        
        
        [moc deleteObject:toDelete];
        
        // Save the context.
        if (![moc save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        
        
        
        [am setSelectedAlbum:[am defaultAlbum]];
        
        [am.istanceOfHomeViewController reloadAlbumData];
        [am.istanceOfAlbumViewController reloadData];
        
        
        
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    AlbumManager *am = [AlbumManager sharedAlbumManager];
    [am setSelectedAlbum:[albumArray objectAtIndex:indexPath.row]];
    [am.istanceOfHomeViewController reloadAlbumData];

    [self.tabBarController setSelectedIndex:1];
}

#pragma mark - NewAlbum view delegate


- (void)newAlbumViewControllerDidCancel:(newAlbumViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];

}

- (void)newAlbumViewController: (newAlbumViewController *)controller DidAddAlbum:(Album *)album
{
    
    [self dismissModalViewControllerAnimated:YES];
    [albumArray addObject:album];
    [tableView reloadData];
    
    DataManager *dm = [DataManager sharedDataManager];
    
    
    NSManagedObjectContext *context = [dm managedObjectContext];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    
}


- (IBAction)addAlbumAction:(id)sender {
    
    [self performSegueWithIdentifier:@"newAlbum" sender:self];
}

- (IBAction)editButtonAction:(id)sender {
    if (isEditing) {
        
        isEditing=FALSE;
    }else{
        isEditing=true;
    }
}

@end
