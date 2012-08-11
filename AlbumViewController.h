//
//  AlbumViewController.h
//  kidsArt
//
//  Created by Andrea Terzani on 08/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumCell.h"
#import "Album.h"
#import "newAlbumViewController.h"



@interface AlbumViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,newAlbumViewControllerDelegate>
{

    NSMutableArray * albumArray;


}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addAlbumButtonAction;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addAlbumAction;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addAlbumAction:(id)sender;


-(void)reloadData;


@end
