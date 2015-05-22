//
//  AppDelegate.h
//  DNVTreeView
//
//  Created by Alexey Demin on 20/05/15.
//  Copyright (c) 2015 Alexey Demin. All rights reserved.
//

#import <UIKit/UIKit.h>


#define AppDel ((AppDelegate *)[UIApplication sharedApplication].delegate)


extern NSString *const TreeNodeTitleKey;
extern NSString *const TreeNodeChildrenKey;
extern NSString *const TreeNodeIsExpandedKey;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) NSArray *treeNodes;

@end

