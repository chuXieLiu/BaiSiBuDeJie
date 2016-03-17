//
//  BSCommentHeaderView.h
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/16.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSCommentHeaderView : UITableViewHeaderFooterView

+ (instancetype)commentHeaderViewWithTableView:(UITableView *)tableView;

@property (nonatomic,copy) NSString *title;


@end
