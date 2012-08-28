//
//  SeletKidViewController.h
//  kidsArt
//
//  Created by Andrea Terzani on 11/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kid.h"
#import "kidCell.h"
@class SelectKidViewController;

@protocol SelectKidViewControllerDelegate <NSObject>

-(void)SelectKidViewControllerr:(SelectKidViewController*)sender DidSelectKid:(Kid*)kid;

@end

@interface SelectKidViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    NSMutableArray * kidsArray;
}
@property (strong,nonatomic) id <SelectKidViewControllerDelegate> delegate;

@end
