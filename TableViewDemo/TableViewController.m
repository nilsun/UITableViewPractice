//
//  TableViewController.m
//  TableViewDemo
//
//  Created by nilsun on 14-3-26.
//  Copyright (c) 2014年 nilsun. All rights reserved.
//

#import "TableViewController.h"
#import "TableDataSource.h"
#import "TableViewCell.h"
#import "CellData.h"

@interface UITableView (TouchToDismissKeyboard)
@end

@implementation UITableView (TouchToDismissKeyboard)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if ([hitView isKindOfClass:NSClassFromString(@"UITableViewWrapperView")])
    {
        [self endEditing:YES];
    }
    return hitView;
}

@end

@interface TableViewController ()
{
    id <TableViewDataSourceDelegate> _tableDataSource;
}
@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
       self.title = @"UITableView Practice";
        [self initTableDataSource];
    }
    return self;
}

- (void)initTableDataSource
{
    _tableDataSource = [[TableDataSource alloc] init];
    
    //Actuallly, you can abstract a class CellDataUI if you have your own data class.
    //construct section one data
    CellData *cellData;
    cellData = [[PlainTextCellData alloc] initWithCellType:kTableViewPlainTextCell withPlainText:@"click to see more"];
    cellData.target = self;
    cellData.action = @selector(onPlainTextCellPressed:withCellData:);
    [_tableDataSource addData:cellData forSection:0];
    
    //construct section two data
    cellData = [[SliderCellData alloc] initWithCellType:kTableViewSliderCell withSliderValue:0];
    cellData.target = self;
    cellData.action = @selector(onSliderCellPressed:andGoMaxWithCellData:);
    [_tableDataSource addData:cellData forSection:1];
    cellData = [[SliderCellData alloc] initWithCellType:kTableViewSliderCell withSliderValue:50];
    cellData.target = self;
    cellData.action = @selector(onSliderCellPressed:andGoMinWithCellData:);
    [_tableDataSource addData:cellData forSection:1];
    cellData = [[SliderCellData alloc] initWithCellType:kTableViewSliderCell withSliderValue:100];
    cellData.target = self;
    cellData.action = @selector(onSliderCellPressed:andGoHalfWithCellData:);
    [_tableDataSource addData:cellData forSection:1];
    
    //construct section three data
    cellData = [[SwitchCellData alloc] initWithCellType:kTableViewSwitchCell withSwitchOn:YES];
    cellData.target = self;
    cellData.action = @selector(onSwitchCellPressed:withCellData:);
    [_tableDataSource addData:cellData forSection:2];
    cellData = [[SwitchCellData alloc] initWithCellType:kTableViewSwitchCell withSwitchOn:NO];
    cellData.target = self;
    cellData.action = @selector(onSwitchCellPressed:withCellData:);
    [_tableDataSource addData:cellData forSection:2];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_tableDataSource sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableDataSource rowCountInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellData *cellData = [_tableDataSource cellDataAtIndexPath:indexPath];
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellData.cellResueIdentifier];
    
    if (!cell)
    {
        cell = [TableViewCell tableViewCellWithCellData:cellData];
    }
    [cell setCellData:cellData];
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CellData *cellData = [_tableDataSource cellDataAtIndexPath:indexPath];
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];

    if (cellData.target && cellData.action)
    {
        if ([cellData.target respondsToSelector:cellData.action])
        {
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [cellData.target performSelector:cellData.action withObject:selectedCell withObject:cellData];
        }
    }
}

#pragma mark - Action

- (void)onPlainTextCellPressed:(TableViewPlainTextCell*)tableViewCell withCellData:(PlainTextCellData*)cellData
{
    cellData.cellTextStr = @"cell clicked";
}

- (void)onSliderCellPressed:(TableViewSliderCell*)tableViewCell andGoMinWithCellData:(SliderCellData*)cellData
{
    cellData.sliderValue = 0.0f;
}

- (void)onSliderCellPressed:(TableViewSliderCell*)tableViewCell andGoHalfWithCellData:(SliderCellData*)cellData
{
    cellData.sliderValue = 50.0f;
}

- (void)onSliderCellPressed:(TableViewSliderCell*)tableViewCell andGoMaxWithCellData:(SliderCellData*)cellData
{
    cellData.sliderValue = 100.0f;
}

- (void)onSwitchCellPressed:(TableViewSwitchCell*)tableViewCell withCellData:(SwitchCellData*)cellData
{
    cellData.switchOn = !cellData.switchOn;
}

@end
