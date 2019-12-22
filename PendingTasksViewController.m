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
#import "ArchivedTaskDataSource.h"

@interface PendingTasksViewController ()  {
    
    __weak IBOutlet UITableView *tableView;
    
    NSMutableArray *pendingTasks;
    
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    NSArray *dictionaries;
}

@end

@implementation PendingTasksViewController

// MARK: ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reloadArchiveData];
          
//    [self testCoreDate];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"viewDidAppear");
    [self reloadArchiveData];
    tableView.reloadData;
}

- (void)reloadArchiveData {
    
    ArchivedTaskDataSource *dataController = [ArchivedTaskDataSource new];
    NSMutableArray *pendingArray = [dataController getPendingTasks];

    if (pendingArray != nil) {
        pendingTasks = pendingArray;
    } else {
        pendingTasks = [NSMutableArray array];
    }
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
    NSArray *tasks = [context executeFetchRequest:fetchRequest error:nil];
    

    for(int i=0; i<[tasks count]; i++) {
        NSLog(@"title: %@", [tasks[i] title]);
        NSLog(@"desc: %@", [tasks[i] desc]);
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return pendingTasks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *pendingCellId = @"PendingCell";
    PendingTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:pendingCellId];
    
    cell.lblTitle.text = ((ArchivableTask *)pendingTasks[(int)indexPath.row]).title;
    cell.lblDesc.text = ((ArchivableTask *)pendingTasks[(int)indexPath.row]).desc;
    //cell.lblDueDate.text = ((ArchivableTask *)pendingTasks[(int)indexPath.row]).desc;

    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    
}


@end
