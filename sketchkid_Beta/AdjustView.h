//
//  adjustView.h
//  kidsArt
//
//  Created by Andrea Terzani on 28/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+Animation.h"


@class AdjustView;

@protocol AdjustViewDelegate <NSObject>

-(void)AdjustView:(AdjustView*)sender didChangedBrightness:(NSNumber*)value;
-(void)AdjustView:(AdjustView*)sender didChangedContrast:(NSNumber*)value;


@end


@interface AdjustView : UIView

- (IBAction)contrastChanged:(id)sender;
- (IBAction)brightnessChanged:(id)sender;
-(void)setVisible:(bool)isVisible;

@property (strong,nonatomic) id <AdjustViewDelegate> delegate;



@end
