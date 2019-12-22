//
//  ArchivedTaskDataSource.h
//  Objc-ToDoList
//
//  Created by dirtbag on 12/21/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArchivableTask.h"

@interface ArchivedTaskDataController : NSObject

- (void)addNewTask:(ArchivableTask *)task;
- (void)deletePendingTask:(ArchivableTask *)task;
- (void)markTaskCompleted:(ArchivableTask *)task;

- (NSMutableArray *)getPendingTasks;
- (NSMutableArray *)getCompletedTasks;

@end

