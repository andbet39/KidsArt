//
//  EditSketchInfoViewController.h
//  kidsArt
//
//  Created by Andrea Terzani on 10/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SketchManager.h"
#import "Sketch.h"
#import "SelectAlbumViewController.h"
#import "SelectKidViewController.h"
@interface EditSketchInfoViewController : UIViewController <SelectAlbumViewControllerDelegate,UITextFieldDelegate>
{

    Sketch * editSketch;
    
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBambinoButton;
@property (nonatomic,strong)  Sketch * editSketch;

@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel;

- (IBAction)addToAlbumAction:(id)sender;
- (IBAction)selectKidButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *hintDisegnoDi;
@property (weak, nonatomic) IBOutlet UILabel *hintFattoIl;
@property (weak, nonatomic) IBOutlet UIButton *addtoAlbumButton;

@property (weak, nonatomic) IBOutlet UITextField *dateText;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UIButton *okDateButton;
- (IBAction)okButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *noteText;
@end
