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
    
    [shareButton setBackgroundImage:[UIImage imageNamed:@"pen_icon.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [shareButton setBackgroundVerticalPositionAdjustment:15.0f forBarMetrics:UIBarMetricsDefault];
    
    [trashButton setBackgroundImage:[UIImage imageNamed:@"pen_icon.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [trashButton setBackgroundVerticalPositionAdjustment:15.0f forBarMetrics:UIBarMetricsDefault];
    
    
    [frameButton setBackgroundImage:[UIImage imageNamed:@"pen_icon.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [frameButton setBackgroundVerticalPositionAdjustment:15.0f forBarMetrics:UIBarMetricsDefault];
    
    
    [adjustButton setBackgroundImage:[UIImage imageNamed:@"pen_icon.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
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
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]){
        
    }

        
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
    
}

- (IBAction)cancelButtonAction:(id)sender {
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
    
}
@end
