//
//  FrameSelectView.m
//  kidsArt
//
//  Created by Andrea Terzani on 29/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "FrameSelectView.h"

@implementation FrameSelectView
@synthesize frameScrollView;
@synthesize selfView;



-(void) inizializzaLista
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"frameList.plist"];
    
    
    NSDictionary * rootDictionary = [NSDictionary dictionaryWithContentsOfFile:finalPath] ;
    
    
    NSDictionary *frameList = (NSDictionary*) [rootDictionary objectForKey:@"frames"];
    int offsetX =10;
    
    int maxX=0;
    
    
    
    for(NSString * key in frameList)
    {
        
        
        NSDictionary * frame = (NSDictionary*) [frameList objectForKey:key];
        UIView *frameView = [[UIView alloc] initWithFrame:CGRectMake(offsetX, 0, 60, 60)];
        [frameView setBackgroundColor:[UIColor clearColor]];
        
        // create a label to display the name
        UILabel *frameNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frameView.bounds.size.width, 8)];
        
        
        frameNameLabel.center = CGPointMake(frameView.bounds.size.width/2, frameView.bounds.size.height + frameNameLabel.bounds.size.height);
        
        [frameNameLabel setText:[frame valueForKey:@"name"]];
        
        frameNameLabel.backgroundColor = [UIColor clearColor];
        frameNameLabel.textColor = [UIColor whiteColor];
        frameNameLabel.font = [UIFont fontWithName:@"AppleColorEmoji" size:10];
        frameNameLabel.textAlignment = UITextAlignmentCenter;

        // create filter preview image views
        UIImageView *framePreviewImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[frame valueForKey:@"sample"]]];
        
        
        [frameView setUserInteractionEnabled:YES];
        
        framePreviewImageView.layer.cornerRadius = 2;
        framePreviewImageView.opaque = NO;
        framePreviewImageView.backgroundColor = [UIColor blueColor];
        framePreviewImageView.layer.masksToBounds = YES;
        framePreviewImageView.frame = CGRectMake(0, 0, 60, 60);
        
//        frameView.tag = index;

            
        //[self applyGesturesToFilterPreviewImageView:filterView];
        
        [frameView addSubview:framePreviewImageView];
        [frameView addSubview:frameNameLabel];
        
        [self.frameScrollView addSubview:frameView];
        
        offsetX += frameView.bounds.size.width + 10;
        maxX+=70;
    }
    
    [self.frameScrollView setContentSize:CGSizeMake(maxX, 60)];
    
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"frameSelectView" owner:self options:nil];
        UIView *mainView = [subviewArray objectAtIndex:0];
        [self addSubview:mainView];
        selfView =mainView;
        
        
    }
    return self;
}
    
    
-(void)inizializza{

    [self inizializzaLista];
}



@end
