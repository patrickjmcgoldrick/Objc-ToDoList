//
//  ArchiverTask.h
//  Objc-ToDoList
//
//  Created by dirtbag on 12/21/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArchivableTask : NSObject <NSCoding> {
    NSDate *createdDate;
    NSString *title;
    NSString *desc;
    NSDate *dueDate;
    NSDate *completedDate;
    BOOL completed;
}

@property (nonatomic, copy) NSDate *createdDate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSDate *dueDate;
@property (nonatomic, copy) NSDate *completedDate;
@property (nonatomic) BOOL completed;

@end
