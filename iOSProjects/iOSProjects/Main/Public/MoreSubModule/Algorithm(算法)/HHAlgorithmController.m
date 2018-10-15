//
//  HHAlgorithmController.m
//  iOSProjects
//
//  Created by flowerflower on 2018/8/20.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHAlgorithmController.h"

typedef NS_ENUM(NSInteger,HHAlgorithmBtnType){
    
    HHAlgorithmBtnTypeBubbleSort,  //冒泡排序
    HHAlgorithmBtnTypeSelectSort,  //选择排序
    HHAlgorithmBtnTypeInserSort,   //插入排序
    HHAlgorithmBtnTypeFastSort,    //快速排序
    HHAlgorithmBtnTypeShellSort,   //希尔排序
    HHAlgorithmBtnTypeMergingSort, //归并排序
    HHAlgorithmBtnTypeRadixSort,   //基数排序
};

@interface HHAlgorithmController ()



@property(nonatomic, strong)UILabel *sortBeforeLabel; //没有排序前

@property(nonatomic, strong)UILabel *sortAfterLabel; // 排序后

@property(nonatomic, strong)NSMutableArray *sortArr; //


@property(nonatomic, strong)UITextView *inputTextView; // 实现Label

@end

@implementation HHAlgorithmController



NSInteger numberLength(NSNumber *number) {
    
    NSString *string = [NSString stringWithFormat:@"%ld", (long)[number integerValue]];
    return string.length;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSubView];

}


#pragma mark - setupSubView

- (void)setupSubView{
    
    NSArray *titles  = @[@"冒泡排序",@"选择排序",@"插入排序",@"快速排序",@"希尔排序",@"归并排序",@"基数排序",@"堆排序"];
    
    int totalloc = 4; //一行的列数
    CGFloat btnW =  80;
    CGFloat bthH = 40;
    CGFloat btnY = 0;
    CGFloat margin = (Screen_Width- btnW * totalloc)/(totalloc + 1);
    for (int i = 0; i < titles.count; i++) {
        
        CGFloat btnX = margin + ((margin + btnW) * (i % totalloc));
        btnY = margin + ((margin + bthH) * (i / totalloc));
        
        UIButton *btn = [UIButton buttontitle:[titles safeObjectAtIndex:i] frame:CGRectMake(btnX, btnY, btnW, bthH) target:self action:@selector(btnOnClick:)];
        btn.backgroundColor = [UIColor hh_redomColor];
        btn.tag = i ;
        [self.view addSubview:btn];
        
    }
    

    
    self.sortBeforeLabel = [UILabel labelText:@"" fontSize:10 textColor:[UIColor blackColor] textAlignment:1];
    self.sortBeforeLabel.backgroundColor = [UIColor orangeColor];
    self.sortBeforeLabel.numberOfLines = 0;
    self.sortBeforeLabel.frame = CGRectMake(10, 130, (Screen_Width - 3  * 10)/2, 140);
    self.sortBeforeLabel.text = [NSString stringWithFormat:@"排序前: %@",self.sortArr];
    [self.view addSubview:self.sortBeforeLabel];
    
    
    
    self.sortAfterLabel = [UILabel labelText:@"" fontSize:10 textColor:[UIColor blackColor] textAlignment:1];
    self.sortAfterLabel.backgroundColor = [UIColor orangeColor];
    self.sortAfterLabel.numberOfLines = 0;
    self.sortAfterLabel.frame = CGRectMake(CGRectGetMaxX(self.sortBeforeLabel.frame) + 10, self.sortBeforeLabel.y, self.sortBeforeLabel.width - 10, 140);
    
    [self.view addSubview:self.sortAfterLabel];
    
     UITextView *textView = [[UITextView alloc] init];
    [self.view addSubview:textView];

    textView.userInteractionEnabled = YES;
    textView.editable = NO;
    textView.selectable = NO;
    textView.scrollEnabled = YES;
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsMake(300, 0, 0, 0));
        
    }];
    textView.textColor = [UIColor redColor];
    textView.font = kFont(10);

    _inputTextView = textView;
    
}

- (void)btnOnClick:(UIButton *)sender{
    

    if (sender.tag == HHAlgorithmBtnTypeBubbleSort) {//冒泡排序
        
        [self bubbleSortWithArray:self.sortArr];
        
        
    }else if (sender.tag == HHAlgorithmBtnTypeSelectSort){//选择排序
        
        [self selectSortWithArray:self.sortArr];
        
    }else if (sender.tag == HHAlgorithmBtnTypeInserSort){//插入排序
        
        [self inserSortWithArray:self.sortArr];

        
    }else if (sender.tag == HHAlgorithmBtnTypeFastSort){//快速排序
        
        [self fastSortWithArray:self.sortArr];
        
    }else if (sender.tag == HHAlgorithmBtnTypeShellSort){ //希尔排序
        
        [self shellSortWithArray:self.sortArr];
        
    }else if (sender.tag == HHAlgorithmBtnTypeMergingSort){//归并排序
        
        [self mergingSortWithArray:self.sortArr];
        
    }else if (sender.tag == HHAlgorithmBtnTypeRadixSort){//基数排序
        
        [self radixSortWithArray:self.sortArr];
    }
    
    NSLog(@"%@ ---- %li",sender.titleLabel.text,(long)sender.tag);
    
}



/**
 冒泡排序实现思路:
 1.每一趟比较数组中相邻元素的大小
 2.如果i元素小于i-1元素，就调换两个元素的位置
 3.重复n-1趟的比较

 */
- (void)bubbleSortWithArray:(NSMutableArray *)array{

       //1.循环控制比较次数
  for (int i = 0; i < array.count; i++) {
      //2.两两比较
    for (int j = 0; j < array.count - 1- i; j++) {
        //3.交换位置
        if ([array[j] intValue]  < [array[j +1] intValue]) { //降序排序
            //if ([array[j + 1] intValue]  < [array[j ] intValue]) { //升序排序
            
            int temp = [array[j] intValue];
            
            array[j]  = array[j + 1];
            
            array[j+ 1]  =  [NSNumber numberWithInt:temp];
            
        }
    }
}
        self.sortAfterLabel.text = [NSString stringWithFormat:@"冒泡排序后：%@",self.sortArr];
    
    self.inputTextView.text = @"   冒泡排序实现思路: \n\
1.每一趟比较数组中相邻元素的大小  \n\
2.如果i元素小于i-1元素，就调换两个元素的位置 \n\
3.重复n-1趟的比较 \n\
                             \n\
                                    //1.循环控制比较次数 \n\
                              for (int i = 0; i < array.count; i++) { \n\
                                  //2.两两比较 \n\
                                  for (int j = 0; j < array.count - 1- i; j++) { \n\
                                      //3.交换位置 \n\
                                      if ([array[j] intValue]  < [array[j +1] intValue]) { //降序排序 \n\
                                          //if ([array[j + 1] intValue]  < [array[j ] intValue]) { //升序排序 \n\
                                          int temp = [array[j] intValue]; \n\
                                          array[j]  = array[j + 1]; \n\
                                          array[j+ 1]  =  [NSNumber numberWithInt:temp]; \n\
                                      }\n\
                                  }\n\
    };\n\
    ";
}
- (void)selectSortWithArray:(NSMutableArray *)array{
    
    
    for (int i = 0; i < array.count ; i++) {
        
        for (int j = i + 1; j < array.count; j++) {
//            if ([array[i] intValue] < [array[j] intValue]) {  //降序排序
                if ([array[i] intValue] > [array[j] intValue]) { //升序排序

                
                int temp = [array[i] intValue];
                                array[i] = array[j];
                array[j] = [NSNumber numberWithInt:temp];
            }
        }
        
        NSLog(@"选择:%@",self.sortArr);
       
    }
    self.sortAfterLabel.text = [NSString stringWithFormat:@"选择排序后：%@",self.sortArr];

    self.inputTextView.text = @"for (int i = 0; i < array.count ; i++) {\n\
    for (int j = i + 1; j < array.count; j++) {\n\
        //            if ([array[i] intValue] < [array[j] intValue]) {  //降序排序 \n\
        if ([array[i] intValue] > [array[j] intValue]) { //升序排序 \n\
            int temp = [array[i] intValue]; \n\
            array[i] = array[j]; \n\
            array[j] = [NSNumber numberWithInt:temp];\n\
        }\n\
    }\n\
    ";
    
}
/**
 　4、插入排序：
 
 　　实现思路：
 
 　　1. 从第一个元素开始，认为该元素已经是排好序的。
 　　2. 取下一个元素，在已经排好序的元素序列中从后向前扫描。
 　　3. 如果已经排好序的序列中元素大于新元素，则将该元素往右移动一个位置。
 　　4. 重复步骤3，直到已排好序的元素小于或等于新元素。
 　　5. 在当前位置插入新元素。
 　　6. 重复步骤2。
 
 　　复杂度：
 
 　　平均时间复杂度：O(n^2)
 　　平均空间复杂度：O(1)
 */
- (void)inserSortWithArray:(NSMutableArray *)array{
    

    for (int i = 1; i < array.count; i ++) {
        
        int temp = [array[i] intValue];
        
        for (int j = i -1 ; j >=0 && temp < [array[j] intValue]; j--) {
            
            array[j + 1] = array[j];
            array[j] = [NSNumber numberWithInt:temp];
        }
        NSLog(@"插入:%@",self.sortArr);
    }
    
    
    self.sortAfterLabel.text = [NSString stringWithFormat:@"插入排序后：%@",self.sortArr];
    
    self.inputTextView.text =@" 插入排序实现思路： \n\
1. 从第一个元素开始，认为该元素已经是排好序的。 \n\
2. 取下一个元素，在已经排好序的元素序列中从后向前扫描。\n\
3. 如果已经排好序的序列中元素大于新元素，则将该元素往右移动一个位置。\n\
4. 重复步骤3，直到已排好序的元素小于或等于新元素。\n\
5. 在当前位置插入新元素。\n\
6. 重复步骤2。\n\
    \n\
    for (int i = 1; i < array.count; i ++) { \n\
    int temp = [array[i] intValue];\n\
    for (int j = i -1 ; j >=0 && temp < [array[j] intValue]; j--) {\n\
        array[j + 1] = array[j]; \n\
        array[j] = [NSNumber numberWithInt:temp];\n\
    }\n\
   }\n\
    ";
}

//快速排序
- (void)fastSortWithArray:(NSMutableArray *)array{
    
    
    
}
//希尔排序
- (void)shellSortWithArray:(NSMutableArray *)array{
    
    
    
}
//归并排序
- (void)mergingSortWithArray:(NSMutableArray *)array{
    
    
    
    
}
/**
 基数排序
 首先根据个位数的数值，在走访数值时将它们分配至编号0到9的桶子中：
 */



- (void)radixSortWithArray:(NSMutableArray *)array{
    
//    _sortArr = [NSMutableArray arrayWithArray:@[@"12",@"29",@"36",@"17",@"54",@"81"]];

    NSMutableArray *buckt = [self createBucket];

    
    NSNumber *maxNumber = [self listMaxItem:array];
    
    NSInteger maxNumLength = numberLength(maxNumber);
    
    for (int digit = 1 ; digit <= maxNumLength; digit++) {
        
        for (NSNumber *item in array) {
        
            NSInteger baseNumber = [self fetchBaseNumber:item digit:digit];
            
            NSMutableArray *mutArr = buckt[baseNumber];
            
            [mutArr addObject:item];
        }
        
    }
    
    NSLog(@"%@---------%@",buckt,maxNumber);
    
    
}

//12 1

- (NSInteger)fetchBaseNumber:(NSNumber *)number digit:(NSInteger)digit{
    
    
    if (digit >0 && digit <= numberLength(number)) {
        
        NSMutableArray *numberArr = [NSMutableArray array];
        NSString *string = [NSString stringWithFormat:@"%ld",[number integerValue]];
        
        for (int index = 0; index < numberLength(number); index++) {
            
            [numberArr addObject:[string substringWithRange:NSMakeRange(index, 1)]];

            
        }
        
        NSString *str  = numberArr[numberArr.count - digit];
        
        
        NSLog("strstr:------%zd",[str integerValue]);
        
        return [str integerValue];
        
    }
    
    return 0;
    
}







- (NSMutableArray *)createBucket{
    
//    首先根据个位数的数值，在走访数值时将它们分配至编号0到9的桶子中：

    NSMutableArray *bucket = [NSMutableArray array];
    for (int index = 0; index < 10 ; index ++) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        [bucket addObject:array];
    }
    return bucket;
    
    
}




- (NSNumber *)listMaxItem:(NSArray *)list{
    
    
    NSNumber *maxNumber = list[0];
    
    
    for (NSNumber *number in list) {
        
        if ([maxNumber integerValue] < [number integerValue]) {
         
            
            maxNumber = number;
        }
        
    }
    
    return maxNumber;
}

- (NSMutableArray *)sortArr{
    
    if (!_sortArr) {
        _sortArr = [NSMutableArray arrayWithArray:@[@"12",@"29",@"36",@"17",@"54",@"81"]];

//        _sortArr = [NSMutableArray arrayWithArray:@[@"2",@"9",@"6",@"7",@"4",@"1"]];
    }
    return _sortArr;
    
}

@end
