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
@property (nonatomic, weak) id<DNVTreeViewDelegate> treeViewDelegate;

@end


@implementation DNVTreeView

@dynamic dataSource;
@dynamic delegate;


- (void)setDataSource:(id<DNVTreeViewDataSource>)dataSource {
    
    self.treeViewDataSource = dataSource;
}


- (void)setDelegate:(id<DNVTreeViewDelegate>)delegate {
    
    self.treeViewDelegate = delegate;
}


- (instancetype)init {
    self = [super initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    if (self) {
        super.dataSource = self;
        super.delegate = self;
    }
    return self;
}


- (NSArray *)indexPathsForChildNodesAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL showChildNodes = YES;
    if (indexPath.length) {
        showChildNodes = [self.treeViewDelegate treeView:self isNodeExpandedAtIndexPath:indexPath];
    }
    
    NSInteger numberOfNodes = showChildNodes ? [self.treeViewDataSource treeView:self numberOfChildNodesAtIndexPath:indexPath] : 0;
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (NSUInteger index = 0; index < numberOfNodes; index++) {
        NSIndexPath *nodeIndexPath = [indexPath indexPathByAddingIndex:index];
        [indexPaths addObject:nodeIndexPath];
        [indexPaths addObjectsFromArray:[self indexPathsForChildNodesAtIndexPath:nodeIndexPath]];
    }
    return [indexPaths copy];
}


- (NSArray *)indexPaths {
    
    return [self indexPathsForChildNodesAtIndexPath:[NSIndexPath new]];
}


#pragma mark - Public Methods

- (void)deselectNodeAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    
    NSInteger row = [[self indexPaths] indexOfObject:indexPath];
    [self deselectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:animated];
}


- (void)expandNodeAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    
    [self beginUpdates];
    
    if ([self.treeViewDelegate respondsToSelector:@selector(treeView:willExpandNodeAtIndexPath:)]) {
        [self.treeViewDelegate treeView:self willExpandNodeAtIndexPath:indexPath];
    }
    
    NSMutableArray *indexPaths = [NSMutableArray new];
    NSArray *allIndexPaths = [self indexPaths];
    NSInteger row = [allIndexPaths indexOfObject:indexPath];
    NSIndexPath *rowIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
    CGFloat height = [self tableView:self heightForRowAtIndexPath:rowIndexPath];
    for (NSIndexPath *nodeIndexPath in [self indexPathsForChildNodesAtIndexPath:indexPath]) {
        NSInteger row = [allIndexPaths indexOfObject:nodeIndexPath];
        NSIndexPath *rowIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [indexPaths addObject:rowIndexPath];
        height += [self tableView:self heightForRowAtIndexPath:rowIndexPath];
    }
    UITableViewRowAnimation animation = animated ? UITableViewRowAnimationBottom : UITableViewRowAnimationNone;
    [self insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    
    [self endUpdates];
    
    if (height < self.bounds.size.height) {
        [self scrollToRowAtIndexPath:indexPaths.lastObject atScrollPosition:UITableViewScrollPositionNone animated:animated];
    } else {
        [self scrollToRowAtIndexPath:rowIndexPath atScrollPosition:UITableViewScrollPositionTop animated:animated];
    }
}


- (void)collapseNodeAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    
    [self beginUpdates];
    
    NSMutableArray *indexPaths = [NSMutableArray new];
    NSArray *allIndexPaths = [self indexPaths];
    for (NSIndexPath *nodeIndexPath in [self indexPathsForChildNodesAtIndexPath:indexPath]) {
        NSInteger row = [allIndexPaths indexOfObject:nodeIndexPath];
        NSIndexPath *rowIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [indexPaths addObject:rowIndexPath];
    }
    UITableViewRowAnimation animation = animated ? UITableViewRowAnimationTop : UITableViewRowAnimationNone;
    [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    
    if ([self.treeViewDelegate respondsToSelector:@selector(treeView:willCollapseNodeAtIndexPath:)]) {
        [self.treeViewDelegate treeView:self willCollapseNodeAtIndexPath:indexPath];
    }
    
    [self endUpdates];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section) return 0;
    
    return [self indexPaths].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath *nodeIndexPath = [self indexPaths][indexPath.row];
    UITableViewCell *cell = [self.treeViewDataSource treeView:self cellForNodeAtIndexPath:nodeIndexPath];
    cell.layoutMargins = UIEdgeInsetsMake(cell.layoutMargins.top, cell.layoutMargins.left + 10 * nodeIndexPath.length, cell.layoutMargins.bottom, cell.layoutMargins.right);
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath *nodeIndexPath = [self indexPaths][indexPath.row];
    [self.treeViewDelegate treeView:self didSelectNodeAtIndexPath:nodeIndexPath];
    
    if ([self.treeViewDelegate treeView:self isNodeExpandedAtIndexPath:nodeIndexPath]) {
        [self collapseNodeAtIndexPath:nodeIndexPath animated:YES];
    } else {
        [self expandNodeAtIndexPath:nodeIndexPath animated:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.treeViewDelegate respondsToSelector:@selector(treeView:heightForNodeAtIndexPath:)]) {
        NSIndexPath *nodeIndexPath = [self indexPaths][indexPath.row];
        return [self.treeViewDelegate treeView:self heightForNodeAtIndexPath:nodeIndexPath];
    } else {
        return (self.rowHeight >= 0) ? self.rowHeight : 44;
    }
}

@end
