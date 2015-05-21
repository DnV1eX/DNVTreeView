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

- (NSInteger)treeView:(DNVTreeView *)treeView numberOfRowsInNodeAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)treeView:(DNVTreeView *)treeView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface DNVTreeView : UITableView

@property (nonatomic, weak) id<DNVTreeViewDataSource> dataSource;

@end
