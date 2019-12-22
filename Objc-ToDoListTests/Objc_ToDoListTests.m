//
//  Objc_ToDoListTests.m
//  Objc-ToDoListTests
//
//  Created by dirtbag on 12/20/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ArchivableTask.h"
#import "AppDelegate.h"

@interface Objc_ToDoListTests : XCTestCase

@end

@implementation Objc_ToDoListTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

// MARK: Archiver
- (void) testArchiver {

    ArchivableTask *task1 = [ArchivableTask new];
    task1.createdDate = [[NSDate alloc]init];
    task1.title = @"Hello World";
    task1.desc = @"foo bar";
    task1.dueDate = [[NSDate alloc]init];
    task1.completed = false;
    
    ArchivableTask *task2 = [ArchivableTask new];
    task2.createdDate = [NSDate new];
    task2.title = @"This is another task";
    task2.desc = @"blah blah";
    task2.dueDate = [NSDate new];
    task2.completed = false;

    NSMutableArray *tasks = [NSMutableArray array];
    [tasks addObject:task1];
    [tasks addObject:task2];

    // Given `tasks` contains an array of ArchiverTask objects
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tasks];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"tasks"];
    
    NSData *tasksData = [[NSUserDefaults standardUserDefaults] objectForKey:@"tasks"];
    
    NSArray *readTasks = [NSKeyedUnarchiver unarchiveObjectWithData:tasksData];
    //[XCTAssertEqual [readTasks count], 2]; //, @"Expected 2 rows")];
}

// MARK: Core Data
- (void) testCoreDate {
    
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    context = appDelegate.persistentContainer.viewContext;
    /*
    // Save Data
    NSManagedObject *entityObject = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext: context];
    [entityObject setValue:@"Costco" forKey:@"title"];
    [entityObject setValue:@"Pho\nChicken" forKey:@"desc"];
    [entityObject setValue:[[NSDate alloc] init] forKey:@"createdDate"];
    [entityObject setValue:[[NSDate alloc] init] forKey:@"dueDate"];
    [entityObject setValue:[[NSDate alloc] init] forKey:@"completedDate"];
    [entityObject setValue:false forKey:@"completed"];
    
    [appDelegate saveContext];
    */
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Task"];
    NSArray *tasks = [context executeFetchRequest:fetchRequest error:nil];
    
    for(int i=0; i<[tasks count]; i++) {
        NSLog(@"title: %@", [tasks[i] title]);
        NSLog(@"desc: %@", [tasks[i] desc]);
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
