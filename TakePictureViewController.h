//
//  TakePcitureViewController.h
//  kidsArt
//
//  Created by Andrea Terzani on 08/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sketch.h"
#import "DataManager.h"
#import "UIImage+Scale.h"
#import "AlbumManager.h"
#import "CustomOverlayView.h"

@class TakePictureViewController;

@protocol TakePictureViewControllerDelegate <NSObject>
- (void)TakePictureViewControllerDidCancel:(TakePictureViewController *)controller;
- (void)TakePictureViewController: (TakePictureViewController *)controller DidAddSketch:(Sketch *)Sketch;
@end

@interface TakePictureViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,CustomOverlayViewDelegate>{


    CustomOverlayView * overlay;
    BOOL didCancel;

}

@property (nonatomic, strong) UIImagePickerController *picker;

@property(readwrite)bool isCameraOn;

@property (strong,nonatomic) id <TakePictureViewControllerDelegate> delegate;


- (void)takePicture;


@end
