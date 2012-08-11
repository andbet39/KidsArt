//
//  kidCell.h
//  kidsArt
//
//  Created by Andrea Terzani on 11/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kid.h"
@interface kidCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UILabel *nomeLabel;
@property(nonatomic,weak)IBOutlet UIImageView *fotoImage;

-(void)initWithKid:(Kid*)kid;
@end
