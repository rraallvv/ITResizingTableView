//
//  ITAppDelegate.m
//  ITResizingTableView
//
//  Created by Ilija Tovilo on 1/8/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "ITAppDelegate.h"
#import "NSView+NSLayoutConstraintFilter.h"

@implementation ITAppDelegate

@synthesize rows;
@synthesize rowHeight;
@synthesize headerHeight;
@synthesize currentHeight;
@synthesize instantiatedHeight;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)awakeFromNib {
    rows = 0;

    [self.tableView setDataSource:self];

    [self getTableMetrics];
}

-(void) getTableMetrics {
	headerHeight = NSHeight(self.tableView.headerView.frame);
    instantiatedHeight = NSHeight([[self.scrollView documentView] frame]);
    [self addRow:nil];
    rowHeight = NSHeight([[self.scrollView documentView] frame]);
    [self subtractRow:nil];
    [self setCurrentHeight:instantiatedHeight];
    NSLog(@"instantiatedHeight=%i",instantiatedHeight);
    NSLog(@"addHeight=%i",rowHeight);
}

- (void)resetTableViewHeight {
    [self setTableViewHeight: 0];
}

- (void)setTableViewHeight:(CGFloat)tableHeight {
    NSLayoutConstraint *constraint = [self.scrollView constraintForAttribute:NSLayoutAttributeHeight];
    [constraint setConstant:tableHeight];
    NSLog(@"height=%f",tableHeight);
}

#define BUFFER 2
#define MAX_TALL 15

- (IBAction)addRow:(id)sender {
	[self.arrayController addObject:@{@"keyPath": @(rows),
									  @"type": @(rows),
									  @"value": @(rows)}];

    rows += 1;
    [self.tableView reloadData];

    if (rows > MAX_TALL) {
        [self setTableViewHeight:headerHeight+rowHeight*MAX_TALL+BUFFER];
    } else {
        [self setTableViewHeight:headerHeight+rowHeight*rows+BUFFER];
    }

    NSLog(@"rows=%i",rows);
}

- (IBAction)subtractRow:(id)sender {
    if (rows>0){
        rows -= 1;
        [self.tableView reloadData];
        
        if (rows > MAX_TALL) {
            [self setTableViewHeight:headerHeight+rowHeight*MAX_TALL+BUFFER];
        } else {
            [self setTableViewHeight:headerHeight+rowHeight*rows+BUFFER];
        }
    }

	[self.arrayController removeObject:[self.arrayController.arrangedObjects lastObject]];

    NSLog(@"rows=%i",rows);
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return rows;
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
	return YES;
}

@end
