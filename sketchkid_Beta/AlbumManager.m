//
//  AlbumManager.m
//  kidsArt
//
//  Created by Andrea Terzani on 08/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "AlbumManager.h"
static AlbumManager *sharedAlbumManager = nil;

@implementation AlbumManager

@synthesize selectedAlbum;
@synthesize  isSelectedAlbumUpdated;
@synthesize istanceOfHomeViewController;


#pragma mark Singleton Methods
+ (id)sharedAlbumManager {
    @synchronized(self) {
        if (sharedAlbumManager == nil)
            sharedAlbumManager = [[self alloc] init];
    }
    return sharedAlbumManager;
}



-(Album*)defaultAlbum{
    
    DataManager *dm = [DataManager sharedDataManager];
    
    
    NSManagedObjectContext *moc = [dm managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Album" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"order" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    
    
    if (array == nil)
    {
        // Deal with error...
    }
    if ([array count]>0) {
        return  [array objectAtIndex:0];

    }else{
        return nil;
    }

}

@end