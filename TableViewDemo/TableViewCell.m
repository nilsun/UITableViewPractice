//
//  TableViewCell.m
//  TableViewDemo
//
//  Created by nilsun on 14-3-27.
//  Copyright (c) 2014年 nilsun. All rights reserved.
//

#import "TableViewCell.h"
#import "CellData.h"

@implementation TableViewCell

+ (TableViewCell *)tableViewCellWithCellData:(CellData*)cellData
{
    switch (cellData.cellType)
    {
        case kTableViewPlainTextCell:
            return nil;
            break;
        case kTableViewSwitchCell:
            return nil;
            break;
        case kTableViewSliderCell:
            return [[TableViewSliderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellData.cellResueIdentifier];
            break;
    }
    return nil;
}


- (void)setCellData:(CellData*)cellData
{
    _cellData = cellData;
    self.textLabel.text = _cellData.cellResueIdentifier;
}

@end







@interface TableViewSliderCell()
{
//    SliderCellData *_cellData;
    UISwitch *_switch;
    UISlider *_slider;
}
@end

@implementation TableViewSliderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        _switch = [[UISwitch alloc] init];
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(100, 2, 150, 40)];
        [self addSubview:_slider];
//        self.accessoryView = _switch;
    }
    return self;
}

- (void)dealloc
{
    [_cellData removeObserver:self forKeyPath:@"selected"];
    [_cellData removeObserver:self forKeyPath:@"switchOn"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setCellData:(SliderCellData*)cellData
{
    [super setCellData:cellData];
    
//    _cellData = cellData;
//    self.textLabel.text = _cellDataSource.cellTitle;
//    [self.imageView setImage:_cellDataSource.selected ? nil : [UIImage imageNamed:@"icon_status_unread"]];
//    [_switch setOn:_cellData.switchOn animated:YES];
    
//    [self observeCellData:cellData];
//    [_switch addTarget:self action:@selector(onSwitchValueChanged:) forControlEvents:UIControlEventTouchUpInside];
}

//- (void)onSwitchValueChanged:(id)sender
//{
//    _cellData.switchOn = [(UISwitch*)sender isOn];
//}

- (void)observeCellData:(SliderCellData*)cellData
{
    //KVO
//    [cellData addObserver:self
//               forKeyPath:@"selected"
//                  options:NSKeyValueObservingOptionNew
//                  context:nil];
    
    //Cocoa Binding: mutual observing
//    [cellData addObserver:self
//               forKeyPath:@"switchOn"
//                  options:NSKeyValueObservingOptionNew
//                  context:nil];
    
//    [_switch addObserver:cellDataSource
//              forKeyPath:@"on"
//                 options:NSKeyValueObservingOptionNew
//                 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    if ([keyPath isEqualToString:@"switchOn"])
//    {
//        BOOL switchOn = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
//        [_switch setOn:switchOn animated:NO];
//    }
}

@end






