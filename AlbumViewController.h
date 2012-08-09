//
//  AlbumViewController.h
//  kidsArt
//
//  Created by Andrea Terzani on 08/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataManager.h"
#import "AlbumManager.h"
#import "AlbumCell.h"
#import "Album.h"
@interface AlbumViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    NSMutableArray * albumArray;


}

@end
