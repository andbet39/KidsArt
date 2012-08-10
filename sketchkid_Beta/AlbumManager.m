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
@synthesize istanceOfAlbumViewController;

#pragma mark Singleton Methods
+ (id)sharedAlbumManager {
    @synchronized(self) {
        if (sharedAlbumManager == nil)
            sharedAlbumManager = [[self alloc] init];
    }
    return sharedAlbumManager;
}

-(int)getMaxOrder
{
    DataManager *dm = [DataManager sharedDataManager];
    
    
    NSManagedObjectContext *moc = [dm managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *res = [NSEntityDescription entityForName:@"Album" inManagedObjectContext:moc];
    [request setEntity:res];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
 

    [request setFetchLimit:1];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];

    if (results == nil) {
        NSLog(@"error fetching the results: %@",error);
    }
    
    NSInteger maximumValue = 0;
    if (results.count == 1) {
        Album *result = (Album*)[results objectAtIndex:0];
        maximumValue =  [result.order integerValue];
    }

    return maximumValue;

}


-(Album*)defaultAlbum{
    
    DataManager *dm = [DataManager sharedDataManager];
    
    
    NSManagedObjectContext *moc = [dm managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Album" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"isDefault == 1"]];
    
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