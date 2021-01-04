//
//  NSArray+IECExtension.m
//  IEnjoyCar
//
//  Created by admin on 2019/11/28.
//  Copyright © 2019 iEnjoyCar. All rights reserved.
//

#import "NSArray+IECExtension.h"
#import "NSObject+IECExtention.h"




@implementation NSArray (IECExtension)
- (NSString *)join:(NSString *)delimiter{
    if ( 0 == self.count )
       {
           return @"";
       }
       else if ( 1 == self.count )
       {
           return [[self objectAtIndex:0] asNSString];
       }
       else
       {
           NSMutableString * result = [NSMutableString string];

           for ( NSUInteger i = 0; i < self.count; ++i )
           {
               [result appendString:[[self objectAtIndex:i] asNSString]];

               if ( i + 1 < self.count )
               {
                   [result appendString:delimiter];
               }
           }

           return result;
       }
}
@end
