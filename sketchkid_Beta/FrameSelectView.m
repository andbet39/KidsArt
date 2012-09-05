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
@synthesize delegate;


-(void) inizializzaLista
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"frameList.plist"];
    
    
    NSDictionary * rootDictionary = [NSDictionary dictionaryWithContentsOfFile:finalPath] ;
    
    
    NSDictionary * frameList = (NSDictionary*) [rootDictionary objectForKey:@"frames"];
    frameName=[[NSMutableArray alloc]init];
    int offsetX =10;
    
    int maxX=0;
    
    int index=0;
    
    for(NSString * key in frameList)
    {
        
        [frameName addObject:key];
        
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
        
        framePreviewImageView.tag= index;
        index++;
        
            
        [self applyGesturesToFilterPreviewImageView:framePreviewImageView];
        
        [frameView addSubview:framePreviewImageView];
        [frameView addSubview:frameNameLabel];
        
        [self.frameScrollView addSubview:frameView];
        
        offsetX += frameView.bounds.size.width + 10;
        maxX+=70;
        
        
    }
    
    [self.frameScrollView setContentSize:CGSizeMake(maxX, 60)];
    
}

-(void )applyGesturesToFilterPreviewImageView:(UIImageView *)framePreviewImageView{
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [framePreviewImageView setUserInteractionEnabled:YES];
    [framePreviewImageView addGestureRecognizer:tap];

    
}


-(void)viewTapped:(id)sender{

    int index = [(UITapGestureRecognizer *) sender view].tag;
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"frameList.plist"];
    
    
    NSDictionary * rootDictionary = [NSDictionary dictionaryWithContentsOfFile:finalPath] ;
    
    
    NSDictionary * frameList = (NSDictionary*) [rootDictionary objectForKey:@"frames"];
    
    
    NSDictionary * frame = (NSDictionary*) [frameList objectForKey:[frameName objectAtIndex:index]];

    Frame * fr = [[Frame alloc]init];
    
    
    [fr setName:[frame valueForKey:@"name"]];
    [fr setSample:[frame valueForKey:@"sample"]];
    [fr setImage_o:[frame valueForKey:@"image_o"]];
    [fr setImage_v:[frame valueForKey:@"image_v"]];
    
    [delegate FrameSelectView:self didSelectFrame:fr];
    
    
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
