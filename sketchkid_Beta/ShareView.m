//
//  ShareView.m
//  kidsArt
//
//  Created by Andrea Terzani on 31/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "ShareView.h"



@implementation ShareView
@synthesize mailButtonAction;
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"shareView" owner:self options:nil];
        UIView *mainView = [subviewArray objectAtIndex:0];
        [self addSubview:mainView];    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)FBshareButtonAction:(id)sender {
    
    [delegate shareViewdidFacebook:self];
    
}
- (IBAction)TWshareButtonAction:(id)sender {
    [delegate shareViewdidTwitter:self];
}
- (IBAction)mailButtonAction:(id)sender {
    [delegate shareViewdidMail:self];
}
@end
