//
//  ShareView.h
//  kidsArt
//
//  Created by Andrea Terzani on 31/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShareView;

@protocol ShareViewDelegate <NSObject>

-(void)shareViewdidFacebook:(ShareView*)sender;
-(void)shareViewdidTwitter:(ShareView*)sender;
-(void)shareViewdidMail:(ShareView*)sender;


@end

@interface ShareView : UIView

- (IBAction)FBshareButtonAction:(id)sender;


- (IBAction)TWshareButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *mailButtonAction;
@property (strong,nonatomic) id <ShareViewDelegate> delegate;
- (IBAction)mailButtonAction:(id)sender;

@end
