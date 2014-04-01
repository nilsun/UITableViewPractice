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
    SliderCellData *cellData;
    NSMutableArray *sectionOne = [[NSMutableArray alloc] init];
//    NSMutableArray *sectionTwo = [[NSMutableArray alloc] init];
//    NSMutableArray *sectionThree = [[NSMutableArray alloc] init];

    //construct section one datasource
    cellData = [[SliderCellData alloc] initWithCellType:kTableViewSliderCell];
    [sectionOne addObject:cellData];
    cellData = [[SliderCellData alloc] initWithCellType:kTableViewSliderCell];
    [sectionOne addObject:cellData];
    cellData = [[SliderCellData alloc] initWithCellType:kTableViewSliderCell];
    [sectionOne addObject:cellData];
    [_cellDatas addObject:sectionOne];

    //construct section two datasource
//    cellDataSource = [[CellDataSource alloc] initWithTitle:@"1-1" isSelected:NO isSwitchOn:YES];
//    [sectionTwo addObject:cellDataSource];
//    cellDataSource = [[CellDataSource alloc] initWithTitle:@"1-2" isSelected:NO isSwitchOn:NO];
//    [sectionTwo addObject:cellDataSource];
//    cellDataSource = [[CellDataSource alloc] initWithTitle:@"1-3" isSelected:NO isSwitchOn:YES];
//    [sectionTwo addObject:cellDataSource];
//    cellDataSource = [[CellDataSource alloc] initWithTitle:@"1-4" isSelected:NO isSwitchOn:NO];
//    [sectionTwo addObject:cellDataSource];
//    [_cellDataSources addObject:sectionTwo];
//    
//    cellDataSource = [[CellDataSource alloc] initWithTitle:@"2-1" isSelected:NO isSwitchOn:YES];
//    [sectionThree addObject:cellDataSource];
//    cellDataSource = [[CellDataSource alloc] initWithTitle:@"2-2" isSelected:NO isSwitchOn:NO];
//    [sectionThree addObject:cellDataSource];
//    cellDataSource = [[CellDataSource alloc] initWithTitle:@"2-3" isSelected:NO isSwitchOn:YES];
//    [sectionThree addObject:cellDataSource];
//    [_cellDataSources addObject:sectionThree];
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
