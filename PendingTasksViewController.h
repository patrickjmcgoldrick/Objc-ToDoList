//
//  PendingTasksViewController.h
//  Objc-ToDoList
//
//  Created by dirtbag on 12/20/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"

NS_ASSUME_NONNULL_BEGIN

@interface PendingTasksViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, BEMCheckBoxDelegate>

@property NSDateFormatter *dateFormatter;

- (void) testCoreDate;

@end

NS_ASSUME_NONNULL_END
