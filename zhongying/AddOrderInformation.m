//
//  AddOrderInformation.m
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddOrderInformation.h"
#import "ProductAttributeParameter.h"
#import "ProductOptionParameter.h"

#define MUTIPLY_CONNECTOR               @" "
#define RESULT_CONNECTOR                @"|"
#define SELECTION_DESCRIPTION_FORMAT    @"%@:%@[%.0f]"

@implementation AddOrderInformation

@synthesize productId, productName, productPrice, allProductAttributes, allAttributeDescription, singleSelectAttributes, totalAttributePrice, limitRestrict, count, buyId, detailUrl;


- (void)setAttributesBySelection:(NSArray *)selection withProduct:(NSArray *)attributes
{
    
    NSMutableString *tempSingle = [NSMutableString string];
    NSMutableString *tempAll = [NSMutableString string];
    NSMutableString *tempDescription = [NSMutableString string];
    self.totalAttributePrice = 0;
    
    for(int i = 0; i < [selection count]; i ++){
        NSArray *array = [selection objectAtIndex:i];
        ProductAttributeParameter *productAttribute = [attributes objectAtIndex:i];
        if([tempDescription length] > 0){
            [tempDescription appendString:MUTIPLY_CONNECTOR];
        }
        [tempDescription appendString:productAttribute.attributeName];
        [tempDescription appendString:@":"];
        
        if(productAttribute.attributeType == attributeSingle){
            if([tempSingle length] > 0){
                [tempSingle appendString:RESULT_CONNECTOR];
            }
            int index = [[array objectAtIndex:0] intValue];
            ProductOptionParameter *optionAttribute = [productAttribute.options objectAtIndex:index];
            [tempSingle appendString:optionAttribute.optionId];
        }
        
        NSMutableString *selectionString = [NSMutableString string];
        
        for(NSNumber *s in array){
            int index = [s intValue];
            if([tempAll length] > 0){
                [tempAll appendString:MUTIPLY_CONNECTOR];
            }
            ProductOptionParameter *optionAttribute = [productAttribute.options objectAtIndex:index];
            [tempAll appendString:[NSString stringWithFormat:SELECTION_DESCRIPTION_FORMAT,productAttribute.attributeName,optionAttribute.optionName,optionAttribute.optionPrice]];
            if([selectionString length] > 0){
                [selectionString appendString:MUTIPLY_CONNECTOR];
            }
            [selectionString appendString:optionAttribute.optionName];
            self.totalAttributePrice += optionAttribute.optionPrice;
        }
        [tempDescription appendString:selectionString];
    }
    
    if([tempSingle length] > 0){
        [tempSingle appendString:RESULT_CONNECTOR];
    }
    
    self.singleSelectAttributes = tempSingle;
    self.allProductAttributes = tempAll;
    self.allAttributeDescription = tempDescription;
}

@end
