//
//  TableViewCell.h
//  TableViewDemo
//
//  Created by nilsun on 14-3-27.
//  Copyright (c) 2014年 nilsun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellData.h"

//@protocol TableViewCellDelegate <NSObject>
//- (void)setCellData:(CellData*)cellData;
//@end

@interface TableViewCell : UITableViewCell
{
    CellData *_cellData;
}

+ (TableViewCell*)tableViewCellWithCellData:(CellData*)cellData;
- (void)setCellData:(CellData*)cellData;
@end


@interface TableViewSliderCell : TableViewCell
@end
