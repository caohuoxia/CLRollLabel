//
//  ViewController.m
//  CLRollLabel
//
//  Created by ClaudeLi on 16/5/6.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import "ViewController.h"
#import "CLRollLabel.h"
#import "AutoScrollLabel.h"
#import "ZoomImageVC.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    CLRollLabel *rollLabel;
    AutoScrollLabel *scrollLabel;
    NSArray *arrTitles;
}
@property(nonatomic, strong)UICollectionView *myCollectionView;
@end

@implementation ViewController

- (UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.minimumInteritemSpacing = 10;// 垂直方向的间距
        layout.minimumLineSpacing = 10; // 水平方向的间距
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 260, ScreenWidth, ScreenHeight -260) collectionViewLayout:layout];
        _myCollectionView.backgroundColor = [UIColor redColor];
        _myCollectionView.dataSource = self;
        _myCollectionView.delegate = self;
    }
    return _myCollectionView;
}

- (void)btnItemClicked{
    [self.navigationController pushViewController:[ZoomImageVC new] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc]initWithTitle:@"zoomImage" style:UIBarButtonItemStylePlain target:self action:@selector(btnItemClicked)];
    self.navigationItem.rightBarButtonItem = btnItem;
//    rollLabel = [[CLRollLabel alloc] initWithFrame:CGRectMake(10, 100, 200, 50) font:[UIFont systemFontOfSize:17] textColor:[UIColor redColor]];
//    rollLabel.backgroundColor = [UIColor blackColor];
//    rollLabel.text = @"今后贼界差人齎到文字";//，如依前僭伪，立便发遣出界，不得收接。
//    [self.view addSubview:rollLabel];
    
    scrollLabel = [[AutoScrollLabel alloc]initWithFrame:CGRectMake(10, 100, 200, 50)];
    scrollLabel.text = @"Hi Mom!  How are you?  I really ought to write more often.";// are you?  I really ought to write more often.
    scrollLabel.textColor = [UIColor blackColor];//默认白色
    scrollLabel.backgroundColor = [UIColor greenColor];
    [self.view addSubview:scrollLabel];
    
    [self creatButton1];
    [self creatButton2];
    
    // 注册collectionViewcell:WWCollectionViewCell是我自定义的cell的类型
    [self.myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    arrTitles = @[@"充值",@"提现",@"投资",@"全部",@"提现手续费",@"红包奖励",@"项目回款",@"活动奖励",@"其他",@"其他",
                  @"其他",@"其他",@"其他",@"其他",@"其他"];
}

- (void)creatButton1{
    UIButton* button = [UIButton new];
    button.tag = 100;
    button.frame = CGRectMake(100, 200, 200, 50);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"筛选-collectionview样式" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)creatButton2{
    UIButton* button = [UIButton new];
    button.tag = 101;
    button.frame = CGRectMake(310, 200, 50, 50);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"zoomImageVC" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)clickButtonAction:(UIButton *)btn{
//    rollLabel.text = @"---add-sa-dsadasda-das-d-as-das-dasd-avcxv-d-ffsfas";
    if (btn.tag == 100) {
        [self.view addSubview:self.myCollectionView];
    }else{
        [self presentViewController:[ZoomImageVC new] animated:NO completion:nil];
    }
    
}

#pragma mark - UICollectionViewDataSource
/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    UILabel *lb = [[UILabel alloc]initWithFrame:cell.bounds];
    lb.text = arrTitles[indexPath.row];
    lb.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:lb];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 50);
}

/** section的margin*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"===========%ld",(long)indexPath.row);//s形排列：indexPath.row和indexPath.item效果一样
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
