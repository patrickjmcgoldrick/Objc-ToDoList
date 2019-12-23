//
//  PendingTasksViewController.m
//  Objc-ToDoList
//
//  Created by dirtbag on 12/20/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

#import "PendingTasksViewController.h"

#import "AppDelegate.h"
#import "ArchivedTaskDataController.h"
#import "NSDate+Utils.h"
#import "PendingTaskCell.h"

@interface PendingTasksViewController ()  {
    
    __weak IBOutlet UITableView *tableView;
    
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
    self.dateFormatter.dateFormat = @"'Due: 'MM/dd/yyyy";

    [self reloadArchiveData];
}

// MARK: ViewDidAppear
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

// MARK: Tableview Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return pendingTasks.count;
}
#import "AppDelegate.h"

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *pendingCellId = @"PendingCell";
    PendingTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:pendingCellId];
    
    ArchivableTask *task = (ArchivableTask *)pendingTasks[(int)indexPath.row];
    
    cell.lblTitle.text = task.title;
    cell.lblDesc.text = task.desc;
    
    // adjust DueDate display
    NSDate *dueDate = [task.dueDate startOfDay];
    NSDate *today = [[NSDate new]startOfDay];
    cell.lblDueDate.text = [self.dateFormatter stringFromDate:dueDate];
    if (dueDate < today) {
        cell.lblDueDate.textColor = UIColor.redColor;
        cell.bemCheckBox.tintColor = UIColor.redColor;
    } else {
        cell.lblDueDate.textColor = UIColor.blackColor;
        cell.bemCheckBox.tintColor = UIColor.greenColor;
    }
    
    // BEM Checkbox
    cell.bemCheckBox.delegate = self;
    cell.tag = (int)indexPath.row;
    cell.bemCheckBox.on = false;
    
    return cell;
}

// MARK: TableView Delegate Methods
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        ArchivableTask *task = (ArchivableTask *) pendingTasks[(int)indexPath.row];
        [dataController deletePendingTask:task];
        [self reloadArchiveData];
        [tableView reloadData];
    }
}

// MARK: BEM CheckBox Delegate
- (void)animationDidStopForCheckBox:(BEMCheckBox *)checkBox {
    
    int index = (int)checkBox.tag;
    ArchivableTask *task = pendingTasks[index];
    [dataController markTaskCompleted:task];
    [self reloadArchiveData];
    [tableView reloadData];
}

@end
