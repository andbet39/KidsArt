//
//  SelectAlbumViewController.m
//  kidsArt
//
//  Created by Andrea Terzani on 10/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "SelectAlbumViewController.h"

@interface SelectAlbumViewController ()

@end

@implementation SelectAlbumViewController

-(void)creaToolBar{
    
    int toolbarheight=82;

    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
}



-(void)caricaAlbum{
    
    
    albumArray = [[NSMutableArray alloc]init];
    
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
    
    [albumArray addObjectsFromArray:array];
    
    
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    [self caricaAlbum];
    [self creaToolBar];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AlbumCell";
    
    AlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[AlbumCell alloc] init];
    }
    
    Album * t = [albumArray objectAtIndex:indexPath.row];
    
    [cell initWithAlbum:t];
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate SelectAlbumViewController:self DidSelectAlbum:[albumArray objectAtIndex:indexPath.row]];
    
    
}
@end
