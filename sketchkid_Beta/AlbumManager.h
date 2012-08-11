//
//  AlbumManager.h
//  kidsArt
//
//  Created by Andrea Terzani on 08/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataManager.h"
#import "HomeViewController.h"
#import "AlbumViewController.h"
#import "Album.h"

@interface AlbumManager : NSObject

+ (id)sharedAlbumManager ;



@property(nonatomic,strong)AlbumViewController * istanceOfAlbumViewController;
@property(nonatomic,strong)HomeViewController * istanceOfHomeViewController;
@property(nonatomic,strong)Album* selectedAlbum;
@property(readwrite)bool isSelectedAlbumUpdated;


-(Album*)defaultAlbum;
-(int)getMaxOrder;


@end
