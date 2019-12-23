//
//  PendingTaskCell.h
//  Objc-ToDoList
//
//  Created by dirtbag on 12/20/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"

NS_ASSUME_NONNULL_BEGIN

@interface PendingTaskCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblDesc;

@property (weak, nonatomic) IBOutlet UILabel *lblDueDate;

@property (weak, nonatomic) IBOutlet BEMCheckBox *bemCheckBox;


@end

NS_ASSUME_NONNULL_END
