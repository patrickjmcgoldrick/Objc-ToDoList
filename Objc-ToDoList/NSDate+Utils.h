//
//  NSDate+Utils.h
//  Objc-ToDoList
//
//  Created by dirtbag on 12/22/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

// TODO: figure out why AppKit is imported
// TODO: by default when I create a category?
//#import <AppKit/AppKit.h>

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Utils)

+ (NSDate *)startOfDay;

@end

NS_ASSUME_NONNULL_END
