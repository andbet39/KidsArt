//
//  AppDelegate.m
//  sketchkid_Beta
//
//  Created by Andrea Terzani on 04/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBSession.activeSession handleOpenURL:url];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    bool value;
    value = [prefs boolForKey:@"isFirstRun"];
    
    if (value==0) {
        [self creaDefaultAlbum];
        [prefs setBool:1 forKey:@"isFirstRun"];
        [prefs synchronize];
    }
    
    
    [[UIBarButtonItem appearance] setTintColor:RGB(117, 24, 154)];
    [[UITextField appearance]setFont:[UIFont fontWithName:@"Helvetica Rounded LT Std" size:18]];
    [[UITextField appearance]setTextColor:RGB(0, 32, 64)];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
    if (FBSession.activeSession.state == FBSessionStateCreatedOpening) {
        [FBSession.activeSession close]; // so we close our session and start over
    }*/
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [FBSession.activeSession close];

}



- (void)creaDefaultAlbum {
    
    DataManager *dm =[DataManager sharedDataManager];
    
    Album *defaultAlbum = (Album *)[NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:dm.managedObjectContext];
    
    
    [defaultAlbum setTitolo:NSLocalizedString(@"NOME_DEFAULT_ALBUM",nil)];
    [defaultAlbum setOrder:[NSDecimalNumber numberWithInt:0]];
    [defaultAlbum setNote:NSLocalizedString(@"NOTA_DEFAULT_ALBUM",nil)];
    [defaultAlbum setDataCreazione:[NSDate date]];
    [defaultAlbum setIsDefault:[NSNumber numberWithInt:1]];
    //[defaultAlbum setCopertinaPath:]
    
    UIImage *firsrImage=[UIImage imageNamed:@"home.jpg"];
    
    
    
    
    NSManagedObjectContext *context = [dm managedObjectContext];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]){
        
    }
    
    Sketch* save =[self saveSketch:firsrImage];
    
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

@end
