//
//  TableDataSource.h
//  TableViewDemo
//
//  Created by nilsun on 14-3-26.
//  Copyright (c) 2014年 nilsun. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CellData;

@protocol TableViewDataSourceDelegate <NSObject>

- (NSInteger)sectionCount;
- (NSInteger)rowCountInSection:(NSInteger)section;
- (CellData *)cellDataAtIndexPath:(NSIndexPath*)indexPath;
- (void)addData:(CellData*)cellData forSection:(NSInteger)section;
@end

@interface TableDataSource : NSObject <TableViewDataSourceDelegate>
@end
