//
//  CellDataSource.h
//  TableViewDemo
//
//  Created by nilsun on 14-3-26.
//  Copyright (c) 2014年 nilsun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TableViewCellType)
{
    kTableViewPlainTextCell,
    kTableViewSliderCell,
    kTableViewSwitchCell
};


@interface CellData : NSObject
- (id)initWithCellType:(TableViewCellType)cellType;

@property (nonatomic, assign) TableViewCellType cellType;
@property (nonatomic, copy) NSString *cellResueIdentifier;
@end


@interface SliderCellData : CellData
- (id)initWithCellType:(TableViewCellType)cellType withSliderValue:(float)sliderValue;

@property (nonatomic, assign) float sliderValue;

- (void)setSliderValueWithNotification:(float)sliderValue;
@end


@interface PlainTextCellData : CellData
- (id)initWithCellType:(TableViewCellType)cellType withPlainText:(NSString*)textStr;

@property (nonatomic, copy) NSString *cellTextStr;
@end


@interface SwitchCellData : CellData
- (id)initWithCellType:(TableViewCellType)cellType withSwitchOn:(BOOL)switchOn;

@property (nonatomic, assign) BOOL switchOn;
@end