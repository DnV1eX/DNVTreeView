//
//  DNVTreeViewController.h
//  DNVTreeView
//
//  Created by Alexey Demin on 20/05/15.
//  Copyright (c) 2015 Alexey Demin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNVTreeView.h"


@interface DNVTreeViewController : UIViewController <DNVTreeViewDataSource, DNVTreeViewDelegate>

@property (nonatomic) DNVTreeView *treeView;

@end

