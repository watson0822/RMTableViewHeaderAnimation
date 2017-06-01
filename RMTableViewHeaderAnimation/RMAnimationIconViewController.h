//
//  RMAnimationIconViewController.h
//  RMTableViewHeaderAnimation
//
//  Created by Watson on 2016/12/29.
//  Copyright © 2016年 renming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMAnimationIconViewController : UIViewController

/**tableView**/
@property (nonatomic) UITableView* tableView;

-(instancetype)initWithTopViewName:(NSString *)imageName tableHeaderHeight:(NSInteger)headerHeight iconImageName:(NSString *)iconName iconSize:(CGFloat)iconSize iconHeight:(CGFloat)iconHeight;

@end
