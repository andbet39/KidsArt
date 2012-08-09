//
//  CustomOverlayView.h
//  kidsArt
//
//  Created by Andrea Terzani on 09/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomOverlayView;

@protocol CustomOverlayViewDelegate <NSObject>
- (void)takePicture;
@end

@interface CustomOverlayView : UIView

@property (strong,nonatomic) id <CustomOverlayViewDelegate>   delegate;
@property (nonatomic, weak) UIButton *pictureButton;


@end
