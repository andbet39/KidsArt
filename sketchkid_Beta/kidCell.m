//
//  kidCell.m
//  kidsArt
//
//  Created by Andrea Terzani on 11/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "kidCell.h"

@implementation kidCell
@synthesize nomeLabel;
@synthesize fotoImage;

-(void)initWithKid:(Kid*)kid{

    [nomeLabel setText:kid.nome];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:kid.photoPath];
    UIImage *fotoBimbo = [[UIImage alloc] initWithData:data];
    [fotoImage setImage:fotoBimbo];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
