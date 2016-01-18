//
//  HRDetailSectionZeroCell.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "HRDetailSectionZeroCell.h"
#import "AppDelegate.h"
@implementation HRDetailSectionZeroCell

-(void)setUIWithInfo:(HRDetailDataModel *)model andData:(NSMutableArray *)dataArray{

    _itemScroll.contentSize = CGSizeMake(_itemScroll.frame.size.width, dataArray.count * 21);
    for (int i=0; i<dataArray.count; i++) {
    
        ServiceItemView *itemView = [[ServiceItemView alloc]initWithFrame:CGRectMake(0, 21*i, _itemScroll.frame.size.width, 21)];
        itemView.itemLab.text = dataArray[i];
        itemView.itemLab.font = [UIFont systemFontOfSize:13];
        itemView.itemLab.textColor = [UIColor darkGrayColor];
        [_itemScroll addSubview:itemView];
    }

    _mileageLab.text = [NSString stringWithFormat:@"%@公里",model.repairmile];
    _faultLab.text = model.faultdescript;
    [_faultLab sizeToFit];
    _reasonLab.text = model.faultreason;
    _numberLab.text = model.workorderno;
    _guaranteeLab.text = [NSString stringWithFormat:@"%@天",model.securitydate];
    
}

- (void)awakeFromNib {
    // Initialization code
    [AppDelegate storyBoradAutoLay:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
