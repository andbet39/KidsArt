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
    
    
    [nameLabel setFont:[UIFont fontWithName:@"Helvetica Rounded LT Std" size:22 ]];
    [countLabel setFont:[UIFont fontWithName:@"Helvetica Rounded LT Std" size:16]];
    [dateLabel setFont:[UIFont fontWithName:@"Helvetica Rounded LT Std" size:16]];
    
    
    
    
    [nameLabel setText:album.titolo];
    [countLabel setText:album.note];
    
    //[countLabel setText:[NSString stringWithFormat:@"%d",[album.album2sketch count] ]];
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *dataCreazione = album.dataCreazione;
    
    NSString *theDate = [dateFormat stringFromDate:dataCreazione];
    
    NSString * datalabel = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"CREATO_IL", nil),theDate];
    
    [dateLabel setText:datalabel];
    if ([album.album2sketch count]>0) {
    
       // NSMutableArray * sketchArray = [[NSMutableArray alloc]initWithArray:[album.album2sketch allObjects]];
        
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"saveDate" ascending:NO]];
        
        NSArray *sortedSketch = [[album.album2sketch allObjects] sortedArrayUsingDescriptors:sortDescriptors];
        
        NSMutableArray * sketchArray = [[NSMutableArray alloc]initWithArray:sortedSketch];
        
        
        Sketch *copertina = [sketchArray objectAtIndex:0];
        
              
        
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:copertina.pathSmall];
        UIImage *currentSketch = [[UIImage alloc] initWithData:data];
        [copertinaImage setImage:currentSketch];
        
    }else{
    
        [copertinaImage setImage:nil];

    }
}

@end
