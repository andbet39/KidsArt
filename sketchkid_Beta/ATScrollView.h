//
//  ATScrollView.h
//  kidsArt
//
//  Created by Andrea Terzani on 05/09/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ATScrollView;

@protocol ATScrollViewDelegate <NSObject>

-(void)ATScrollViewDidTapOnView:(ATScrollView*)sender;

@end
@interface ATScrollView : UIView<UIScrollViewDelegate>{


    int view1Index;
    int view2Index;
    UIImageView *activeView;
    

}

@property (strong,nonatomic) id <ATScrollViewDelegate> delegate;


-(void)initATScrollviewWithSketchArray:(NSArray*) _sketchArray;

@property (strong, nonatomic) IBOutlet UIImageView *view1;
@property (strong, nonatomic) IBOutlet UIImageView *view2;

@property (strong,nonatomic)IBOutlet UIScrollView  * scrollView;

@property(strong,nonatomic)NSMutableArray *sketchArray;
@property(readwrite)int StartIndex;

@end
