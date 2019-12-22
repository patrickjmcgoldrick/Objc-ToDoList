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

NSMutableArray *completedTasks;

// MARK: ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    dataController = [ArchivedTaskDataController new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    completedTasks = [dataController getCompletedTasks];
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return completedTasks.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *completedCellId = @"CompletedCell";
    CompletedTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:completedCellId];

    ArchivableTask *task = completedTasks[(int)indexPath.row];
    cell.lblTitle.text = task.title;
    cell.lblCompleted.text = @"Done!";
    
    return cell;
}


@end
