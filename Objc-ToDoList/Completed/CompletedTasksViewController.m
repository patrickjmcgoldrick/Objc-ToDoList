//
//  CompletedTasksViewController.m
//  Objc-ToDoList
//
//  Created by dirtbag on 12/20/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

#import "CompletedTasksViewController.h"

#import "ArchivedTaskDataController.h"
#import "CompletedTaskCell.h"

@interface CompletedTasksViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation CompletedTasksViewController

ArchivedTaskDataController *dataController;
NSDateFormatter *dateFormatter;
NSMutableArray *completedTasks;

// MARK: ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    dataController = [ArchivedTaskDataController new];
    
    // setup Date Formatter
    dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"'Completed: 'MM/dd/yyyy";

}

// MARK: ViewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    completedTasks = [dataController getCompletedTasks];
    [self.tableView reloadData];
}

// MARK: TableView Data Source Delegate
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return completedTasks.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *completedCellId = @"CompletedCell";
    CompletedTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:completedCellId];

    ArchivableTask *task = completedTasks[(int)indexPath.row];
    cell.lblTitle.text = task.title;
    NSDate *date = task.completedDate;
    cell.lblCompleted.text = [dateFormatter stringFromDate:date];
    
    return cell;
}


@end
