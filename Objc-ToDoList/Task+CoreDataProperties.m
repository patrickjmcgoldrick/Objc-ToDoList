//
//  Task+CoreDataProperties.m
//  Objc-ToDoList
//
//  Created by dirtbag on 12/21/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//
//

#import "Task+CoreDataProperties.h"

@implementation Task (CoreDataProperties)

+ (NSFetchRequest<Task *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Task"];
}

@dynamic completedDate;
@dynamic completed;
@dynamic createdDate;
@dynamic desc;
@dynamic dueDate;
@dynamic title;

@end
