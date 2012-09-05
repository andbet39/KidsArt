//
//  TakePcitureViewController.m
//  kidsArt
//
//  Created by Andrea Terzani on 08/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "TakePictureViewController.h"

#define scale_factor 5

@interface TakePictureViewController ()
{
    UIImagePickerController *imagePickerController;
}


@end

@implementation TakePictureViewController
@synthesize isCameraOn;
@synthesize picker;




-(Sketch*)saveSketch:(UIImage*)finalImage
{
    
    DataManager *dm =[DataManager sharedDataManager];
    
    Sketch *sketch = (Sketch *)[NSEntityDescription insertNewObjectForEntityForName:@"Sketch" inManagedObjectContext:dm.managedObjectContext];
    
    UIImage *image =[finalImage scaledCopyOfSize:CGSizeMake(800,600)];
    
    

    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:locale];
    [dateFormatter setDateFormat:@"yyyyMMdd-HHmmssSSS"];
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
    UIImage *smallSketch = [image scaleToSize:CGSizeMake(image.size.width/scale_factor, image.size.height/scale_factor)];
    NSData *imageDataSmall = UIImageJPEGRepresentation(smallSketch, 0.5);
    
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

-(void)scattaFoto{

    [self showCamera];

}

- (void) showCamera
{
    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Must be NO.
    self.picker.showsCameraControls = NO;
    
    self.picker.cameraViewTransform =
    CGAffineTransformScale(self.picker.cameraViewTransform, 1, 1);
    
    
    self.picker.cameraOverlayView = overlay;
    
    // If the user cancelled the selection of an image in the camera roll, we have to call this method
    // again.
    if (!didCancel) {
        [self presentModalViewController:self.picker animated:NO];
    } else {
        didCancel = NO;
    }   
}

#pragma mark CustomOverlayViewDelegate
- (void)CustomOverlaytakePicture
{
    [picker takePicture];
}

-(void)CustomOverlaydidCancel
{
    [self dismissModalViewControllerAnimated:NO];
    [self.delegate TakePictureViewControllerDidCancel:self];

}


//Salva tutte le immagini fatte fino a questo momento e chiude il controller

-(void)CustomOverlaydidDone{
    
    
    //Salva tutte le immagini
    for (UIImage * i in tempPictureArray) {
        
        [self saveSketch:i];
    }
    
    
    [self dismissModalViewControllerAnimated:NO];
    [self.delegate TakePictureViewControllerDidAddSomePhoto:self];

}



-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * capturedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [tempPictureArray addObject:capturedImage];
   
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [self dismissModalViewControllerAnimated:NO];
    [self.delegate TakePictureViewControllerDidCancel:self];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    overlay = [[CustomOverlayView alloc] initWithFrame:CGRectMake(0, 0, 320  , 480)];
    overlay.delegate = self;
    
    
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    self.picker.navigationBarHidden = YES;
    self.picker.toolbarHidden = YES;
    self.picker.wantsFullScreenLayout = YES;
    
    self.isCameraOn=FALSE;
    
    
    tempPictureArray = [[NSMutableArray alloc]init];
    [self scattaFoto];
    
       
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.isCameraOn) {
        
    }else{
            
        [self scattaFoto];
        self.isCameraOn=TRUE;

    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end
