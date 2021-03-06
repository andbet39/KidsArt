//
//  ViewController.m
//  sketchkid_Beta
//
//  Created by Andrea Terzani on 04/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "ViewController.h"


#define kVIEW_BASE 300


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
@synthesize frameImageView;





-(void)creaToolBar{
    
    int toolbarheight=82;

    [toolBar setFrame:CGRectMake(0, self.view.frame.size.height-toolbarheight, 320, toolbarheight)];     
    [toolBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"toolBarBack.png"]]];
    
    
    
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share_hover.png"] forState:UIControlStateHighlighted];
    [penButton setBackgroundImage:[UIImage imageNamed:@"caption_hover.png"] forState:UIControlStateHighlighted];
    [trashButton setBackgroundImage:[UIImage imageNamed:@"trash_hover.png"] forState:UIControlStateHighlighted];
    [adjustButton setBackgroundImage:[UIImage imageNamed:@"img_edit_hover.png"] forState:UIControlStateHighlighted];
    [frameButton setBackgroundImage:[UIImage imageNamed:@"frame_hover.png"] forState:UIControlStateHighlighted];
       
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
    
  
    CGRect fullscreenFrame= CGRectMake(0,-62,320,480);
    [mainView setFrame: fullscreenFrame];

    sketchArray = [[NSMutableArray alloc]initWithArray:[currentAlbum.album2sketch allObjects]];
    scrollView = [[ATPhotoScrollView alloc]init];
    [scrollView setSketchArray:sketchArray];
    [scrollView setDelegate:self];

    
    [mainView addSubview:scrollView.view];
    [scrollView setToIndex:[sketchArray indexOfObject:currentSketch]];
    [scrollView disableZoomAndScroll];

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
        [frameView setDelegate:self];
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
    
    mainImageView=[scrollView getCurrentImageView];
    
    [self resetFilter];
       
        
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
    
    
    NSManagedObjectContext *_context = [dm managedObjectContext];
    
    [self saveSketchToDisk];
    
    
    // Save the context.
    NSError *error = nil;
    if (![_context save:&error]){
        NSLog(@"Error on save");
    }

    AlbumManager *am =[AlbumManager sharedAlbumManager];
    
    [am.istanceOfAlbumViewController reloadData];
    [am.istanceOfHomeViewController reloadAlbumData];
    
    

    
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
    
}



-(void)saveSketchToDisk
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.mainView animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = NSLocalizedString(@"SALVANDO", nil);
    
    UIImage *image = self.mainImageView.image;

    UIImage  * smallSketch = [self.mainImageView.image scaledCopyOfSize:CGSizeMake(floor(image.size.width/scale_factor), floor(image.size.height/scale_factor))];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    NSData *imageDataSmall = UIImageJPEGRepresentation(smallSketch, 0.5);

    // Write out the data.
    [imageData writeToFile:currentSketch.pathFull atomically:NO];
    [imageDataSmall writeToFile:currentSketch.pathSmall atomically:NO];
    

    [MBProgressHUD hideHUDForView:self.mainView animated:YES];

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
    
        [adjustView moveTo:CGPointMake(0, kVIEW_BASE) duration:0.5 option:UIViewAnimationCurveEaseOut];
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
        
        [frameView moveTo:CGPointMake(0, kVIEW_BASE) duration:0.5 option:UIViewAnimationCurveEaseOut];
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
        
        [shareView moveTo:CGPointMake(0, kVIEW_BASE) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isShareVisible=TRUE;
    }
}

- (IBAction)deleteButtonAction:(id)sender {
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ALLERT", nil) message:NSLocalizedString(@"ALLERT_CANCELLA_DISEGNO", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ANNULLA", nil) otherButtonTitles:@"OK", nil];
    [alertView show];
}



#pragma mark ATPhotoScrollView Delegate

-(void)ATPhotoScrollViewDidTapOnView:(ATPhotoScrollView*)sender withIndex:(NSUInteger)index andImageview:(UIImageView *)photoview;
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
        
        [sender enableZoomAndScroll ];
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        [self showBars:FALSE animated:NO];

        CGRect fullscreenFrame= CGRectMake(0,0,320,480);
        [mainView setFrame: fullscreenFrame];
        
        
        
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        [self showBars:TRUE animated:NO];

        [sender disableZoomAndScroll ];

        isInterfaceVisible=TRUE;

        CGRect fullscreenFrame= CGRectMake(0,-62,320,480);
        [mainView setFrame: fullscreenFrame];
        
        currentSketch = [sketchArray objectAtIndex:index];
        
        SketchManager *sm =[SketchManager sharedSketchManager];
        
        sm.editedSketch=currentSketch;
        
        mainImageView=photoview;
        
        [self resetFilter];
        
    }
    
}

-(void)resetFilter{

    //Crea i filtri da utilizzare
    
    context = [CIContext contextWithOptions:nil];
    
    CIImage * filterPreviewImage =[[CIImage alloc]initWithImage:mainImageView.image];
    
    controlFilter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey,filterPreviewImage,nil];
    


}


#pragma mark allertview delegate


- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        // È stato premuto il bottone Cancel
    } else if (buttonIndex == 1){

        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSError *error;

        DataManager *dm = [DataManager sharedDataManager];
        
        
        NSManagedObjectContext *moc = [dm managedObjectContext];
        
        
        if ([fileMgr removeItemAtPath:currentSketch.pathFull error:&error] != YES)
            NSLog(@"Unable to delete file: %@", [error localizedDescription]);
        if ([fileMgr removeItemAtPath:currentSketch.pathSmall error:&error] != YES)
            NSLog(@"Unable to delete file: %@", [error localizedDescription]);
        
        
        [moc deleteObject:currentSketch];
        
        // Save the context.
        if (![moc save:&error]) {
             NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        

        AlbumManager *am = [AlbumManager sharedAlbumManager];
                
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


#pragma mark frameSelectviewDelegate
-(void)FrameSelectView:(FrameSelectView *)sender didSelectFrame:(Frame *)frame
{
    //Nasconde la view
    if (isFrameVisible) {
        
        [frameView moveTo:CGPointMake(0, 500) duration:0.5 option:UIViewAnimationCurveEaseOut];
        isFrameVisible=FALSE;
    }
    
                       
    if (mainImageView.image.size.width>mainImageView.image.size.height) {
        UIImage *sketch = [mainImageView.image scaleToSize:CGSizeMake(660, 485)];

        mainImageView.image= [sketch addFrame:[UIImage imageNamed:frame.image_o] inPoint:CGPointMake(70, 70)];

    }else{
        UIImage *sketch = [mainImageView.image scaleToSize:CGSizeMake(485, 660)];

        UIImage *cornice =[[UIImage imageNamed:frame.image_o]imageRotatedByDegrees:90];
        mainImageView.image= [sketch addFrame:cornice inPoint:CGPointMake(70, 70)];

    }

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
                        
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"SUCCESSO", nil) message:NSLocalizedString(@"SUCCESS_TWEET", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                                                      
                [alert show];
                                                      
        }
       if(res == TWTweetComposeViewControllerResultCancelled) {
       
           UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"CANCELLED", nil) message:NSLocalizedString(@"CANCELLED_TWEET", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                                                                                
        [alert show];    
                                                                                
       }
    [self dismissModalViewControllerAnimated:YES];
                                                                                
                                                                            };
                                                                                

}

-(void)shareViewdidMail:(ShareView *)sender
{

    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    NSString *mess;
    
    if (currentSketch.kid==nil) {
        mess = NSLocalizedString(@"DISEGNO_KIDART", nil );
        
    }else{
        mess = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"DISEGNO_FATTO_DA", nil),currentSketch.kid.nome];
    }
    
    // Set the subject of email
    [picker setSubject:mess];
    
   
    // Fill out the email body text
    NSString *emailBody = @"";
    
    // This is not an HTML formatted email
    [picker setMessageBody:emailBody isHTML:YES];
    
    // Create NSData object as PNG image data from camera image
    NSData *data = UIImagePNGRepresentation(mainImageView.image);
    
    // Attach image data to the email
    // 'CameraImage.png' is the file name that will be attached to the email
    [picker addAttachmentData:data mimeType:@"image/png" fileName:@"Sketch"];
    
    // Show email view
    [self presentModalViewController:picker animated:YES];
    
    

}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Called once the email is sent
    // Remove the email view controller
    [self dismissModalViewControllerAnimated:YES];
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
