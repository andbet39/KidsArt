//
//  HomeViewController.h
//  sketchkid_Beta
//
//  Created by Andrea Terzani on 04/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Scale.h"
#import "DataManager.h"
#import "Album.h"
#import "Sketch.h"
#import "GMGridView.h"

@interface HomeViewController : UIViewController <GMGridViewDataSource, GMGridViewActionDelegate>
{

    UIScrollView *photoShowView;
    Album* currentAlbum;
    
    NSMutableArray * sketchArray;
    
    
    GMGridView *_gmGridView;
    
    NSInteger _lastDeleteItemIndexAsked;
    
    bool isPageRolled;
    
    
    Sketch * selectedSketch;
    Sketch * _toRemoveSketch;
    

}
- (IBAction)removeInfoButtonAction:(id)sender;
- (IBAction)infoButtonAction:(id)sender;
- (IBAction)creaDefaultAlbum:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;

- (IBAction)selectPreferitiAction:(id)sender;

-(void)reloadAlbumData;

@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIImageView *masterBackImage;


@property (weak, nonatomic) IBOutlet UIButton *removeInfoButton;

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIToolbar *albumToolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *infoButton;

@property (weak, nonatomic) IBOutlet UILabel *albumTitleLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addFavoriteButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;


@end
