//
//  TableViewCell.m
//  TableViewDemo
//
//  Created by nilsun on 14-3-27.
//  Copyright (c) 2014年 nilsun. All rights reserved.
//

#import "TableViewCell.h"
#import "CellData.h"

#pragma mark - TableViewCell

@implementation TableViewCell

+ (TableViewCell *)tableViewCellWithCellData:(CellData*)cellData
{
    switch (cellData.cellType)
    {
        case kTableViewPlainTextCell:
            return [[TableViewPlainTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellData.cellResueIdentifier];
            break;
        case kTableViewSliderCell:
            return [[TableViewSliderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellData.cellResueIdentifier];
            break;
        case kTableViewSwitchCell:
            return [[TableViewSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellData.cellResueIdentifier];
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

#pragma mark - TableViewPlainTextCell

@interface TableViewPlainTextCell()
{
    UILabel *_cellTextLabel;
}
@end

@implementation TableViewPlainTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _cellTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 2, 150, 40)];
        _cellTextLabel.textAlignment = NSTextAlignmentRight;
        self.accessoryView = _cellTextLabel;
    }
    return self;
}

- (void)setCellData:(PlainTextCellData*)cellData
{
    [super setCellData:cellData];
    _cellTextLabel.text = cellData.cellTextStr;
}

@end

#pragma mark - TableViewSliderCell

@interface TableViewSliderCell()
{
    UISlider *_slider;
    UITextField *_sliderValueTextField;
}
@end

@implementation TableViewSliderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(100, 2, 150, 40)];
        [_slider setMaximumValue:100.0f];
        [_slider setMinimumValue:0.0f];
        [self addSubview:_slider];
        
        _sliderValueTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 2, 50, 40)];
        _sliderValueTextField.textAlignment = NSTextAlignmentRight;
        self.accessoryView = _sliderValueTextField;
    }
    return self;
}

- (void)dealloc
{
    [_cellData removeObserver:self forKeyPath:@"selected"];
    [_cellData removeObserver:self forKeyPath:@"switchOn"];
}

- (void)setCellData:(SliderCellData*)cellData
{
    [super setCellData:cellData];
    _slider.value = cellData.sliderValue;
    [self setTextFieldTextWithSliderValue:cellData.sliderValue];
    
    [self createObserveRelationWithCellData:cellData];
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

- (void)setTextFieldTextWithSliderValue:(float)sliderValue
{
    _sliderValueTextField.text = [NSString stringWithFormat:@"%d", (int)sliderValue];
}

- (void)createObserveRelationWithCellData:(SliderCellData*)cellData
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
    
    //Cocoa Binding: mutual observing
    [cellData addObserver:self
               forKeyPath:@"sliderValue"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    
//    [_slider addObserver:self
//              forKeyPath:@"value"
//                 options:NSKeyValueObservingOptionNew
//                 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //model changed
    if ([keyPath isEqualToString:@"sliderValue"])
    {
        float modelValue = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        _slider.value = modelValue;
    }
    
    //slider UI mannually changed
    if ([keyPath isEqualToString:@"value"])
    {
        NSLog(@"ddfdfd");
        float sliderValue = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        [(SliderCellData*)_cellData setSliderValueWithNotification:sliderValue];
        [self setTextFieldTextWithSliderValue:sliderValue];
    }
}

@end

#pragma mark - TableViewSwitchCell

@interface TableViewSwitchCell()
{
    UISwitch *_switch;
}
@end

@implementation TableViewSwitchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _switch = [[UISwitch alloc] init];
        self.accessoryView = _switch;
    }
    return self;
}

- (void)setCellData:(SwitchCellData*)cellData
{
    [super setCellData:cellData];
    [_switch setOn:cellData.switchOn];
}

@end



