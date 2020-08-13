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
    HHAlgorithmBtnTypeBubbleSort1,  //冒泡排序优化
    HHAlgorithmBtnTypeBubbleSort2,  //冒泡排序优化
    HHAlgorithmBtnTypeSelectSort,  //选择排序
    HHAlgorithmBtnTypeInserSort,   //插入排序
    HHAlgorithmBtnTypeFastSort,    //快速排序
    HHAlgorithmBtnTypeShellSort,   //希尔排序
    HHAlgorithmBtnTypeMergingSort, //归并排序
    HHAlgorithmBtnTypeRadixSort,   //基数排序
};

#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])


@interface HHAlgorithmController ()



@property(nonatomic, strong)UILabel *sortBeforeLabel; //没有排序前

@property(nonatomic, strong)UILabel *sortAfterLabel; // 排序后

@property(nonatomic, strong)NSMutableArray *sortArr; //


@property (nonatomic, strong) UIScrollView *scrollView;

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
    
    NSArray *titles  = @[@"冒泡排序",@"冒泡排序优化1",@"冒泡排序优化2",@"选择排序",@"插入排序",@"快速排序",@"希尔排序",@"归并排序",@"基数排序",@"堆排序"];
    
    int totalloc = 4; //一行的列数
    
    CGFloat btnW =  80;
    CGFloat bthH = 40;
    CGFloat btnY = 0;
    CGFloat margin = (Screen_Width- btnW * totalloc)/(totalloc + 1);
    
    UIButton *btn;
    
    for (int i = 0; i < titles.count; i++) {
        
        CGFloat btnX = margin + ((margin + btnW) * (i % totalloc));
        btnY = margin + ((margin + bthH) * (i / totalloc));
        
        
        btn = [UIButton buttontitle:[titles safeObjectAtIndex:i] frame:CGRectMake(btnX, btnY, btnW, bthH) target:self action:@selector(btnOnClick:)];
        btn.backgroundColor = [UIColor hh_redomColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.tag = i ;
        [self.view addSubview:btn];
        
        
        
        
    }
    
      
    
    NSString * s =  [self.sortArr componentsJoinedByString:@","];
    
    self.sortBeforeLabel = [UILabel labelText:@"" fontSize:10 textColor:[UIColor blackColor] textAlignment:1];
    self.sortBeforeLabel.backgroundColor = [UIColor orangeColor];
    self.sortBeforeLabel.numberOfLines = 0;
    self.sortBeforeLabel.text = [NSString stringWithFormat:@"排序前: %@",s];
    [self.view addSubview:self.sortBeforeLabel];
    [self.sortBeforeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(btn.mas_bottom).mas_offset(12);
        
    }];
    
    
    
    self.sortAfterLabel = [UILabel labelText:@"" fontSize:10 textColor:[UIColor blackColor] textAlignment:1];
    self.sortAfterLabel.backgroundColor = [UIColor orangeColor];
    self.sortAfterLabel.numberOfLines = 0;

    [self.view addSubview:self.sortAfterLabel];
    [self.sortAfterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(12);
         make.right.mas_equalTo(-12);
         make.top.mas_equalTo(self.sortBeforeLabel.mas_bottom).mas_offset(12);
        
         
     }];
    
     UITextView *textView = [[UITextView alloc] init];
    [self.view addSubview:textView];

    textView.userInteractionEnabled = YES;
    textView.editable = NO;
    textView.selectable = NO;
    textView.scrollEnabled = YES;
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sortAfterLabel.mas_bottom).mas_offset(12);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(self.view);
    }];
    textView.textColor = [UIColor redColor];
    textView.font = kFont(10);

    _inputTextView = textView;
    
}

- (void)btnOnClick:(UIButton *)sender{

    switch (sender.tag) {
        case HHAlgorithmBtnTypeBubbleSort: //冒泡排序
            [self bubbleSortWithArray:self.sortArr];
            break;
        case HHAlgorithmBtnTypeBubbleSort1: //冒泡排序优化
            [self bubbleSortWithArray1:self.sortArr];
            break;
        case HHAlgorithmBtnTypeBubbleSort2: //冒泡排序优化
            [self bubbleSortWithArray2:self.sortArr];
            break;
            
        case HHAlgorithmBtnTypeSelectSort: //选择排序
            [self selectSortWithArray:self.sortArr];
            break;
        case HHAlgorithmBtnTypeInserSort://插入排序
            [self inserSortWithArray:self.sortArr];
            break;
            
        case HHAlgorithmBtnTypeFastSort://快速排序
            [self fastSortWithArray:self.sortArr];
            break;
        case HHAlgorithmBtnTypeShellSort://希尔排序
            [self shellSortWithArray:self.sortArr];
            break;
        case HHAlgorithmBtnTypeMergingSort://归并排序
            [self mergingSortWithArray:self.sortArr];
            break;
            
        case HHAlgorithmBtnTypeRadixSort://基数排序
            [self radixSortWithArray:self.sortArr];
            break;
            
        default:
            break;
    }
    
   
        
}



/**
 冒泡排序实现思路:
 1.每一趟比较数组中相邻元素的大小
 2.如果i元素小于i-1元素，就调换两个元素的位置
 3.重复n-1趟的比较
 
 

 */

//随机生成
//求随机数 从[min, max] 里 选择 (count)个数
- (NSArray *)randomSelectCount:(NSInteger)count min:(NSInteger)min max:(NSInteger)max {
    
    NSMutableSet *numbersSet = [NSMutableSet set];
    while (numbersSet.count < count) {
        long x = arc4random() % (max - min + 1) + min;
        [numbersSet addObject:@(x)];
    }
    
    NSMutableArray *numbers = [NSMutableArray array];
    for (NSNumber *num in numbersSet) {
        [numbers addObject:num];
    }
//     按从小到大的顺序排列
//    [numbers sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//       return [obj1 integerValue] > [obj2 integerValue];
//    }];
    return numbers;
    
}



- (void)bubbleSortWithArray:(NSMutableArray *)array{

       //1.循环控制比较次数
    
    TICK;
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

    TOCK;
 
    NSString * s =  [self.sortArr componentsJoinedByString:@","];

    self.sortAfterLabel.text = [NSString stringWithFormat:@"冒泡后：%@", s];
    
}

//冒泡优化2
//如果序列尾部已经局部有序，可以记录最后1次交换的位置，减少比较次数
- (void)bubbleSortWithArray2:(NSMutableArray *)array{

   //1.循环控制比较次数
    
    TICK;
    for (NSInteger end = array.count - 1; end >0 ; end-- ) {
        
        //sortEndIndex的初始值在数组完全有序的时候有用
        int sortEndIndex = 0;

        //2.两两比较
        for (int begin = 1; begin <= end; begin++) {
            
            
            //3.交换位置
            if ([array[begin] intValue]  < [array[begin -1] intValue]) { //降序排序
                
                int temp = [array[begin] intValue];
                
                array[begin]  = array[begin - 1];
                
                array[begin - 1]  =  [NSNumber numberWithInt:temp];
                
                sortEndIndex  = begin;
            }
        }
        end = sortEndIndex;
    }
    
    
    TOCK;
    
    NSString * s =  [self.sortArr componentsJoinedByString:@","];
    
    self.sortAfterLabel.text = [NSString stringWithFormat:@"冒泡后：%@", s];

}

//冒泡优化1
- (void)bubbleSortWithArray1:(NSMutableArray *)array{

       //1.循环控制比较次数
    
    TICK;
    for (int i = 0; i < array.count; i++) {
        //2.两两比较
        BOOL sorted = true;
        for (int j = 0; j < array.count - 1- i; j++) {
            //3.交换位置
            if ([array[j] intValue]  < [array[j +1] intValue]) { //降序排序
                //if ([array[j + 1] intValue]  < [array[j ] intValue]) { //升序排序
                
                int temp = [array[j] intValue];
                
                array[j]  = array[j + 1];
                
                array[j+ 1]  =  [NSNumber numberWithInt:temp];
                
                sorted = false;
            }
        }
        if (sorted)break;
        
    }

    TOCK;
    
    NSString * s =  [self.sortArr componentsJoinedByString:@","];

    self.sortAfterLabel.text = [NSString stringWithFormat:@"冒泡后：%@", s];
    
    
    
    
    
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
        
        
        NSLog(@"strstr:------%zd",[str integerValue]);
        
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
        NSArray *randomArr =  [self randomSelectCount:50 min:10 max:500];
        _sortArr = [NSMutableArray arrayWithArray:randomArr];
    }
    return _sortArr;
    
}


@end
