//
//  DNVTreeViewController.m
//  DNVTreeView
//
//  Created by Alexey Demin on 20/05/15.
//  Copyright (c) 2015 Alexey Demin. All rights reserved.
//

#import "DNVTreeViewController.h"
#import "AppDelegate.h"


@interface DNVTreeViewController ()

@end


@implementation DNVTreeViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.treeView = [DNVTreeView new];
        self.treeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.treeView.dataSource = self;
        self.treeView.delegate = self;
        self.view = self.treeView;
    }
    return self;
}


+ (NSDictionary *)nodeAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *nodes = AppDel.treeNodes;
    NSDictionary *node;
    for (NSUInteger position = 0; position < indexPath.length; position++) {
        NSUInteger index = [indexPath indexAtPosition:position];
        node = nodes[index];
        nodes = node[TreeNodeChildrenKey];
    }
    return node;
}


#pragma mark - DNVTreeViewDataSource

- (NSInteger)treeView:(DNVTreeView *)treeView numberOfChildNodesAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!indexPath.length) return AppDel.treeNodes.count;
    
    NSDictionary *node = [DNVTreeViewController nodeAtIndexPath:indexPath];
    NSArray *childNodes = node[TreeNodeChildrenKey];
    
    return childNodes.count;
}


- (UITableViewCell *)treeView:(DNVTreeView *)treeView cellForNodeAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *node = [DNVTreeViewController nodeAtIndexPath:indexPath];
    
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = node[TreeNodeTitleKey];
    
    return cell;
}


#pragma mark - DNVTreeViewDelegate

- (void)treeView:(DNVTreeView *)treeView didSelectNodeAtIndexPath:(NSIndexPath *)indexPath {
    
    [treeView deselectNodeAtIndexPath:indexPath animated:YES];
}


- (BOOL)treeView:(DNVTreeView *)treeView isNodeExpandedAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *node = [DNVTreeViewController nodeAtIndexPath:indexPath];
    return [node[TreeNodeIsExpandedKey] boolValue];
}


- (void)treeView:(DNVTreeView *)treeView willExpandNodeAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *node = [DNVTreeViewController nodeAtIndexPath:indexPath];
    node[TreeNodeIsExpandedKey] = @YES;
}


- (void)treeView:(DNVTreeView *)treeView willCollapseNodeAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *node = [DNVTreeViewController nodeAtIndexPath:indexPath];
    node[TreeNodeIsExpandedKey] = @NO;
}

@end
