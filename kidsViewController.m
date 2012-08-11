//
//  kidsViewController.m
//  sketchkid_Beta
//
//  Created by Andrea Terzani on 05/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "kidsViewController.h"

@interface kidsViewController ()

@end

@implementation kidsViewController
@synthesize editButton;
@synthesize mainView;
@synthesize toolBar;
@synthesize titleLabel;

-(void)creaNavigationBar{
    
    int toolbarheight=37;

    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];

    [toolBar setFrame:CGRectMake(0, 0, 320, toolbarheight)];
    [toolBar setBackgroundImage:[UIImage imageNamed:@"greyBar.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    [titleLabel setText:@"Kids"];
    

}

-(void)creaGridView{


    NSInteger spacing = 10;

    GMGridView *gmGridView = [[GMGridView alloc] initWithFrame:mainView.bounds];
    gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gmGridView.backgroundColor = [UIColor clearColor];
    [mainView addSubview:gmGridView];
    
    _gmGridView = gmGridView;
    
    _gmGridView.style = GMGridViewStyleSwap;
    _gmGridView.itemSpacing = spacing;
    _gmGridView.minEdgeInsets = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    _gmGridView.centerGrid = TRUE;
    _gmGridView.actionDelegate = self;
    //_gmGridView.sortingDelegate = self;
    //_gmGridView.transformDelegate = self;
    _gmGridView.dataSource = self;



}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	
    
    if ([segue.identifier isEqualToString:@"newKid"])
    {
        newKidViewController * newKidView=(newKidViewController*) [segue destinationViewController];
        [newKidView setDelegate:self];
    }
}



#pragma mark - NewTripViewController delegate
-(void)NewKidViewController:(newKidViewController *)controller DidAddKid:(Kid *)kid
{
    
    [self dismissModalViewControllerAnimated:YES];
    
    
    [kidsArray addObject:kid];
    [_gmGridView reloadData];

    
    DataManager *dm = [DataManager sharedDataManager];
    
    
    NSManagedObjectContext *context = [dm managedObjectContext];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    
    
}

-(void)NewKidViewControllerDidCancel:(newKidViewController *)controller{
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self dismissModalViewControllerAnimated:YES];

    
}




//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [kidsArray count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    
       
            return CGSizeMake(140 , 150);
        
    
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    //NSLog(@"Creating view indx %d", index);
    
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];
        cell.deleteButtonIcon = [UIImage imageNamed:@"close_x.png"];
        cell.deleteButtonOffset = CGPointMake(-15, -15);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        view.backgroundColor = [UIColor clearColor];
        view.layer.masksToBounds = NO;
        view.layer.cornerRadius = 8;
        
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    Kid * currentKid = [kidsArray objectAtIndex:index];
    
    
    
    CGRect labelRect= CGRectMake(0, size.height-30, size.width, 30);
    
    UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
    //label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.text = (NSString *)currentKid.nome;
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.highlightedTextColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    [cell.contentView addSubview:label];
    
    
    CGRect corniceRect= CGRectMake(5, size.height-150, size.width-5, 135);


    UIImageView *cornice =[[UIImageView alloc]initWithFrame:corniceRect];
    [cornice setImage:[UIImage imageNamed:@"corniceBimbo.png"]];
    //cornice.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [cell.contentView addSubview:cornice];
    
    CGRect fotoRect= CGRectMake(22, size.height-135, size.width-38, 90);
    UIImageView *fotoView =[[UIImageView alloc]initWithFrame:fotoRect];
    
    //TODO: aggiustare con le foto salvate nel modello kid... Valutare se permettere fotografia
    
    if(index%2==0){
        [fotoView setImage:[UIImage imageNamed:@"bambinoDefault.png"]];
    }else{
        [fotoView setImage:[UIImage imageNamed:@"bambinoDefault2.png"]];

    }
    [cell.contentView addSubview:fotoView];
    
    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return YES;
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewActionDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    NSLog(@"Did tap at index %d", position);
    
    
    //Crea un album temporaneo inserendo tutti i disegni del bambino selezinato, lo passa alla vista e lo cancella
    
    DataManager *dm =[DataManager sharedDataManager];
    Kid * selectedKid= [kidsArray objectAtIndex:position];
    
    Album *disegniDiAlbum = (Album *)[NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:dm.managedObjectContext];
    disegniDiAlbum.titolo=[NSString stringWithFormat:@"Disegni di %@",selectedKid.nome];
    disegniDiAlbum.order=[NSDecimalNumber numberWithInt:1000];
    disegniDiAlbum.dataCreazione=[NSDate date];
    
    
    NSManagedObjectContext *moc = [dm managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Sketch" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"kid == %@",selectedKid]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"data" ascending:NO];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    [disegniDiAlbum addAlbum2sketch:[NSSet setWithArray:array]];
    
    AlbumManager *am = [AlbumManager sharedAlbumManager];
    [am setSelectedAlbum:disegniDiAlbum];
    [am.istanceOfHomeViewController reloadAlbumData];
    
    [dm.managedObjectContext deleteObject:disegniDiAlbum];
    [self.tabBarController setSelectedIndex:1];
    
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    NSLog(@"Tap on empty space");
}

- (void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Are you sure you want to delete this item?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    
    [alert show];
    
    _lastDeleteItemIndexAsked = index;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        DataManager *dm = [DataManager sharedDataManager];
        
        
        NSManagedObjectContext *moc = [dm managedObjectContext];
        
        [moc deleteObject:[kidsArray objectAtIndex:_lastDeleteItemIndexAsked]];
        
        // Save the context.
        NSError *error = nil;
        if (![moc save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }

        [kidsArray removeObjectAtIndex:_lastDeleteItemIndexAsked];
        [_gmGridView removeObjectAtIndex:_lastDeleteItemIndexAsked withAnimation:GMGridViewItemAnimationFade];
        

        
    }
}


-(void)popolaArraykid{

    
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

    kidsArray =  [[NSMutableArray alloc]init];
    
    [self creaNavigationBar];
    
    [self popolaArraykid];
    [self creaGridView];

    
    
}

- (void)viewDidUnload
{
    [self setMainView:nil];
    [self setToolBar:nil];
    [self setTitleLabel:nil];
    [self setEditButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (IBAction)enableEditButton:(id)sender {
    
    if([_gmGridView isEditing]){
        [editButton setTitle:@"Edit"];
        _gmGridView.editing=FALSE;

    }else{
        [editButton setTitle:@"Done"];
        _gmGridView.editing=TRUE;
    }
    
}
@end
