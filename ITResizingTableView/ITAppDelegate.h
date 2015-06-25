//
//  ITAppDelegate.h
//  ITResizingTableView
//
//  Created by Ilija Tovilo on 1/8/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ITAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate> 

@property int rows;
@property int rowHeight;
@property int headerHeight;
@property int currentHeight;
@property int instantiatedHeight;
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSScrollView *scrollView;
@property (weak) IBOutlet NSArrayController *arrayController;

@end
