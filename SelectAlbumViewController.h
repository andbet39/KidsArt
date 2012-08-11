//
//  SelectAlbumViewController.h
//  kidsArt
//
//  Created by Andrea Terzani on 10/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumCell.h"
@class SelectAlbumViewController;


@protocol SelectAlbumViewControllerDelegate <NSObject>

-(void)SelectAlbumViewController:(SelectAlbumViewController*)sender DidSelectAlbum:(Album*)album;

@end


@interface SelectAlbumViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    NSMutableArray * albumArray;
}

@property (strong,nonatomic) id <SelectAlbumViewControllerDelegate> delegate;

@end
