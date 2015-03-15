//
//  StudentEntity.h
//  StudentData
//
//  Created by Nalin Natrajan on 15/3/15.
//  Copyright (c) 2015 Nalin Natrajan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface StudentEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * studentAge;
@property (nonatomic, retain) NSString * studentName;
@property (nonatomic, retain) NSString * studentStream;

@end
