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
    [nomeLabel setFont:[UIFont fontWithName:@"Helvetica Rounded LT Std" size:22 ]];
    [nomeLabel setTextColor:RGB(0, 32, 64)];
    UIImage *fotoBimbo = [UIImage imageNamed:kid.photoPath];
    [fotoImage setImage:fotoBimbo];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
