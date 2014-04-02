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
        [self initCellDatas];
    }
    return self;
}

- (void)initCellDatas
{
    CellData *cellData;
    NSMutableArray *sectionOne = [[NSMutableArray alloc] init];
    NSMutableArray *sectionTwo = [[NSMutableArray alloc] init];
    NSMutableArray *sectionThree = [[NSMutableArray alloc] init];

    //construct section one data
    cellData = [[PlainTextCellData alloc] initWithCellType:kTableViewPlainTextCell withPlainText:@"click to see more"];
    [sectionOne addObject:cellData];
    [_cellDatas addObject:sectionOne];

    //construct section two data
    cellData = [[SliderCellData alloc] initWithCellType:kTableViewSliderCell withSliderValue:0];
    [sectionTwo addObject:cellData];
    cellData = [[SliderCellData alloc] initWithCellType:kTableViewSliderCell withSliderValue:50];
    [sectionTwo addObject:cellData];
    cellData = [[SliderCellData alloc] initWithCellType:kTableViewSliderCell withSliderValue:100];
    [sectionTwo addObject:cellData];
    [_cellDatas addObject:sectionTwo];
    
    //construct section three data
    cellData = [[SwitchCellData alloc] initWithCellType:kTableViewSwitchCell withSwitchOn:YES];
    [sectionThree addObject:cellData];
    cellData = [[SwitchCellData alloc] initWithCellType:kTableViewSwitchCell withSwitchOn:NO];
    [sectionThree addObject:cellData];
    [_cellDatas addObject:sectionThree];
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
