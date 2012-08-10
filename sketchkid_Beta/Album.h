//
//  Album.h
//  kidsArt
//
//  Created by Andrea Terzani on 10/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Sketch;

@interface Album : NSManagedObject

@property (nonatomic, retain) NSString * copertinaPath;
@property (nonatomic, retain) NSDate * dataCreazione;
@property (nonatomic, retain) NSDecimalNumber * order;
@property (nonatomic, retain) NSString * titolo;
@property (nonatomic, retain) NSNumber * isDefault;
@property (nonatomic, retain) NSSet *album2sketch;
@end

@interface Album (CoreDataGeneratedAccessors)

- (void)addAlbum2sketchObject:(Sketch *)value;
- (void)removeAlbum2sketchObject:(Sketch *)value;
- (void)addAlbum2sketch:(NSSet *)values;
- (void)removeAlbum2sketch:(NSSet *)values;

@end
