//
//  FrameSelectView.h
//  kidsArt
//
//  Created by Andrea Terzani on 29/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Frame.h"
@class FrameSelectView;

@protocol FrameSelectViewDelegate <NSObject>

-(void)FrameSelectView:(FrameSelectView*)sender didSelectFrame:(Frame *)frame;


@end

@interface FrameSelectView : UIView{

    NSMutableArray * frameName;
}

@property (weak, nonatomic) IBOutlet UIScrollView *frameScrollView;
@property (weak, nonatomic) IBOutlet UIView *selfView;

@property (strong,nonatomic) id <FrameSelectViewDelegate> delegate;


-(void)inizializza;




@end
