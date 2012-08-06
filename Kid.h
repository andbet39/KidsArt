//
//  Kid.h
//  sketchkid_Beta
//
//  Created by Andrea Terzani on 06/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Kid : NSManagedObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * cognome;
@property (nonatomic, retain) NSString * photoPath;
@property (nonatomic, retain) NSDate * nascita;
@property (nonatomic, retain) NSSet *kid2Sketch;
@end

@interface Kid (CoreDataGeneratedAccessors)

- (void)addKid2SketchObject:(NSManagedObject *)value;
- (void)removeKid2SketchObject:(NSManagedObject *)value;
- (void)addKid2Sketch:(NSSet *)values;
- (void)removeKid2Sketch:(NSSet *)values;

@end
