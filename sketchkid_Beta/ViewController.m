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
@synthesize activityIndicator;
@synthesize scrollView;
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
    
    AlbumManager *am =[AlbumManager sharedAlbumManager];
    
    currentAlbum = am.selectedAlbum;
    self.wantsFullScreenLayout=TRUE;

    CGRect screenFrame = [UIScreen mainScreen].bounds;
    [mainView setFrame:screenFrame];
    scrollView = [[ATScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    [scrollView initATScrollviewWithSketchArray:currentAlbum.album2sketch];
    [scrollView setUserInteractionEnabled:TRUE];
    [scrollView setDelegate:self];
    [mainView addSubview:scrollView];
    
    
    //Carica il viewController delle regolazioni e lo mette fuori schermo
    isAdjustVisible=FALSE;
    
    if (adjustView==nil) {
        adjustView= [[AdjustView alloc]   initWithFrame:CGRectMake(0, 500, 320, 170)];
        
        [adjustView setDelegate:self];
        
        [mainView addSubview:adjustView];
        
    }
    //Carica il viewController delle cornici
    isFrameVisible=FALSE;
    
    if (frameView==nil) {
        frameView= [[FrameSelectView alloc]   initWithFrame:CGRectMake(0, 500, 320, 170)];
        
        //[frameView setDelegate:self];
        [frameView inizializza];
        [mainView addSubview:frameView];
        
    }
    
    
    //Carica il viewController della condivisione
    isShareVisible=FALSE;
    
    if (shareView==nil) {
        shareView = [[ShareView alloc]   initWithFrame:CGRectMake(0, 500, 320, 170)];
        
        [shareView setDelegate:self];
        [mainView addSubview:shareView];
        
    }
    
    isInterfaceVisible=TRUE;
    
    
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
    [self setActivityIndicator:nil];
    [self setScrollView:nil];
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
    [am.istanceOfHomeViewController reloadAlbumData];
    
    

    
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
    //nasconde i frame prima di far vedere l altra

    if (isFrameVisible) {
        
        [frameView moveTo:CGPointMake(0, 500) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isFrameVisible=FALSE;
    }
    if (isShareVisible) {
        
        [shareView moveTo:CGPointMake(0, 500) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isShareVisible=FALSE;
    }
    
    
    if (isAdjustVisible) {
        
        [adjustView moveTo:CGPointMake(0, 500) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isAdjustVisible=FALSE;
    }else{
    
        [adjustView moveTo:CGPointMake(0, 245) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isAdjustVisible=TRUE;
    }
    
    
}

- (IBAction)frameButtonAction:(id)sender {
    
    //nasconde l' adjust prima di far vedere l altra
    if (isAdjustVisible) {
        
        [adjustView moveTo:CGPointMake(0, 500) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isAdjustVisible=FALSE;
    }
    if (isShareVisible) {
        
        [shareView moveTo:CGPointMake(0, 500) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isShareVisible=FALSE;
    }
    
    if (isFrameVisible) {
        
        [frameView moveTo:CGPointMake(0, 500) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isFrameVisible=FALSE;
    }else{
        
        [frameView moveTo:CGPointMake(0, 245) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isFrameVisible=TRUE;
    }
    
    
    
}

- (IBAction)sharebuttonAction:(id)sender {
    
    //nasconde l' adjust prima di far vedere l altra
    if (isAdjustVisible) {
        
        [adjustView moveTo:CGPointMake(0, 500) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isAdjustVisible=FALSE;
    }
    if (isFrameVisible) {
        
        [frameView moveTo:CGPointMake(0, 500) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isShareVisible=FALSE;
    }
    
    if (isShareVisible) {
        
        [shareView moveTo:CGPointMake(0, 500) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isShareVisible=FALSE;
    }else{
        
        [shareView moveTo:CGPointMake(0, 245) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isShareVisible=TRUE;
    }
}

- (IBAction)deleteButtonAction:(id)sender {
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ALLERT", nil) message:NSLocalizedString(@"ALLERT_CANCELLA_DISEGNO", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ANNULLA", nil) otherButtonTitles:@"OK", nil];
    [alertView show];
}



#pragma mark ATScrollView Delegate

-(void)ATScrollViewDidTapOnView:(ATScrollView *)sender
{
    if (isInterfaceVisible) {

        //nascondo tutti i pannelli
        isInterfaceVisible=FALSE;
        [adjustView moveTo:CGPointMake(0, 500) duration:0.1 option:UIViewAnimationCurveEaseOut];
        isAdjustVisible=FALSE;
        [frameView moveTo:CGPointMake(0, 500) duration:0.1 option:UIViewAnimationCurveEaseOut];
        isShareVisible=FALSE;
        [shareView moveTo:CGPointMake(0, 500) duration:0.1 option:UIViewAnimationCurveEaseOut];
        isShareVisible=FALSE;
        
        
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        [self showBars:FALSE animated:NO];

        [scrollView.scrollView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];

        [scrollView.scrollView setScrollEnabled:TRUE];
        
        
        
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        [self showBars:TRUE animated:NO];

        [scrollView.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];

        isInterfaceVisible=TRUE;

        [scrollView.scrollView setScrollEnabled:false];

        
    }
    
}



#pragma mark allertview delegate


- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        // È stato premuto il bottone Cancel
    } else if (buttonIndex == 1){

        
        
        DataManager *dm = [DataManager sharedDataManager];
        
        
        NSManagedObjectContext *moc = [dm managedObjectContext];
        
        [moc deleteObject:currentSketch];
        
        // Save the context.
        NSError *error = nil;
        if (![moc save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        
        
        AlbumManager *am = [AlbumManager sharedAlbumManager];
        
        //[am setSelectedAlbum:[am defaultAlbum]];
        
        [am.istanceOfHomeViewController reloadAlbumData];
        [am.istanceOfAlbumViewController reloadData];
        
        [self.navigationController dismissModalViewControllerAnimated:YES];

        
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


#pragma mark shareViewDelegate method
-(void)shareViewdidFacebook:(ShareView *)sender{
    
    if (FBSession.activeSession.isOpen) {
        // login is integrated with the send button -- so if open, we send
        [self sendFBRequests];

    } else {
        [FBSession openActiveSessionWithPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session,
                                                      FBSessionState status,
                                                      NSError *error) {
                                      // if login fails for any reason, we alert
                                      if (error) {
                                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                          message:error.localizedDescription
                                                                                         delegate:nil
                                                                                cancelButtonTitle:@"OK"
                                                                                otherButtonTitles:nil];
                                          [alert show];
                                          // if otherwise we check to see if the session is open, an alternative to
                                          // to the FB_ISSESSIONOPENWITHSTATE helper-macro would be to check the isOpen
                                          // property of the session object; the macros are useful, however, for more
                                          // detailed state checking for FBSession objects
                                      } else  {
                                          // send our requests if we successfully logged in
                                          [self sendFBRequests];
                                      }
                                  }];
    }

}



-(void)shareViewdidTwitter:(ShareView *)sender{
   
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    NSString *mess;
    
    if (currentSketch.kid==nil) {
        mess = NSLocalizedString(@"DISEGNO_KIDART", nil );
        
    }else{
        mess = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"DISEGNO_FATTO_DA", nil),currentSketch.kid.nome];
    }
    [twitter setInitialText:mess];
    
    [twitter addImage:[mainImageView.image scaleToSize:CGSizeMake(mainImageView.image.size.width/FBscale_factor, mainImageView.image.size.height/FBscale_factor)]];
                        
    [self presentViewController:twitter animated:YES completion:nil];
                        
                        
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult res) {
                            
        if(res == TWTweetComposeViewControllerResultDone) {
                        
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"The Tweet was posted successfully." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
                                                      
                [alert show];
                                                      
        }
       if(res == TWTweetComposeViewControllerResultCancelled) {
       
           UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Cancelled" message:@"You Cancelled posting the Tweet." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
                                                                                
        [alert show];    
                                                                                
       }
    [self dismissModalViewControllerAnimated:YES];
                                                                                
                                                                                };
                                                                                

}

#pragma mark Facebook method
- (void)sendFBRequests {

    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = NSLocalizedString(@"CONDIVIDENDO", nil);
    
    UIImage  * FBImage = [mainImageView.image scaleToSize:CGSizeMake(mainImageView.image.size.width/FBscale_factor, mainImageView.image.size.height/FBscale_factor)];
    NSString *mess;
    
    if (currentSketch.kid==nil) {
        mess = NSLocalizedString(@"DISEGNO_KIDART", nil );

    }else{
        mess = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"DISEGNO_FATTO_DA", nil),currentSketch.kid.nome];
    }
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   FBImage ,@"source",
                                   mess, @"message",
								   nil];
	
     
    [FBRequestConnection startWithGraphPath:@"me/photos" parameters:params HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        //Nasconde la finestra di avanzamento
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        //Nasconde il pannello di sharing
        [shareView moveTo:CGPointMake(0, 500) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isShareVisible=FALSE;
        
        //Mostra un allert
        [self showAlert:NSLocalizedString(@"FOTOSHARED", nil) result:result error:error];
    }];
     
}

// UIAlertView helper for post buttons
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {
    
    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertMsg = error.localizedDescription;
        alertTitle =NSLocalizedString(@"ERRORE", nil);
    } else {
        NSDictionary *resultDict = (NSDictionary *)result;
        alertMsg =NSLocalizedString(@"SUCCESSOFBPOST", nil);
        alertTitle = NSLocalizedString(@"SUCCESSO", nil);
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)showBars:(BOOL)show animated:(BOOL)animated {
    
    CGFloat alpha = show ? 1 : 0;
    if (alpha == toolBar.alpha)
        return;
    
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationDelegate:self];
        if (show) {
            [UIView setAnimationDidStopSelector:@selector(showBarsAnimationDidStop)];
            
        } else {
            [UIView setAnimationDidStopSelector:@selector(hideBarsAnimationDidStop)];
        }
        
    } else {
        if (show) {
            [self showBarsAnimationDidStop];
            
        } else {
            [self hideBarsAnimationDidStop];
        }
    }
    
    //[self showCaptions:show];
    
    toolBar.alpha = alpha;
    
    if (animated) {
        [UIView commitAnimations];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showBarsAnimationDidStop {
    self.navigationController.navigationBarHidden = NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)hideBarsAnimationDidStop {
    self.navigationController.navigationBarHidden = YES;
}

@end
