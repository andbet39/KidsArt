//
//  HomeViewController.m
//  sketchkid_Beta
//
//  Created by Andrea Terzani on 04/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "HomeViewController.h"
#import "UIView+PartialCurl.h"

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
    
    [albumToolbar setFrame:CGRectMake(0, 3, 320, toolbarheight)];
    [albumToolbar setBackgroundImage:[UIImage imageNamed:@"greyBar.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    [addFavoriteButton setBackgroundVerticalPositionAdjustment:0.0f forBarMetrics:UIBarMetricsDefault];
    [addFavoriteButton setBackgroundImage:[UIImage imageNamed:@"addFavorites.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [albumTitleLabel setText:currentAlbum.titolo];
    
}

-(void)creaToolBar{
    
    int toolbarheight=84;
        
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
}

-(void)creaAlbumScrollView{


    int size_x=self.view.frame.size.width;
    int size_y=self.view.frame.size.height;
    
    photoShowView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,size_x,size_y-88)];
    //[photoShowView setBackgroundColor:[UIColor blackColor]];
    
    [photoShowView addSubview:albumToolbar];
    [photoShowView addSubview:albumTitleLabel];
    
    int num_columns = 2;
    int padding =15;
    
    int image_size_width = (size_x-(padding*(num_columns+1)))/num_columns;
    
    
    int offsetX=252;
    int offsetY=45;
    
    int colY[num_columns];
    
    
    for(int i=0;i<num_columns;i++){
        
        colY[i]=offsetY;
        
    }
    
    for(Sketch * sk in sketchArray){
    //for(int s=0;s<10;s++){
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:sk.pathSmall];
        
        UIImage *currentSketch = [[UIImage alloc] initWithData:data];        
        int image_size_x=currentSketch.size.width;
        int image_size_y=currentSketch.size.height;
        
        float scale_factor=image_size_width/currentSketch.size.width;
        
        
        int idx_col=0;
        int minfindY=colY[0];
        
        for(int i=0;i<num_columns;i++){
            
            if (colY[i]<minfindY) {
                idx_col=i;
                minfindY=colY[i];
            }
            
        }
        
        offsetX=padding+(idx_col*image_size_width)+(padding*idx_col);
        offsetY=colY[idx_col]+padding;
        
        colY[idx_col]=(offsetY+(image_size_y*scale_factor));
        
        UIImageView * previewView = [[UIImageView alloc]initWithFrame:CGRectMake(offsetX, offsetY, image_size_x*scale_factor, image_size_y*scale_factor)];
        [previewView setImage:currentSketch];
        
        
        previewView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
        previewView.layer.shadowColor = [UIColor blackColor].CGColor;
        previewView.layer.shadowOpacity = 1;
        previewView.layer.shouldRasterize=YES;
        
        
        [photoShowView addSubview:previewView];
        
        
        previewView.layer.cornerRadius = 10;
        
        //previewView.tag=i;
        
        [previewView setUserInteractionEnabled:YES];
        
        
        
    }
    int max_findY=0;
    for(int i=0;i<num_columns;i++){
        
        if (colY[i]>max_findY) {
            max_findY=colY[i];
        }
        
    }
    
    [photoShowView setContentSize:CGSizeMake(size_x,max_findY+padding)];
    
    [mainView addSubview:photoShowView];
    

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AlbumManager *am = [AlbumManager sharedAlbumManager];
    currentAlbum = am.selectedAlbum;

    sketchArray= [NSMutableArray arrayWithArray:[currentAlbum.album2sketch allObjects]];

    
    [self creaAlbumScrollView];
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
        
    mainView.partialCurlDuration=1;
    mainView.partialCurlPercent=0.60;
    
    
    [mainView animationPartialCurlUp];
}

- (IBAction)creaDefaultAlbum:(id)sender {
    
    DataManager *dm =[DataManager sharedDataManager];
    
    Album *defaultAlbum = (Album *)[NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:dm.managedObjectContext];
    
    
    [defaultAlbum setTitolo:@"Default"];
    [defaultAlbum setOrder:[NSDecimalNumber numberWithInt:0]];
    [defaultAlbum setDataCreazione:[NSDate date]];
    //[defaultAlbum setCopertinaPath:]
    NSManagedObjectContext *context = [dm managedObjectContext];

    // Save the context.
    NSError *error = nil;
    if (![context save:&error]){
    
    }
    
}


@end
