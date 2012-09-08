//
//  selectCopertinaViewController.h
//  kidsArt
//
//  Created by Andrea Terzani on 07/09/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackAlbum.h"
@class  selectCopertinaViewController;

@protocol selectCopertinaViewControllerDelegate <NSObject>

-(void)selectCopertinaDidCancel;
-(void)selectCopertina:(selectCopertinaViewController*)sender didSelectBackGround:(BackAlbum*)back;
@end

@interface selectCopertinaViewController : UIViewController<GMGridViewDataSource,GMGridViewActionDelegate>
{
    GMGridView *_gmGridView;
    NSMutableArray * backgroundsArray;
    


}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UINavigationBar *toolBar;
@property (weak, nonatomic) IBOutlet UIView *mainView;

- (IBAction)cancelButtonAction:(id)sender;

@property (weak,nonatomic) id <selectCopertinaViewControllerDelegate> delegate;

@end
