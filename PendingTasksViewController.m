//
//  PendingTasksViewController.m
//  Objc-ToDoList
//
//  Created by dirtbag on 12/20/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

#import "PendingTasksViewController.h"
#import "PendingTaskCell.h"
#import "AppDelegate.h"
//#import "Task+CoreDataProperties.h"
#import "ArchivableTask.h"

@interface PendingTasksViewController ()  {
    
    __weak IBOutlet UITableView *tableView;
    
    NSMutableArray *nameArray;
    
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    NSArray *dictionaries;
}

@end

@implementation PendingTasksViewController

// MARK: ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *notes = 
    // Do any additional setup after loading the view.
    nameArray = [NSMutableArray arrayWithArray: @[@"Patrick", @"Jennifer", @"Tim", @"Maureen"]];
/*
    testArchiver();
}

// MARK: Archiver
- (void) testArchiver {
*/
    ArchivableTask *task1 = [[ArchivableTask alloc]init];
    task1.createdDate = [[NSDate alloc]init];
    task1.title = @"Hello World";
    task1.desc = @"foo bar";
    
    ArchivableTask *task2 = [[ArchivableTask alloc]init];
    task2.createdDate = [[NSDate alloc]init];
    task2.title = @"This is another task";
    task2.desc = @"blah blah";

    NSMutableArray *tasks = [NSMutableArray arrayWithArray: @[task1]];
                             
    [tasks addObject:task2];
    // Given `tasks` contains an array of ArchiverTask objects
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tasks];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"tasks"];

    NSData *tasksData = [[NSUserDefaults standardUserDefaults] objectForKey:@"tasks"];
    NSArray *readTasks = [NSKeyedUnarchiver unarchiveObjectWithData:tasksData];
    
    NSLog(@"title: %@", [readTasks[1] title]);
    NSLog(@"desc: %@", [readTasks[1] desc]);
}

// MARK: Core Data
- (void) testCoreDate {
    
    
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
    NSArray *tasks = [context executeRequest:fetchRequest error:nil];
    
    
    NSLog(@"title: %@", [tasks valueForKey:@"desc"]);
    
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return nameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *pendingCellId = @"PendingCell";
    PendingTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:pendingCellId];
    
    cell.lblTitle.text = nameArray[(int)indexPath.row];
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    
}


@end
