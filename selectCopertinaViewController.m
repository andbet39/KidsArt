//
//  selectCopertinaViewController.m
//  kidsArt
//
//  Created by Andrea Terzani on 07/09/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "selectCopertinaViewController.h"
#import "BackAlbum.h"
@interface selectCopertinaViewController ()

@end

@implementation selectCopertinaViewController
@synthesize titleLabel;
@synthesize toolBar;
@synthesize mainView;

-(void)creaGridView{
    
    
    NSInteger spacing = 10;
    
    GMGridView *gmGridView = [[GMGridView alloc] initWithFrame:mainView.bounds];
    gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gmGridView.backgroundColor = [UIColor clearColor];
    [mainView addSubview:gmGridView];
    
    _gmGridView = gmGridView;
    
    _gmGridView.style = GMGridViewStyleSwap;
    _gmGridView.itemSpacing = spacing;
    _gmGridView.minEdgeInsets = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    _gmGridView.centerGrid = TRUE;
    _gmGridView.actionDelegate = self;
     _gmGridView.dataSource = self;
    
    
    
}

-(void) inizializzaLista
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"albumBackground.plist"];
    
    
    NSDictionary * rootDictionary = [NSDictionary dictionaryWithContentsOfFile:finalPath] ;
    
    
    NSDictionary * backList = (NSDictionary*) [rootDictionary objectForKey:@"BackGround"];
    backgroundsArray =[[NSMutableArray alloc]init];
    
    for(NSString * key in backList)
    {
        
        NSDictionary * back = (NSDictionary*) [backList objectForKey:key];
        
        BackAlbum * b = [[BackAlbum alloc]init];
        [b setName:key];
        [b setImage:[back objectForKey:@"Image"]];
        [b setThumb:[back objectForKey:@"Thumb"]];
        NSLog(b.name);
        [backgroundsArray addObject:b];
    }
    
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bckInserimento.png"]]];
    [toolBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [titleLabel setText:NSLocalizedString(@"SFONDO_ALBUM", nil)];
    
    [titleLabel setFont:[UIFont fontWithName:@"Snickles" size:32]];
    
    [self inizializzaLista];
    
    [self creaGridView];

}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setToolBar:nil];
    [self setMainView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [backgroundsArray count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    
    
    return CGSizeMake(90 , 100);
    
    
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    //NSLog(@"Creating view indx %d", index);
    
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];
        cell.deleteButtonIcon = [UIImage imageNamed:@"close_x.png"];
        cell.deleteButtonOffset = CGPointMake(-15, -15);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        view.backgroundColor = [UIColor clearColor];
        view.layer.masksToBounds = NO;
        view.layer.cornerRadius = 8;
        
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    BackAlbum * currentBack = [backgroundsArray objectAtIndex:index];
    
    
    CGRect corniceRect= CGRectMake(5, size.height-75, size.width-5, 100);
    
    UIImageView *cornice =[[UIImageView alloc]initWithFrame:corniceRect];
    [cornice setImage:[UIImage imageNamed:@"corniceBimbo.png"]];
    [cell.contentView addSubview:cornice];
    
    CGRect fotoRect= CGRectMake(13, size.height-64, size.width-22, 66);
    UIImageView *fotoView =[[UIImageView alloc]initWithFrame:fotoRect];
    fotoView.backgroundColor=[UIColor redColor];

    [fotoView setImage:[UIImage imageNamed:currentBack.thumb]];
    NSLog(currentBack.thumb);
    [cell.contentView addSubview:fotoView];
    
    return cell;
}

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    [self.delegate selectCopertina:self didSelectBackGround:[backgroundsArray objectAtIndex:position]];

}

- (IBAction)cancelButtonAction:(id)sender {
    
    [self.delegate selectCopertinaDidCancel];
}


@end
