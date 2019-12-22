//
//  ArchivedTaskDataSource.m
//  Objc-ToDoList
//
//  Created by dirtbag on 12/21/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

#import "ArchivedTaskDataSource.h"

@interface ArchivedTaskDataSource()

- (void)save:(NSMutableArray *)tasks :(NSString *)key;

@end

@implementation ArchivedTaskDataSource

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
    // TODO
    // remove task from Pending list
    // save Pending list
    // add Complete Date
    // add to Completed list
    // save Completed list
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
