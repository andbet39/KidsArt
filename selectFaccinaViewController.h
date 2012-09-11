//
//  selectFaccinaViewController.h
//  kidsArt
//
//  Created by Andrea Terzani on 08/09/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>

@class selectFaccinaViewController;

@protocol selectFaccinaViewControllerDelegate <NSObject>

-(void)selectFaccinaDidCancel;
-(void)selectFaccina:(selectFaccinaViewController*)sender didSelectFaccina:(NSString*)faccinaPath;
@end


@interface selectFaccinaViewController : UIViewController


{
GMGridView *_gmGridView;
NSMutableArray * backgroundsArray;



}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UINavigationBar *toolBar;
@property (weak, nonatomic) IBOutlet UIView *mainView;

- (IBAction)cancelButtonAction:(id)sender;

@property (weak,nonatomic) id <selectFaccinaViewControllerDelegate> delegate;


@end
