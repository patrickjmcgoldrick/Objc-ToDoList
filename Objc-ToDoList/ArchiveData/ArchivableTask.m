//
//  ArchiverTask.m
//  Objc-ToDoList
//
//  Created by dirtbag on 12/21/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

#import "ArchivableTask.h"

@implementation ArchivableTask

@synthesize createdDate;
@synthesize title;
@synthesize desc;
@synthesize dueDate;
@synthesize completedDate;
@synthesize completed;

/*
- (void)dealloc {
    [createdDate release];
    [title release];
    [desc release];
    [dueDate release];
    [completedDate release];
    [super dealloc];
}
*/

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.createdDate = [decoder decodeObjectForKey:@"createdDate"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.desc = [decoder decodeObjectForKey:@"desc"];
        self.dueDate = [decoder decodeObjectForKey:@"dueDate"];
        self.completedDate = [decoder decodeObjectForKey:@"completedDate"];
        self.completed = [decoder decodeBoolForKey:@"completed"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:createdDate forKey:@"createdDate"];
    [encoder encodeObject:title forKey:@"title"];
    [encoder encodeObject:desc forKey:@"desc"];
    [encoder encodeObject:dueDate forKey:@"dueDate"];
    [encoder encodeObject:completedDate forKey:@"completedDate"];
    [encoder encodeBool:completed forKey:@"completed"];
}

@end
