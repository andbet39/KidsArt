//
//  ViewController.m
//  sketchkid_Beta
//
//  Created by Andrea Terzani on 04/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize trashButton;
@synthesize frameButton;
@synthesize adjustButton;
@synthesize fintaNavigationBar;
@synthesize mainView;
@synthesize toolBar;
@synthesize penButton;
@synthesize shareButton;
@synthesize currentSketch;
@synthesize mainImageView;



-(void)creaToolBar{
    
    int toolbarheight=82;

    [toolBar setFrame:CGRectMake(0, self.view.frame.size.height-toolbarheight, 320, toolbarheight)];
    [toolBar setBackgroundImage:[UIImage imageNamed:@"toolBarBack.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    
    
    [penButton setBackgroundVerticalPositionAdjustment:15.0f forBarMetrics:UIBarMetricsDefault];
    [penButton setBackgroundImage:[UIImage imageNamed:@"pen_icon.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [shareButton setBackgroundImage:[UIImage imageNamed:@"shareIcon.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [shareButton setBackgroundVerticalPositionAdjustment:15.0f forBarMetrics:UIBarMetricsDefault];
    
    [trashButton setBackgroundImage:[UIImage imageNamed:@"deleteIcon.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [trashButton setBackgroundVerticalPositionAdjustment:15.0f forBarMetrics:UIBarMetricsDefault];
    
    
    [frameButton setBackgroundImage:[UIImage imageNamed:@"frameIcon.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [frameButton setBackgroundVerticalPositionAdjustment:15.0f forBarMetrics:UIBarMetricsDefault];
    
    
    [adjustButton setBackgroundImage:[UIImage imageNamed:@"colorIcon.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [adjustButton setBackgroundVerticalPositionAdjustment:15.0f forBarMetrics:UIBarMetricsDefault];
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];

    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	
    
    if ([segue.identifier isEqualToString:@"editInfo"])
    {
        EditSketchInfoViewController * editSketchView=(EditSketchInfoViewController*) [segue destinationViewController];
        
        [editSketchView setEditSketch:currentSketch];
    }
    
    
}

-(void)loadSketch{

    NSData *data = [[NSData alloc] initWithContentsOfFile:currentSketch.pathFull];
    
    UIImage *mainImageLarge = [[UIImage alloc] initWithData:data];

    [mainImageView setImage:mainImageLarge];
    
    


}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    
    [self creaToolBar];
    SketchManager *sm =[SketchManager sharedSketchManager];
    
    currentSketch=sm.editedSketch;
    
    [self loadSketch];
    
    
    //Carica il viewController delle regolazioni e lo mette fuori schermo
    isAdjustVisible=FALSE;
    
    if (adjustView==nil) {
        adjustView= [[AdjustView alloc]   initWithFrame:CGRectMake(0, 500, 320, 170)];
        
        [adjustView setDelegate:self];
        
        [mainView addSubview:adjustView];

    }
    
    
    //Crea i filtri da utilizzare
    
    context = [CIContext contextWithOptions:nil];

    CIImage * filterPreviewImage =[[CIImage alloc]initWithImage:mainImageView.image];
    
    controlFilter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey,filterPreviewImage,nil];
    

}

- (void)viewDidUnload
{
    [self setToolBar:nil];
    [self setPenButton:nil];
    [self setShareButton:nil];
    [self setTrashButton:nil];
    [self setFrameButton:nil];
    [self setAdjustButton:nil];
    [self setFintaNavigationBar:nil];
    [self setMainImageView:nil];
    [self setMainView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



- (IBAction)editInfoButton:(id)sender {
    
    [self performSegueWithIdentifier:@"editInfo" sender:self];
}



//Commit di tutte le modifiche nel database
- (IBAction)saveButtonAction:(id)sender {
        
    DataManager *dm = [DataManager  sharedDataManager];
    
    
    NSManagedObjectContext *context = [dm managedObjectContext];
    
    [self saveSketchToDisk];
    
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]){
        NSLog(@"Error on save");
    }

    AlbumManager *am =[AlbumManager sharedAlbumManager];
    [am.istanceOfAlbumViewController reloadData];
    
    //TODO: deve salvare anche l' immagine
    
    
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
    
}



-(void)saveSketchToDisk
{

    UIImage *image = self.mainImageView.image;
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    
    // Write out the data.
    [imageData writeToFile:currentSketch.pathFull atomically:NO];
    
    
    //Salva il file dell' immmagine piccola
    UIImage *smallSketch = [image scaleToSize:CGSizeMake(image.size.width/scale_factor, image.size.height/scale_factor)];
    NSData *imageDataSmall = UIImageJPEGRepresentation(smallSketch, 0.5);
    
   
    [imageDataSmall writeToFile:currentSketch.pathSmall atomically:NO];


}


- (IBAction)cancelButtonAction:(id)sender {
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
    
}

- (IBAction)adjustButtonAction:(id)sender {
    
    
    if (isAdjustVisible) {
        
        [adjustView moveTo:CGPointMake(0, 500) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isAdjustVisible=FALSE;
    }else{
    
        [adjustView moveTo:CGPointMake(0, 290) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isAdjustVisible=TRUE;
    }
    
    
}



#pragma mark AdjustViewControllerDelegate method


-(void)AdjustView:(AdjustView *)sender didChangedBrightness:(NSNumber *)value
{
    [controlFilter setValue:value forKey:@"inputBrightness"];
    CIImage *outputImage = [controlFilter outputImage];
    
    CGImageRef cgimg =[context createCGImage:outputImage fromRect:[outputImage extent]];
    
    [mainImageView setImage: [UIImage imageWithCGImage:cgimg]];
    CGImageRelease(cgimg);


}

-(void)AdjustView:(AdjustView *)sender didChangedContrast:(NSNumber *)value
{
    [controlFilter setValue:value forKey:@"inputContrast"];
    CIImage *outputImage = [controlFilter outputImage];
    
    CGImageRef cgimg =[context createCGImage:outputImage fromRect:[outputImage extent]];
    
    [mainImageView setImage: [UIImage imageWithCGImage:cgimg]];
    CGImageRelease(cgimg);

}




@end
