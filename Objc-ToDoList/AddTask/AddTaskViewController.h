//
//  AddTaskViewController.h
//  Objc-ToDoList
//
//  Created by dirtbag on 12/20/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddTaskViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *tfTitle;

@property (weak, nonatomic) IBOutlet UITextView *tfDesc;

@property (weak, nonatomic) IBOutlet UILabel *lblErrors;

@property (weak, nonatomic) IBOutlet UITextField *tfDueDate;

@property UIDatePicker *datePicker;
@property NSDateFormatter *dateFormatter;

- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker;

@end

NS_ASSUME_NONNULL_END
