//
//  DNVTreeView.h
//  DNVTreeView
//
//  Created by Alexey Demin on 20/05/15.
//  Copyright (c) 2015 Alexey Demin. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DNVTreeView;

@protocol DNVTreeViewDataSource <NSObject>

- (NSInteger)treeView:(DNVTreeView *)treeView numberOfChildNodesAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)treeView:(DNVTreeView *)treeView cellForNodeAtIndexPath:(NSIndexPath *)indexPath;

@end


@protocol DNVTreeViewDelegate <NSObject>

- (BOOL)treeView:(DNVTreeView *)treeView isNodeExpandedAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (void)treeView:(DNVTreeView *)treeView didSelectNodeAtIndexPath:(NSIndexPath *)indexPath;
- (void)treeView:(DNVTreeView *)treeView willExpandNodeAtIndexPath:(NSIndexPath *)indexPath;
- (void)treeView:(DNVTreeView *)treeView willCollapseNodeAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface DNVTreeView : UITableView

@property (nonatomic, weak) id<DNVTreeViewDataSource> dataSource;
@property (nonatomic, weak) id<DNVTreeViewDelegate> delegate;

- (void)deselectNodeAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
- (void)expandNodeAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
- (void)collapseNodeAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

@end
