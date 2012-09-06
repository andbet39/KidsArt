//
//  AlbumCell.m
//  kidsArt
//
//  Created by Andrea Terzani on 08/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "AlbumCell.h"

@implementation AlbumCell
@synthesize nameLabel;
@synthesize countLabel;
@synthesize copertinaImage;
@synthesize dateLabel;



-(void)initWithAlbum:(Album *)album
{
    [nameLabel setText:album.titolo];
    [countLabel setText:album.note];
    
    //[countLabel setText:[NSString stringWithFormat:@"%d",[album.album2sketch count] ]];
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *dataCreazione = album.dataCreazione;
    
    NSString *theDate = [dateFormat stringFromDate:dataCreazione];
    
    NSString * datalabel = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"CREATO_IL", nil),theDate];
    
    [dateLabel setText:datalabel];
    if ([album.album2sketch count]>0) {
    
        NSArray * sketchArray = [[album.album2sketch allObjects]sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            
            Sketch * sk1 = (Sketch*)obj1;
            Sketch * sk2 = (Sketch*)obj2;
            
            if (sk1.saveDate > sk2.saveDate) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if (sk1.saveDate < sk2.saveDate) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
            
        } ];
        
        Sketch *copertina = [sketchArray objectAtIndex:0];
        
              
        
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:copertina.pathSmall];
        UIImage *currentSketch = [[UIImage alloc] initWithData:data];
        [copertinaImage setImage:currentSketch];
        
    }
}

@end
