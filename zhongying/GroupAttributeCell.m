//
//  GroupAttributeCell.m
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GroupAttributeCell.h"
#import "ProductAttributeParameter.h"
#import "ProductOptionParameter.h"
#import "CommonConsts.h"
#import "CommonEnum.h"

#define ATTRIBUTE_NAME_LABEL_START_X    10
#define ATTRIBUTE_NAME_LABEL_START_Y    0
#define ATTRIBUTE_NAME_LABEL_WIDTH      70
#define ATTRIBUTE_NAME_LABEL_HEIGHT     20
#define OPTION_START_X                  80
#define OPTION_START_Y                  0
#define OPTION_WIDTH                    45
#define OPTION_HEIGHT                   20
#define OPTION_X_DISTANT                12
#define OPTION_Y_DISTANT                10
#define ATTRIBUTE_TOP_MARGIN            6
#define ATTRIBUTE_BOTTOM_MARGIN         6

#define ATTRIBUTE_FONT                  [UIFont systemFontOfSize:12]
#define OPTION_FONT                     [UIFont systemFontOfSize:12]

#define MUTIPLY_CONNECTOR               @" "
#define RESULT_CONNECTOR                @"|"
#define SELECTION_DESCRIPTION_FORMAT    @"%@:%@[%.0f]"

#define SELECT_ATTRIBUTE_IMAGE          @"attribute_checked"
#define UNSELECT_ATTRIBUTE_IMAGE        @"attribute_unchecked"

@interface GroupAttributeCell()
- (void)selectChange:(id)sender;
@end

@implementation GroupAttributeCell

@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Private Methods
- (void)selectChange:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int attributeIndex = button.tag >> 4;
    int optionIndex = button.tag & 0x0f;
    
    ProductAttributeParameter *attri = [productAttributes objectAtIndex:attributeIndex];
    if(attri.attributeType == attributeSingle){
        NSMutableArray *currentSelection = [selections objectAtIndex:attributeIndex];
        NSNumber *numberOption = [NSNumber numberWithInt:optionIndex];
        if([currentSelection containsObject:numberOption]){
            [currentSelection removeAllObjects];
            [button setSelected:NO];
        }
        else{
            if([currentSelection count] > 0){
                int current = [[currentSelection objectAtIndex:0] intValue];
                UIButton *oldSelectButton = [[optionButtons objectAtIndex:attributeIndex] objectAtIndex:current];
                [oldSelectButton setSelected:NO];
            }
            [currentSelection removeAllObjects];
            [currentSelection addObject:numberOption];
            [button setSelected:YES];
        }
    }
    else{
        NSMutableArray *currentSelection = [selections objectAtIndex:attributeIndex];
        NSNumber *numberOption = [NSNumber numberWithInt:optionIndex];
        if([currentSelection containsObject:numberOption]){
            [currentSelection removeObject:numberOption];
            [button setSelected:NO];
        }
        else{
            [currentSelection addObject:numberOption];
            [button setSelected:YES];
        }
    }
    
    if(self.delegate != nil){
        [self.delegate attributeCellSelectionChange:self];
    }
}

#pragma mark - Public Methods

- (void)setAttributes:(NSArray *)attributes
{
    productAttributes = attributes;
    
    UIImage *selectImage = [UIImage imageNamed:SELECT_ATTRIBUTE_IMAGE];
    UIImage *unselectImage = [UIImage imageNamed:UNSELECT_ATTRIBUTE_IMAGE];
    
    for (NSArray *bs in optionButtons) {
        for (UIButton *button in bs) {
            [button removeFromSuperview];
        }
    }
    for (UILabel *label in optionLabels) {
        [label removeFromSuperview];
    }
    
    NSMutableArray *temp = [NSMutableArray array];
    NSMutableArray *tempButtons = [NSMutableArray array];
    NSMutableArray *tempLabels = [NSMutableArray array];
    
    float totalY = ATTRIBUTE_TOP_MARGIN;
    int optionsPerRow = (self.contentView.bounds.size.width - OPTION_START_X - OPTION_WIDTH) / (OPTION_WIDTH + OPTION_X_DISTANT) + 1;
    for(int i = 0; i < [attributes count]; i ++){
        [temp addObject:[NSMutableArray array]];
        ProductAttributeParameter *attribute = [attributes objectAtIndex:i];
        
        UILabel *labelAttribute = [[UILabel alloc] initWithFrame:CGRectMake(ATTRIBUTE_NAME_LABEL_START_X, totalY, ATTRIBUTE_NAME_LABEL_WIDTH, ATTRIBUTE_NAME_LABEL_HEIGHT)];
        labelAttribute.backgroundColor = [UIColor clearColor];
        labelAttribute.font = ATTRIBUTE_FONT;
        labelAttribute.text = attribute.attributeName;
        labelAttribute.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:labelAttribute];
        [tempLabels addObject:labelAttribute];
        [tempButtons addObject:[NSMutableArray array]];
        
        for(int j = 0; j < [attribute.options count]; j ++){
            ProductOptionParameter *option = [attribute.options objectAtIndex:j];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:selectImage forState:UIControlStateSelected];
            [button setBackgroundImage:unselectImage forState:UIControlStateNormal];
            
            int row = j / optionsPerRow;
            int column = j % optionsPerRow;
            
            button.frame = CGRectMake(OPTION_START_X + column * (OPTION_WIDTH + OPTION_X_DISTANT),  row * (OPTION_HEIGHT + OPTION_Y_DISTANT) + totalY, OPTION_WIDTH, OPTION_HEIGHT);
            
            button.titleLabel.font = OPTION_FONT;
            [button setTitle:option.optionName forState:UIControlStateNormal];
            [button setTitle:option.optionName forState:UIControlStateSelected];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            button.tag = (i << 4) + j;
            [[tempButtons objectAtIndex:i] addObject:button];
            
            [button addTarget:self action:@selector(selectChange:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
        }
        
        int totalRow = ([attribute.options count] + optionsPerRow - 1) / optionsPerRow;
        
        totalY += MAX(1, totalRow) * (OPTION_HEIGHT + OPTION_Y_DISTANT);
    }
    
    selections = temp;
    optionButtons = tempButtons;
    optionLabels = tempLabels;
}

- (NSArray *)getSelections
{
    return selections;
}

/*
- (NSString *)getSelections
{
    NSMutableString *result = [NSMutableString string];
    
    for(int i = 0; i < [selections count]; i ++){
         NSArray *optionsArray = [selections objectAtIndex:i];
        for (NSNumber *n in optionsArray) {
            ProductAttributeParameter *attr = [productAttributes objectAtIndex:i];
            ProductOptionParameter *option = [attr.options objectAtIndex:[n intValue]];
            if(![result isEqualToString:@""]){
                [result appendString:MUTIPLY_CONNECTOR];
            }
            [result appendString:option.optionId];
        }
        [result appendString:RESULT_CONNECTOR];
    }
    return result;
}

- (NSString *)getSelectionsAttributeDescription
{
    NSMutableString *result = [NSMutableString string];
    
    for(int i = 0; i < [selections count]; i ++){
        NSArray *optionsArray = [selections objectAtIndex:i];
        for (NSNumber *n in optionsArray) {
            ProductAttributeParameter *attr = [productAttributes objectAtIndex:i];
            ProductOptionParameter *option = [attr.options objectAtIndex:[n intValue]];
            if(![result isEqualToString:@""]){
                [result appendString:MUTIPLY_CONNECTOR];
            }
            [result appendString:[NSString stringWithFormat:SELECTION_DESCRIPTION_FORMAT,attr.attributeName,option.optionName,option.optionPrice]];
        }
        [result appendString:RESULT_CONNECTOR];
    }
    return result;
}

- (NSString *)getInvalidSelectionString
{
    for(int i = 0; i < [selections count]; i++){
        NSArray *s = [selections objectAtIndex:i];
        if([s count] == 0){
            return ((ProductAttributeParameter *)[productAttributes objectAtIndex:i]).attributeName;
        }
    }
    return nil;
}
 */

+ (float)getCellHeightOfAttributes:(NSArray *)attributes withContentWidth:(float)width
{
    float result = ATTRIBUTE_TOP_MARGIN + ATTRIBUTE_BOTTOM_MARGIN + OPTION_HEIGHT;
    int optionsPerRow = (width - OPTION_START_X - OPTION_WIDTH) / (OPTION_WIDTH + OPTION_X_DISTANT) + 1;
    
    int row = 0;
    for (ProductAttributeParameter *attribute in attributes) {
        row += MAX(1, ([attribute.options count] + optionsPerRow - 1) / optionsPerRow);
    }
    result += (row - 1) * (OPTION_HEIGHT + OPTION_Y_DISTANT);
    return result;
}

@end
