//
//  newKidViewController.h
//  sketchkid_Beta
//
//  Created by Andrea Terzani on 06/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kid.h"

@class  newKidViewController;

@protocol NewKidViewControllerDelegate <NSObject>
- (void)NewKidViewControllerDidCancel:(newKidViewController *)controller;
- (void)NewKidViewController: (newKidViewController *)controller DidAddKid:(Kid *)kid;
@end


@interface newKidViewController : UIViewController <UITextFieldDelegate>


@property (strong,nonatomic) id <NewKidViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *nomeText;
@property (weak, nonatomic) IBOutlet UINavigationBar *toolBar;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)saveButtonAction:(id)sender;
- (IBAction)cancelButtonAction:(id)sender;
@end
