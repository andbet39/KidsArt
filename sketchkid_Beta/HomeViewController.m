//
//  HomeViewController.m
//  sketchkid_Beta
//
//  Created by Andrea Terzani on 04/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "HomeViewController.h"
#import "UIView+PartialCurl.h"
#import "ViewController.h"
#import "SketchManager.h"


@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize nameLabel;
@synthesize dateLabel;
@synthesize noteLabel;
@synthesize removeInfoButton;

@synthesize mainView;
@synthesize albumToolbar;
@synthesize infoButton;
@synthesize albumTitleLabel;
@synthesize addFavoriteButton;
@synthesize navigationBar;

-(void)creaAlbumToolBar{
    
    int toolbarheight=37;
    [albumToolbar setFrame:CGRectMake(0,0, 320, toolbarheight)];

    [albumToolbar setBackgroundImage:[UIImage imageNamed:@"greyBar.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    [addFavoriteButton setBackgroundVerticalPositionAdjustment:0.0f forBarMetrics:UIBarMetricsDefault];
    [addFavoriteButton setBackgroundImage:[UIImage imageNamed:@"addFavorites.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [albumTitleLabel setText:currentAlbum.titolo];
    [albumTitleLabel setFont:[UIFont fontWithName:@"Snickles" size:28]];
}

-(void)creaToolBar{
    
    int toolbarheight=84;
        
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
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
    _gmGridView.dataSource = self;
    _gmGridView.showsVerticalScrollIndicator=FALSE;
    
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	
    
    if ([segue.identifier isEqualToString:@"editSketch"])
    {
        //ViewController * editSketchView=(ViewController*) [segue destinationViewController];
        SketchManager *sm = [SketchManager sharedSketchManager];
        [sm setEditedSketch:selectedSketch];
    }
    
    
}


-(void)reloadAlbumData{

    AlbumManager *am = [AlbumManager sharedAlbumManager];
    currentAlbum = am.selectedAlbum;
    
    [albumTitleLabel setText:currentAlbum.titolo];

    [nameLabel setFont:[UIFont fontWithName:@"Helvetica Rounded LT Std" size:26 ]];
    [noteLabel setFont:[UIFont fontWithName:@"Helvetica Rounded LT Std" size:18]];
    [dateLabel setFont:[UIFont fontWithName:@"Helvetica Rounded LT Std" size:18]];
    
    [nameLabel setText:currentAlbum.titolo];
    [noteLabel setText:currentAlbum.note];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *dataCreazione = currentAlbum.dataCreazione;
    
    NSString *theDate = [dateFormat stringFromDate:dataCreazione];
    
    NSString * datalabel = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"CREATO_IL_INFO", nil),theDate];
    
    [dateLabel setText:datalabel];
    
    
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"saveDate" ascending:NO]];
    
    NSArray *sortedSketch = [[currentAlbum.album2sketch allObjects] sortedArrayUsingDescriptors:sortDescriptors];
    
    sketchArray = [[NSMutableArray alloc]initWithArray:sortedSketch];
    
    [_gmGridView reloadData];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AlbumManager *am = [AlbumManager sharedAlbumManager];
    
    //Una mezza porcata per tenere traccia del viewcontroller che deve rispondere di reload ecc ecc
    am.istanceOfHomeViewController=self;
    
    currentAlbum = am.selectedAlbum;

    //sketchArray= [NSMutableArray arrayWithArray:[currentAlbum.album2sketch allObjects]];
    [self reloadAlbumData];
    
    
    isPageRolled=FALSE;
    
    [self creaGridView];
    [self creaToolBar];
   
    
    [self creaAlbumToolBar];
    
    
    
}

- (void)viewDidUnload
{
   
    [self setNavigationBar:nil];
    [self setMainView:nil];
    [self setAlbumToolbar:nil];
    [self setAddFavoriteButton:nil];
    [self setAlbumTitleLabel:nil];
    [self setInfoButton:nil];
    [self setRemoveInfoButton:nil];
    [self setNameLabel:nil];
    [self setDateLabel:nil];
    [self setNoteLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)removeInfoButtonAction:(id)sender {
    
   
    
    [mainView animationPartialCurlDown];
}

- (IBAction)infoButtonAction:(id)sender {
        
    if (isPageRolled) {
        [mainView animationPartialCurlDown];
        isPageRolled=FALSE;

    }else{
        mainView.partialCurlDuration=1.0;
        mainView.partialCurlPercent=0.6;
        isPageRolled=TRUE;
        
        [mainView animationPartialCurlUp];
        
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    if (isPageRolled) {
        [mainView animationPartialCurlDown];
        isPageRolled=FALSE;
    }

}


- (IBAction)selectPreferitiAction:(id)sender{

    if ([_gmGridView isEditing]) {
        _gmGridView.editing=FALSE;

    }else{
        _gmGridView.editing=TRUE;
    }

}




/////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [sketchArray count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    
    
    return CGSizeMake(140 , 120);
    
    
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
    
    Sketch *currentSketch  =[sketchArray objectAtIndex:index];


    
    CGRect corniceRect= CGRectMake(0, 0, 140, 123);
    
    
    UIImageView *cornice =[[UIImageView alloc]initWithFrame:corniceRect];
    [cornice setImage:[UIImage imageNamed:@"cornicefoto"]];
    [cell.contentView addSubview:cornice];
    
    
    
    
    CGRect fotoRect= CGRectMake(16,12, 108, 80);
    
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:currentSketch.pathSmall];
    
    UIImage *foto = [[UIImage alloc] initWithData:data];// croppedImage:fotoRect];
    
    UIImageView *fotoView =[[UIImageView alloc]initWithFrame:fotoRect];
    [fotoView setImage:foto];
    
    
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
    
    selectedSketch = [sketchArray objectAtIndex:position];
    
    [self performSegueWithIdentifier:@"editSketch" sender:self];
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    NSLog(@"Tap on empty space");
}

- (void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index
{
    DataManager *dm = [DataManager sharedDataManager];

    
    Sketch * toRemoveSketch = [sketchArray objectAtIndex:index];
    
    if ([toRemoveSketch.album count]==1) {
        
        _toRemoveSketch=toRemoveSketch;
        _lastDeleteItemIndexAsked=index;
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ALLERT", nil) message:NSLocalizedString(@"OPERAZIONE_CANCELLA_DISEGNO", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ANNULLA", nil) otherButtonTitles:@"OK", nil];
        [alertView show];
    }else{
    
    
    [currentAlbum removeAlbum2sketchObject:toRemoveSketch];
    
    NSManagedObjectContext *moc = [dm managedObjectContext];
    
    //[moc deleteObject:[sketchArray objectAtIndex:_lastDeleteItemIndexAsked]];
    
    // Save the context.
    NSError *error = nil;
    if (![moc save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    [gridView removeObjectAtIndex:index animated:YES];
    [sketchArray removeObjectAtIndex:index];

    [_gmGridView setEditing:FALSE];
        AlbumManager *am = [AlbumManager sharedAlbumManager];
        
        [am.istanceOfAlbumViewController reloadData];
    }

}



- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        // È stato premuto il bottone Cancel
    } else if (buttonIndex == 1){
        
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSError *error;
        
        DataManager *dm = [DataManager sharedDataManager];
        
        
        NSManagedObjectContext *moc = [dm managedObjectContext];
        
        
        if ([fileMgr removeItemAtPath:_toRemoveSketch.pathFull error:&error] != YES)
            NSLog(@"Unable to delete file: %@", [error localizedDescription]);
        if ([fileMgr removeItemAtPath:_toRemoveSketch.pathSmall error:&error] != YES)
            NSLog(@"Unable to delete file: %@", [error localizedDescription]);
        
        
        [moc deleteObject:_toRemoveSketch];
        
        // Save the context.
        if (![moc save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        
        
        [_gmGridView removeObjectAtIndex:_lastDeleteItemIndexAsked animated:YES];
        [sketchArray removeObjectAtIndex:_lastDeleteItemIndexAsked];
        
        
       // [_gmGridView setEditing:FALSE];
        AlbumManager *am = [AlbumManager sharedAlbumManager];

        [am.istanceOfAlbumViewController reloadData];

    }
}


@end
