//
//  FrameSelectView.h
//  kidsArt
//
//  Created by Andrea Terzani on 29/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrameSelectView : UIView

@property (weak, nonatomic) IBOutlet UIScrollView *frameScrollView;
@property (weak, nonatomic) IBOutlet UIView *selfView;

-(void)inizializza;

@end
