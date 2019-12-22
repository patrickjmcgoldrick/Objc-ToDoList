//
//  AddTaskViewController.m
//  Objc-ToDoList
//
//  Created by dirtbag on 12/20/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

#import "AddTaskViewController.h"
#import "ArchivedTaskDataController.h"

@interface AddTaskViewController ()

- (IBAction)btnSaveAction:(id)sender;
- (Boolean)inputsAreInvalid;

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // clear error messge
    _lblErrors.text = @"";
    
    // setup Date Formatter
    self.dateFormatter = [NSDateFormatter new];
    self.dateFormatter.dateFormat = @"MM/dd/yyyy";

    // setup Date Picker
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.tfDueDate.inputView = self.datePicker;
    
    // update to default date (today)
    [self onDatePickerValueChanged:self.datePicker];
}

- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker {
    self.tfDueDate.text = [self.dateFormatter stringFromDate:datePicker.date];
}

- (IBAction)btnSaveAction:(id)sender {
  
    if ([self inputsAreInvalid]) { return; }
    
    ArchivableTask *newTask = [ArchivableTask new];
    newTask.createdDate = [NSDate new];
    newTask.title = _tfTitle.text;
    newTask.desc = _tfDesc.text;
    newTask.dueDate = _datePicker.date;
    newTask.completed = false;
    
    ArchivedTaskDataController *dataController = [ArchivedTaskDataController new];
    [dataController addNewTask:newTask];
}

// Adjust Error label, if inputs are not valid
- (Boolean)inputsAreInvalid {
 
    if ([_tfTitle.text isEqualToString:@""]) {
        _lblErrors.text = @"Please provide a Title.";
        return TRUE;
    }
    
    if ([_tfDesc.text isEqualToString:@""]) {
        _lblErrors.text = @"Description is missing. Please provide one.";
        return TRUE;
    }
    
    return FALSE;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
