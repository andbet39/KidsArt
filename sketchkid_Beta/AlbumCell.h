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


@property(nonatomic,strong)IBOutlet UILabel *nameLabel;
@property(nonatomic,strong)IBOutlet UILabel *countLabel;
@property(nonatomic,strong)IBOutlet UIImageView *copertinaImage;
@property(nonatomic,strong)IBOutlet UILabel *dateLabel;

-(void)initWithAlbum:(Album*)album;
@end
