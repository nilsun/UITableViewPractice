//
//  CellDataSource.m
//  TableViewDemo
//
//  Created by nilsun on 14-3-26.
//  Copyright (c) 2014年 nilsun. All rights reserved.
//

#import "CellData.h"

#pragma mark - CellData

@implementation CellData

- (id)initWithCellType:(TableViewCellType)cellType
{
    if (self = [super init])
    {
        _cellType = cellType;
        
        switch (cellType)
        {
            case kTableViewPlainTextCell:
                _cellResueIdentifier = @"PlainTextCell";
                break;
            case kTableViewSliderCell:
                _cellResueIdentifier = @"SliderCell";
                break;
            case kTableViewSwitchCell:
                _cellResueIdentifier = @"SwitchCell";
                break;
        }
    }
    
    return self;
}

@end

#pragma mark - SliderCellData

@implementation SliderCellData

- (id)initWithCellType:(TableViewCellType)cellType withSliderValue:(float)sliderValue;
{
    if (self = [super initWithCellType:cellType])
    {
        _sliderValue = sliderValue;
    }
    return self;
}

- (void)setSliderValueWithNotification:(float)sliderValue
{
    _sliderValue = sliderValue;
}

@end

#pragma mark - PlainTextCellData

@implementation PlainTextCellData

- (id)initWithCellType:(TableViewCellType)cellType withPlainText:(NSString*)textStr
{
    if (self = [super initWithCellType:cellType])
    {
        _cellTextStr = textStr;
    }
    return self;

}

@end

#pragma mark - SwitchCellData

@implementation SwitchCellData

- (id)initWithCellType:(TableViewCellType)cellType withSwitchOn:(BOOL)switchOn
{
    if (self = [super initWithCellType:cellType])
    {
        _switchOn = switchOn;
    }
    return self;
}

@end


