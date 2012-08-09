//
//  CustomOverlayView.m
//  kidsArt
//
//  Created by Andrea Terzani on 09/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "CustomOverlayView.h"

@implementation CustomOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Add the bottom bar
        UIImage *image = [UIImage imageNamed:@"toolBackHome"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 380, 320, 100);
        [self addSubview:imageView];
        
        
        // Add the capture button
        self.pictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.pictureButton.frame = CGRectMake(94, 385, 130, 100);
        UIImage *buttonImageNormal = [UIImage imageNamed:@"cameraIcon.png"];
        [self.pictureButton setImage:buttonImageNormal forState:UIControlStateNormal];
        [self.pictureButton setImage:buttonImageNormal forState:UIControlStateDisabled];
        [self.pictureButton addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.pictureButton];
    }
    return self;
}


- (void)takePicture:(id)sender
{
    self.pictureButton.enabled = NO;
    [self.delegate takePicture];
}

-(void)didCancel:(id)sender{



}
@end
