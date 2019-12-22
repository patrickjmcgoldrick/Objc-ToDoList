//
//  ArchivedTaskDataSource.m
//  Objc-ToDoList
//
//  Created by dirtbag on 12/21/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

#import "ArchivedTaskDataController.h"

@interface ArchivedTaskDataController()

- (void)save:(NSMutableArray *)tasks :(NSString *)key;

@end

@implementation ArchivedTaskDataController

const NSString *PENDING_TASKS_KEY = @"PendingTasks";
const NSString *COMPLETED_TASKS_KEY = @"CompltedTasks";

// MARK: Public Interface Methods

// Add new task to Pending list
- (void)addNewTask:(ArchivableTask *)task {
    NSMutableArray *tasks = self.getPendingTasks;
    [tasks addObject:task];
    [self save:tasks :PENDING_TASKS_KEY];
}

// Move task from Pending list to Completed list
- (void)markTaskCompleted:(ArchivableTask *)task {
    
    // read pending list
    NSMutableArray *pendingList = [self getPendingTasks];
    
    // remove 'task' from Pending list
    for(int index = 0; index<[pendingList count]; index++) {
        ArchivableTask *compareTask = (ArchivableTask *)pendingList[index];
        if (compareTask.createdDate == task.createdDate) {
            [pendingList removeObjectAtIndex:index];
            break;
        }
    }
    
    // save pending list
    [self save:pendingList :PENDING_TASKS_KEY];

    // update task with completed date
    task.completedDate = [NSDate new];
    task.completed = true;
    
    // add 'task' to Completed list
    NSMutableArray *completedList = [self getCompletedTasks];
    [completedList addObject:task];
    
    // save Completed list
    [self save:completedList :COMPLETED_TASKS_KEY];
}

// Get list of Pending Tasks
- (NSMutableArray *)getPendingTasks {
    
    NSData *tasksData =
        [[NSUserDefaults standardUserDefaults] objectForKey:PENDING_TASKS_KEY];

    return [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:tasksData]];
}

// Get list of Completed Tasks
- (NSMutableArray *)getCompletedTasks {
    
    NSData *tasksData =
        [[NSUserDefaults standardUserDefaults] objectForKey:COMPLETED_TASKS_KEY];
    
    return [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:tasksData]];
}

// MARK: Private Methods
- (void)save:(NSMutableArray *)tasks :(NSString *)key {
    // Given `tasks` contains an array of ArchiverTask objects
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tasks];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
}

@end
