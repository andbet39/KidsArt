//
//  ATScrollView.m
//  kidsArt
//
//  Created by Andrea Terzani on 05/09/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "ATScrollView.h"

@implementation ATScrollView

@synthesize delegate;

@synthesize sketchArray;
@synthesize view2;
@synthesize view1;
@synthesize StartIndex;
@synthesize scrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)initATScrollviewWithSketchArray:(NSSet*) _sketchArray
{
    
    sketchArray = [[NSMutableArray alloc]initWithArray:[_sketchArray allObjects]];
    scrollView = [[UIScrollView alloc]init];
    
    
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.directionalLockEnabled = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.autoresizesSubviews = YES;
    scrollView.frame = CGRectMake(0, 0, 320, 480);
    
    
   // scrollView.maximumZoomScale=2.0;
    
    [self addSubview:scrollView];
    
    view1 = [[UIImageView alloc] init];
    [scrollView addSubview:view1];
    
    view2 = [[UIImageView alloc] init];
    [scrollView addSubview:view2];
    
    
    [self setImages];
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTapped)];
    [scrollView addGestureRecognizer:tap];
    
    
}

-(void)scrollTapped{
    
    [delegate ATScrollViewDidTapOnView:self];
}


- (void) setImages
{
	
    
    scrollView.contentSize = CGSizeMake([sketchArray count]*320, 320);
    [scrollView setContentOffset:CGPointMake( StartIndex*320,0) animated:YES];
    view1.frame = CGRectMake(0, 0, 320, 320);
	view2.frame = CGRectMake(320,0, 320, 320);
	
    
    Sketch * sk1 =[sketchArray objectAtIndex:StartIndex];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:sk1.pathFull];
    
    UIImage *sk1Image = [[UIImage alloc] initWithData:data];
	
    view1.image = sk1Image;
    
    
    if ([sketchArray count]>StartIndex+1 && [sketchArray count]>1) {
        Sketch * sk2 = [sketchArray objectAtIndex:StartIndex+1];
        NSData *data = [[NSData alloc] initWithContentsOfFile:sk2.pathFull];
        
        UIImage *sk2Image = [[UIImage alloc] initWithData:data];
        
        view2.image = sk2Image;
    }
    
    
    
	
}
/****per il momento non si fa
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return activeView;
}
*/


- (void) scrollViewDidScroll:(UIScrollView *) scrollView
{
	[self updateScroll];
}


- (void) updateScroll
{
	CGFloat pageWidth = 320;
    
	float currPos = scrollView.contentOffset.x;
	
	int selectedPage = roundf(currPos / pageWidth);
	
    
    
	float truePosition = selectedPage*pageWidth;
	
	int zone = selectedPage % 2;
	
	BOOL view1Active = zone == 0;
	
	UIImageView *nextView = view1Active ? view2 : view1;
	activeView = view1Active ? view1 : view2;
    
	int nextpage = truePosition > currPos ? selectedPage-1 : selectedPage+1;
	
	if(nextpage >= 0 && nextpage < [sketchArray count])
	{
		if((view1Active && nextpage == view1Index) || (!view1Active && nextpage == view2Index)) return;
		
		nextView.frame = CGRectMake(nextpage*320, 0, 320, 320);
        Sketch *sk = [sketchArray objectAtIndex:nextpage];
        
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:sk.pathFull];
        
        UIImage *mainImageLarge = [[UIImage alloc] initWithData:data];
        
		nextView.image =    mainImageLarge;
		
		if(view1Active) view1Index = nextpage;
		else view2Index = nextpage;
        
	}
}


@end
