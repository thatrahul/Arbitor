//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Rahul Phadnis on 12/17/14.
//  Copyright (c) 2014 Rahul Phadnis. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController()
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlineLabel;

@end

@implementation TextStatsViewController

-(void) setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    _textToAnalyze =  textToAnalyze;
    if (self.view.window) {
        [self updateUI];
    }
}

//-(void) viewDidLoad {
//    _textToAnalyze = [[NSAttributedString alloc] initWithString:@"testing"
//                                                     attributes:@{NSForegroundColorAttributeName :[UIColor redColor]}];
//}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString*) charactersWithAttribute: (NSString *) attributeName {
    NSMutableAttributedString* characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while (index < [self.textToAnalyze length]){
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            index = index + range.length;
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
        } else {
            index++;
        }
    }
    return characters;
}

-(void) updateUI {
    int colorCount =  [[self charactersWithAttribute:NSForegroundColorAttributeName] length];
    int outlineCount =  [[self charactersWithAttribute:NSStrokeWidthAttributeName] length];
    self.colorLabel.text = [NSString stringWithFormat:@"%d colorful characters" , colorCount];
    self.outlineLabel.text = [NSString stringWithFormat:@"%d outlined characters" , outlineCount];
}

@end
