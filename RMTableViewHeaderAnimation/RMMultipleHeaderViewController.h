//
//  RMMultipleHeaderViewController.h
//  RMTableViewHeaderAnimation
//
//  Created by Watson on 2016/12/27.
//  Copyright © 2016年 renming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMMultipleHeaderViewController : UIViewController

/**tableView**/
@property (nonatomic) UITableView* tableView;

-(instancetype)initWithTopViewName:(NSString *)imageName andtableHeaderHeight:(NSInteger)headerHeight;

@end
