//
//  SeletKidViewController.m
//  kidsArt
//
//  Created by Andrea Terzani on 11/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "SelectKidViewController.h"

@interface SelectKidViewController ()

@end

@implementation SelectKidViewController

-(void)caricaKid{
    
    
    kidsArray = [[NSMutableArray alloc]init];
    
    DataManager *dm = [DataManager sharedDataManager];
    
    
    NSManagedObjectContext *moc = [dm managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Kid" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"nome" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    
    
    if (array == nil)
    {
        // Deal with error...
    }
    
    [kidsArray addObjectsFromArray:array];
    
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self caricaKid];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
    return [kidsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"kidCell";
    
    kidCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[kidCell alloc] init];
    }
    
    Kid * t = [kidsArray objectAtIndex:indexPath.row];
    
    [cell initWithKid:t];
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate SelectKidViewControllerr:self DidSelectKid:[kidsArray objectAtIndex:indexPath.row]];
    
    
}

@end
