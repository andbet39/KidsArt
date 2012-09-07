//
//  EditSketchInfoViewController.m
//  kidsArt
//
//  Created by Andrea Terzani on 10/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "EditSketchInfoViewController.h"

@interface EditSketchInfoViewController ()

@end

@implementation EditSketchInfoViewController
@synthesize noteText;
@synthesize hintDisegnoDi;
@synthesize hintFattoIl;
@synthesize addtoAlbumButton;
@synthesize dateText;
@synthesize datePicker;
@synthesize okDateButton;
@synthesize albumNameLabel;
@synthesize titleLabel;
@synthesize addBambinoButton;
@synthesize editSketch;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    AlbumManager *am = [AlbumManager sharedAlbumManager];
    [albumNameLabel setText:am.selectedAlbum.titolo];
    
    
    NSString * nomeBimbo = editSketch.kid.nome;
    
    if(nomeBimbo == nil)
    {
        nomeBimbo=@"?";
    }else{
    
        
    }
    //NSString * sketchof = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"DISEGNO_DI", nil),nomeBimbo];
    
    [titleLabel setText:NSLocalizedString(@"MODIFICA_INFO_DISEGNO", nil)];
    [titleLabel setFont:[UIFont fontWithName:@"Snickles" size:32]];

    
    [addBambinoButton setTitle:nomeBimbo forState:UIControlStateNormal];
    [addBambinoButton setTitleColor:RGB(0, 32, 64) forState:UIControlStateNormal];
    [hintDisegnoDi setFont:[UIFont fontWithName:@"Helvetica Rounded LT Std" size:18]];
    [hintDisegnoDi setText:NSLocalizedString(@"DISEGNO_DI", nil)];
    [hintFattoIl setFont:[UIFont fontWithName:@"Helvetica Rounded LT Std" size:18]];
    [hintFattoIl setText:NSLocalizedString(@"FATTO_IL", nil)];
    
    [addBambinoButton setFont:[UIFont fontWithName:@"Helvetica Rounded LT Std" size:18]];
    
    [hintDisegnoDi setTextColor:RGB(150, 150, 150)];
    [hintFattoIl setTextColor:RGB(150, 150, 150)];
    
    noteText.placeholder=NSLocalizedString(@"INFO_NOTE", nil);
    noteText.text=editSketch.nota ;
    [addtoAlbumButton setFont:[UIFont fontWithName:@"Helvetica Rounded LT Std" size:18]];
    [addtoAlbumButton setTitle:NSLocalizedString(@"AGGIUNGI_AD_ALBUM", nil) forState:UIControlStateNormal];

    dateText.inputView = datePicker;
    dateText.inputAccessoryView = okDateButton;
    [datePicker setFrame:CGRectMake(0,600,255, 320)];
    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];

    [okDateButton setFrame:CGRectMake(280,600,40, 30)];
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *dataCreazione = editSketch.data;
    datePicker.date=editSketch.data;
    NSString *theDate = [dateFormat stringFromDate:dataCreazione];
    dateText.text =theDate;
    
}

- (void)dateChanged
{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *dataCreazione = self.datePicker.date;
    
    NSString *theDate = [dateFormat stringFromDate:dataCreazione];

    
    dateText.text = theDate;
}

- (void)viewDidUnload
{
    [self setAlbumNameLabel:nil];
    [self setAddBambinoButton:nil];
    [self setHintDisegnoDi:nil];
    [self setHintFattoIl:nil];
    [self setAddtoAlbumButton:nil];
    [self setTitleLabel:nil];
    [self setDateText:nil];
    [self setDatePicker:nil];
    [self setOkDateButton:nil];
    [self setNoteText:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	
    
    if ([segue.identifier isEqualToString:@"selectAlbum"])
    {
        SelectAlbumViewController * selectAlbumView=(SelectAlbumViewController*) [segue destinationViewController];
        [selectAlbumView setDelegate:self];
    }
    
    if ([segue.identifier isEqualToString:@"selectKid"])
    {
        SelectKidViewController * selectKidView=(SelectKidViewController*) [segue destinationViewController];
        [selectKidView setDelegate:self];
    }
}

- (IBAction)addToAlbumAction:(id)sender {
    
    [self performSegueWithIdentifier:@"selectAlbum" sender:self];
    
}

- (IBAction)selectKidButtonAction:(id)sender {
    
    [self performSegueWithIdentifier:@"selectKid" sender:self];
}

-(void)SelectAlbumViewController:(SelectAlbumViewController*)sender DidSelectAlbum:(Album*)album{

    [album addAlbum2sketchObject:editSketch];

    DataManager *dm = [DataManager  sharedDataManager];

    NSManagedObjectContext *context = [dm managedObjectContext];

    // Save the context.
    NSError *error = nil;
    if (![context save:&error]){
        NSLog(@"Error on save");
    }

    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)SelectKidViewControllerr:(SelectKidViewController*)sender DidSelectKid:(Kid*)kid{

    [editSketch setKid:kid];

    DataManager *dm = [DataManager  sharedDataManager];
    
    NSManagedObjectContext *context = [dm managedObjectContext];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]){
        NSLog(@"Error on save");
    }
    
    NSString * sketchof = kid.nome;

    [addBambinoButton setTitle:sketchof forState:UIControlStateNormal];

    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
        [editSketch setNota:textField.text];
    
    
    
	[textField resignFirstResponder];
    
    
    DataManager *dm = [DataManager  sharedDataManager];
    
    NSManagedObjectContext *context = [dm managedObjectContext];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]){
        NSLog(@"Error on save");
    }

	return YES;
}



- (IBAction)okButtonAction:(id)sender {
   
    
    [dateText resignFirstResponder];

    [editSketch setData:datePicker.date];
    
    DataManager *dm = [DataManager  sharedDataManager];
    
    NSManagedObjectContext *context = [dm managedObjectContext];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]){
        NSLog(@"Error on save");
    }

}
@end
