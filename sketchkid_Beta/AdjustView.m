//
//  adjustView.m
//  kidsArt
//
//  Created by Andrea Terzani on 28/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "AdjustView.h"

@implementation AdjustView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"adjustView" owner:self options:nil];
        UIView *mainView = [subviewArray objectAtIndex:0];
        [self addSubview:mainView];
        
    }
    return self;
}


- (IBAction)contrastChanged:(id)sender {
    
    UISlider *send = sender;
    
    NSNumber * value = [NSNumber numberWithFloat:send.value];
    
    [delegate AdjustView:self didChangedContrast:value];
    
}

- (IBAction)brightnessChanged:(id)sender {
    UISlider *send = sender;
    
    NSNumber * value = [NSNumber numberWithFloat:send.value];
    
    [delegate AdjustView:self didChangedBrightness:value];
}
@end
