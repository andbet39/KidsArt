//
//  Sketch.h
//  kidsArt
//
//  Created by Andrea Terzani on 09/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Sketch : NSManagedObject

@property (nonatomic, retain) NSDate * data;
@property (nonatomic, retain) NSNumber * isPrefered;
@property (nonatomic, retain) NSString * nota;
@property (nonatomic, retain) NSDecimalNumber * order;
@property (nonatomic, retain) NSString * pathFull;
@property (nonatomic, retain) NSString * pathSmall;
@property (nonatomic, retain) NSDate * saveDate;

@end
