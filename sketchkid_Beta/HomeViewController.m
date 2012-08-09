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


@interface HomeViewController ()

@end

@implementation HomeViewController
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
    
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	
    
    if ([segue.identifier isEqualToString:@"editSketch"])
    {
        ViewController * editSketchView=(ViewController*) [segue destinationViewController];
        [editSketchView setCurrentSketch:selectedSketch];
        //[editSketchView setDelegate:self];
    }
}


-(void)reloadAlbumData{

    AlbumManager *am = [AlbumManager sharedAlbumManager];
    currentAlbum = am.selectedAlbum;
    
    [albumTitleLabel setText:currentAlbum.titolo];

    sketchArray= [[NSMutableArray alloc ]initWithArray:[currentAlbum.album2sketch allObjects]];

    [_gmGridView reloadData];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AlbumManager *am = [AlbumManager sharedAlbumManager];
    
    //Una mezza porcata per tenere traccia del viewcontroller che deve rispondere di reload ecc ecc
    am.istanceOfHomeViewController=self;
    
    currentAlbum = am.selectedAlbum;

    sketchArray= [NSMutableArray arrayWithArray:[currentAlbum.album2sketch allObjects]];

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
        mainView.partialCurlPercent=0.618;
        isPageRolled=TRUE;
        
        [mainView animationPartialCurlUp];
        
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
    
    Sketch *currentSketch  =[sketchArray objectAtIndex:index];


    
    CGRect corniceRect= CGRectMake(5, size.height-150, size.width-5, 135);
    
    
    UIImageView *cornice =[[UIImageView alloc]initWithFrame:corniceRect];
    [cornice setImage:[UIImage imageNamed:@"corniceBimbo.png"]];
    [cell.contentView addSubview:cornice];
    
    
    
    
    CGRect fotoRect= CGRectMake(22, size.height-135, size.width-38, 90);
    
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:currentSketch.pathSmall];
    
    UIImage *foto = [[UIImage alloc] initWithData:data];
    
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
        
        [moc deleteObject:[sketchArray objectAtIndex:_lastDeleteItemIndexAsked]];
        
        // Save the context.
        NSError *error = nil;
        if (![moc save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        [sketchArray removeObjectAtIndex:_lastDeleteItemIndexAsked];
        [_gmGridView removeObjectAtIndex:_lastDeleteItemIndexAsked withAnimation:GMGridViewItemAnimationFade];
        
    //TODO: Va rimosso anche il file
        
    }
}









-(Sketch*)saveSketch:(UIImage*)finalImage
{
    
    DataManager *dm =[DataManager sharedDataManager];
    
    Sketch *sketch = (Sketch *)[NSEntityDescription insertNewObjectForEntityForName:@"Sketch" inManagedObjectContext:dm.managedObjectContext];
    
    
    UIImage *image = finalImage;
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:locale];
    [dateFormatter setDateFormat:@"yyyyMMdd-HHmmss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSString *imageName = [NSString stringWithFormat:@"sketch-%@.png",
                           [dateFormatter stringFromDate:[NSDate date]]];
    
    
    // Find the path to the documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // Now we get the full path to the file
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    
    // Write out the data.
    [imageData writeToFile:fullPathToFile atomically:NO];
    
    
    //Salva il file dell' immmagine piccola
    UIImage *smallSketch = [image scaleToSize:CGSizeMake(image.size.width/15, image.size.height/15)];
    NSData *imageDataSmall = UIImageJPEGRepresentation(smallSketch, 0.6);
    
    NSString *imageNameSmall = [NSString stringWithFormat:@"sketch-%@-small.png",
                                [dateFormatter stringFromDate:[NSDate date]]];
    
    NSString *fullPathToFileSmall = [documentsDirectory stringByAppendingPathComponent:imageNameSmall];
    [imageDataSmall writeToFile:fullPathToFileSmall atomically:NO];
    
    
    
    //Prende istanza dell' album di default
    AlbumManager *am =[AlbumManager sharedAlbumManager];
    
    Album * defaultAlbum= [am defaultAlbum];
    
    
    //prepara il modello da salvare
    [sketch setPathFull:fullPathToFile];
    [sketch setPathSmall:fullPathToFileSmall];
    [sketch setNota:@""];
    [sketch setData:[NSDate date]];
    [sketch setSaveDate:[NSDate date]];
    
    NSError *error = nil;
    
    
    [defaultAlbum addAlbum2sketchObject:sketch];
    
    [[dm managedObjectContext] save:&error];
    
    return sketch;
    
}





- (IBAction)creaDefaultAlbum:(id)sender {
    
    DataManager *dm =[DataManager sharedDataManager];
    
    Album *defaultAlbum = (Album *)[NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:dm.managedObjectContext];
    
    
    [defaultAlbum setTitolo:@"Default"];
    [defaultAlbum setOrder:[NSDecimalNumber numberWithInt:0]];
    [defaultAlbum setDataCreazione:[NSDate date]];
    //[defaultAlbum setCopertinaPath:]
    
    UIImage *firsrImage=[UIImage imageNamed:@"home.jpg"];
    
    
    
    
    NSManagedObjectContext *context = [dm managedObjectContext];

    // Save the context.
    NSError *error = nil;
    if (![context save:&error]){
    
    }
    
    Sketch* save =[self saveSketch:firsrImage];
    
}


@end
