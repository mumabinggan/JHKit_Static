//
//  TWRefreshCollectionView.h
//  TWRefreshDemo
//
//  Created by Chris on 15/6/15.
//  Copyright (c) 2015 EasyBaking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+TWRefresh.h"
#import "TWRefresh.h"
#import "JHCollectionView.h"

@protocol TWCollectionViewRefreshingDelegate;

@interface TWRefreshCollectionView : JHCollectionView

//Refresh Delegate
@property (nonatomic, weak) id<TWCollectionViewRefreshingDelegate> refreshDelegate;

// Constructors
- (id) initWithFrame:(CGRect)frame refreshType:(TWRefreshType)type;
- (id) initWithFrame:(CGRect)frame refreshType:(TWRefreshType)type andAutoLoad:(BOOL) autoLoad;
- (id) initWithFrame:(CGRect)frame andAutoLoad:(BOOL) autoLoad;
- (id) initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout refreshType:(TWRefreshType) refreshType andAutoLoad:(BOOL) autoLoad;

@end

@protocol TWCollectionViewRefreshingDelegate <NSObject>

@optional
- (void) beginRefreshHeader:(TWRefreshCollectionView*) collectionView;
- (void) beginRefreshFooter:(TWRefreshCollectionView*) collectionView;

@end
