//
//  AlbumCell.h
//  kidsArt
//
//  Created by Andrea Terzani on 08/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"
#import "Sketch.h"

@interface AlbumCell : UITableViewCell


@property(nonatomic,weak)IBOutlet UILabel *nameLabel;
@property(nonatomic,weak)IBOutlet UILabel *countLabel;
@property(nonatomic,weak)IBOutlet UIImageView *copertinaImage;
@property(nonatomic,weak)IBOutlet UILabel *dateLabel;

-(void)initWithAlbum:(Album*)album;
@end
