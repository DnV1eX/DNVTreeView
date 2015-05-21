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

- (NSInteger)treeView:(DNVTreeView *)treeView numberOfRowsInNodeAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!indexPath.length) return AppDel.treeNodes.count;
    
    NSDictionary *node = [DNVTreeViewController nodeAtIndexPath:indexPath];
    NSArray *nodes = node[TreeNodeChildrenKey];
    
    return nodes.count;
}


- (UITableViewCell *)treeView:(DNVTreeView *)treeView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *node = [DNVTreeViewController nodeAtIndexPath:indexPath];
    
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = node[TreeNodeTitleKey];
    
    return cell;
}

@end
