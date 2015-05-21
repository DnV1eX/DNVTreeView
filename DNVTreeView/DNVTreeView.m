//
//  DNVTreeView.m
//  DNVTreeView
//
//  Created by Alexey Demin on 20/05/15.
//  Copyright (c) 2015 Alexey Demin. All rights reserved.
//

#import "DNVTreeView.h"


@interface DNVTreeView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<DNVTreeViewDataSource> treeViewDataSource;

@end


@implementation DNVTreeView

@dynamic dataSource;


- (void)setDataSource:(id<DNVTreeViewDataSource>)dataSource {
    
    self.treeViewDataSource = dataSource;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        super.dataSource = self;
        super.delegate = self;
    }
    return self;
}

/*
- (NSIndexPath *)nodeIndexPathForRow:(NSUInteger)row {
    
}


- (NSInteger)numberOfRowsInNodeAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger numberOfNodes = [self.dataSource numberOfRowsInNodeAtIndexPath:indexPath];
    NSInteger numberOfChildren = 0;
    for (NSUInteger index = 0; index < numberOfNodes; index++) {
        numberOfChildren += [self.dataSource numberOfRowsInNodeAtIndexPath:[indexPath indexPathByAddingIndex:index]];
    }
    return numberOfNodes + numberOfChildren;
}
*/

- (NSArray *)indexPathsForRowsInNodeAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger numberOfNodes = [self.treeViewDataSource treeView:self numberOfRowsInNodeAtIndexPath:indexPath];
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (NSUInteger index = 0; index < numberOfNodes; index++) {
        NSIndexPath *nodeIndexPath = [indexPath indexPathByAddingIndex:index];
        [indexPaths addObject:nodeIndexPath];
        [indexPaths addObjectsFromArray:[self indexPathsForRowsInNodeAtIndexPath:nodeIndexPath]];
    }
    return [indexPaths copy];
}


- (NSArray *)indexPaths {
    
    return [self indexPathsForRowsInNodeAtIndexPath:[NSIndexPath new]];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section) return 0;
    
    return [self indexPaths].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath *nodeIndexPath = [self indexPaths][indexPath.row];
    UITableViewCell *cell = [self.treeViewDataSource treeView:self cellForRowAtIndexPath:nodeIndexPath];
    return cell;
}

@end
