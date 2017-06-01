//
//  ViewController.m
//  RMTableViewHeaderAnimation
//
//  Created by Watson on 2016/12/22.
//  Copyright © 2016年 renming. All rights reserved.
//

#import "ViewController.h"
#import "TestRMPullDown.h"
#import "TestRMHideBarOnSwipe.h"
#import "TestRMMultipleHeaderView.h"
#import "TestAnimationIcon.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            {
                /*下拉放大tableView表头效果，只需继承"RMPullDownTableViewController"，且在“initWithHeaderViewName...andHeaderHeight”方法中设置表头图片名字 及 表头高度 即可 */
                TestRMPullDown *test = [[TestRMPullDown alloc] initWithHeaderViewName:@"1" andHeaderHeight:150];
                [self presentViewController:test animated:YES completion:nil];
            }
            break;
        case 1:
            {
                /*tableView向上滑动时，动态隐藏navigationBar 及 tabBar,向下滑动时，动态显示navigationBar 及 tabBar，只需继承自"RMHideBarOnSwipeTableViewController"即可 */
                [self.navigationController pushViewController:[TestRMHideBarOnSwipe new] animated:YES];
            }
            break;
        case 2:
            {
                /*下拉拉伸完整表头并动态在合适时机显示导航栏效果，只需继承"RMMultipleHeaderViewController"，且在“initWithTopViewName...andtableHeaderHeight”方法中设置表头图片名字 及 表头高度 即可(视图为viewController，内含tableView，可作正常tableViewController使用，视图进入时会自动隐藏导航栏与选项卡) */
                TestRMMultipleHeaderView *test = [[TestRMMultipleHeaderView alloc] initWithTopViewName:@"1" andtableHeaderHeight:235];
                [self.navigationController pushViewController:test animated:YES];
            }
            break;
        case 3:
            {
                /*上拉时，头像会边缩放边往导航栏靠近，tableViewCell出现时，导航栏会出现并且头像会停止在导航栏上，只需继续“RMAnimationIconViewController”，且使用初始化方法"initWithTopViewName...tableHeaderHeight...iconImageName..."即可，TopViewName是tableViewHeader的背景图，tableHeaderHeight是tableView的表头高度，iconImageName为头像名字，iconSize为头像初始大小(宽高一致)，iconHeight为初始时头像的初始Y值 */
                TestAnimationIcon *test = [[TestAnimationIcon alloc] initWithTopViewName:@"1" tableHeaderHeight:235 iconImageName:@"a" iconSize:100 iconHeight:120];

                [self.navigationController pushViewController:test animated:YES];
            }
        default:
            break;
    }
}


@end
