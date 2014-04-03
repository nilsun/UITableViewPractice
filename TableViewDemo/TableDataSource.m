//
//  TableDataSource.m
//  TableViewDemo
//
//  Created by nilsun on 14-3-26.
//  Copyright (c) 2014年 nilsun. All rights reserved.
//

#import "TableDataSource.h"
#import "CellData.h"

@interface TableDataSource()
{
    NSMutableArray *_cellDatas;
}
@end

@implementation TableDataSource

- (id)init
{
    if (self = [super init])
    {
        _cellDatas = [[NSMutableArray alloc] init];
//        [self initCellDatas];
    }
    return self;
}

- (void)addData:(CellData*)cellData forSection:(NSInteger)section
{
    int maxSection = [self sectionCount] - 1;

    if (maxSection < section)
    {
        for (int i = 0; i < section - maxSection; i++)
        {
            [_cellDatas addObject:[[NSMutableArray alloc] init]];
        }
    }
    [(NSMutableArray*)[_cellDatas objectAtIndex:section] addObject:cellData];
}

- (NSInteger)sectionCount
{
    return [_cellDatas count];
}

- (NSInteger)rowCountInSection:(NSInteger)section;
{
    NSInteger rowCount = 0;
    NSMutableArray *sectionData = [_cellDatas objectAtIndex:section];

    for (CellData *data in sectionData)
    {
        rowCount++;
    }
    
    return rowCount;
}

- (CellData *)cellDataAtIndexPath:(NSIndexPath*)indexPath
{
    return [[_cellDatas objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}


@end
