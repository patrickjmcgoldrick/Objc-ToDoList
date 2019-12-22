//
//  PendingTasksViewController.m
//  Objc-ToDoList
//
//  Created by dirtbag on 12/20/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

#import "PendingTasksViewController.h"

#import "AppDelegate.h"
//#import "Task+CoreDataProperties.h"
#import "ArchivedTaskDataController.h"
#import "PendingTaskCell.h"

@interface PendingTasksViewController ()  {
    
    __weak IBOutlet UITableView *tableView;
    
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    ArchivedTaskDataController *dataController;
    NSMutableArray *pendingTasks;

}

@end

@implementation PendingTasksViewController

// MARK: ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataController = [ArchivedTaskDataController new];

    // setup Date Formatter
    self.dateFormatter = [NSDateFormatter new];
    self.dateFormatter.dateFormat = @"MM/dd/yyyy";

    [self reloadArchiveData];
          
//    [self testCoreDate];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self reloadArchiveData];
    [tableView reloadData];
}

- (void)reloadArchiveData {
    
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

// MARK: Tableview Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return pendingTasks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *pendingCellId = @"PendingCell";
    PendingTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:pendingCellId];
    
    cell.lblTitle.text = ((ArchivableTask *)pendingTasks[(int)indexPath.row]).title;
    cell.lblDesc.text = ((ArchivableTask *)pendingTasks[(int)indexPath.row]).desc;
    NSDate *date = ((ArchivableTask *)pendingTasks[(int)indexPath.row]).dueDate;
    NSString *dateString = [NSString stringWithFormat:@"Due: %@", [self.dateFormatter stringFromDate:date]];
    cell.lblDueDate.text = dateString;
    
    // BEM Checkbox
    cell.bemCheckBox.delegate = self;
    cell.tag = (int)indexPath.row;
    cell.bemCheckBox.on = false;
    
    return cell;
}

// MARK: BEM CheckBox Delegate
- (void)animationDidStopForCheckBox:(BEMCheckBox *)checkBox {
    
    int index = (int)checkBox.tag;
    ArchivableTask *task = pendingTasks[index];
    [dataController markTaskCompleted:task];
    [self reloadArchiveData];
    [tableView reloadData];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    
}


@end