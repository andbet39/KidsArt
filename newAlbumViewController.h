//
//  newAlbumViewController.h
//  kidsArt
//
//  Created by Andrea Terzani on 10/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  newAlbumViewController;

@protocol newAlbumViewControllerDelegate <NSObject>
- (void)newAlbumViewControllerDidCancel:(newAlbumViewController *)controller;
- (void)newAlbumViewController: (newAlbumViewController *)controller DidAddAlbum:(Album *)album;
@end

@interface newAlbumViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (strong,nonatomic) id <newAlbumViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *titoloText;
@property (weak, nonatomic) IBOutlet UINavigationBar *toolBar;

- (IBAction)saveButtonAction:(id)sender;
- (IBAction)cancelButtonAction:(id)sender;


@end
