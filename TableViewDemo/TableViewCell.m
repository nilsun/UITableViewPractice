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

- (void)dealloc
{
    [_cellData removeObserver:self forKeyPath:@"cellTextStr"];
}

- (void)setCellData:(PlainTextCellData*)cellData
{
    [super setCellData:cellData];
    _cellTextLabel.text = cellData.cellTextStr;
    
    [self createObserveRelationWithCellData:cellData];
}

- (void)createObserveRelationWithCellData:(CellData*)cellData
{
    //KVO
    [cellData addObserver:self
               forKeyPath:@"cellTextStr"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"cellTextStr"])
    {
        NSString *modelValue = [change objectForKey:NSKeyValueChangeNewKey];
        _cellTextLabel.text = modelValue;
    }
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
        [_slider addTarget:self action:@selector(onSliderSlided:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_slider];
        
        _sliderValueTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 2, 50, 40)];
        _sliderValueTextField.textAlignment = NSTextAlignmentRight;
        _sliderValueTextField.delegate = self;
        _sliderValueTextField.returnKeyType = UIReturnKeyDone;
        [_sliderValueTextField addTarget:self
                                  action:@selector(textFieldFinished:)
                        forControlEvents:UIControlEventEditingDidEndOnExit];

        self.accessoryView = _sliderValueTextField;
    }
    return self;
}

- (void)dealloc
{
    [_cellData removeObserver:self forKeyPath:@"sliderValue"];
}

- (void)textFieldFinished:(id)sender
{
    [sender resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    int inputValue = [textField.text intValue];
    inputValue = inputValue > 100 ? 100 : inputValue;
    inputValue = inputValue < 0 ? 0 : inputValue;
    [self setCellDataSilderValue:inputValue];
}

- (void)onSliderSlided:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    [self setCellDataSilderValue:slider.value];
}

- (void)setTextFieldTextWithSliderValue:(float)sliderValue
{
    _sliderValueTextField.text = [NSString stringWithFormat:@"%d", (int)sliderValue];
}

- (void)setCellDataSilderValue:(float)sliderValue
{
    [(SliderCellData*)_cellData setSliderValue:sliderValue];
}

- (void)setCellData:(SliderCellData*)cellData
{
    [super setCellData:cellData];
    _slider.value = cellData.sliderValue;
    [self setTextFieldTextWithSliderValue:cellData.sliderValue];

    [self createObserveRelationWithCellData:cellData];
}

- (void)createObserveRelationWithCellData:(CellData*)cellData
{
    //Cocoa Binding: mutual observing
    [cellData addObserver:self
               forKeyPath:@"sliderValue"
                  options:NSKeyValueObservingOptionNew
                  context:nil];

    //Initially I try to use Cocoa binding here, but key value changed notification is only sent once when you first slide.
    //The reason is that UIKit doesn't actively support KVO. For efficiency consideration, I guess.
    //So I have to get continuous events through the UISlider's associated target's action method.
    //For more infomation: http://stackoverflow.com/questions/1482527/observing-a-uisliders-value-iphone-kvo
    
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
        [self setTextFieldTextWithSliderValue:modelValue];
    }
    
    //slider UI mannually changed
//    if ([keyPath isEqualToString:@"value"])
//    {
//        float sliderValue = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
//        [(SliderCellData*)_cellData setSliderValueWithNotification:sliderValue];
//        [self setTextFieldTextWithSliderValue:sliderValue];
//    }
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
        [_switch addTarget:self action:@selector(onSwitchValueChanged:) forControlEvents:UIControlEventTouchUpInside];
        self.accessoryView = _switch;
    }
    return self;
}

- (void)dealloc
{
    [_cellData removeObserver:self forKeyPath:@"switchOn"];
}

- (void)onSwitchValueChanged:(id)sender
{
    [(SwitchCellData*)_cellData setSwitchOn:[(UISwitch*)sender isOn]];
}

- (void)setCellData:(SwitchCellData*)cellData
{
    [super setCellData:cellData];
    [_switch setOn:cellData.switchOn];
    
    [self createObserveRelationWithCellData:cellData];
}

- (void)createObserveRelationWithCellData:(CellData*)cellData
{
    //KVO
    [cellData addObserver:self
               forKeyPath:@"switchOn"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"switchOn"])
    {
        float modelValue = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        [_switch setOn:modelValue];
    }
}

@end



