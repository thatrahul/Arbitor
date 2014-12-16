//
//  ViewController.m
//  Attributor
//
//  Created by Rahul Phadnis on 12/15/14.
//  Copyright (c) 2014 Rahul Phadnis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //do something with the outlineButton
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:[self.outlineButton currentTitle]] ;
    
    [title setAttributes:@{NSStrokeWidthAttributeName:@3, NSStrokeColorAttributeName:self.outlineButton.tintColor} range:NSMakeRange(0, [title length])];
    
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontsSizeChange:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeColorOfSelectedTextToBackgroundColorofSelectedButton:(UIButton *)sender {
    [[self.body textStorage] addAttribute:NSForegroundColorAttributeName value:[sender backgroundColor] range:[self.body selectedRange]];
}
- (IBAction)outlineSelectedText {
    [[self.body textStorage] addAttributes:@{NSStrokeWidthAttributeName:@-3, NSStrokeColorAttributeName: [UIColor blackColor]} range: [self.body selectedRange]];
}
- (IBAction)unoutlineSelectedText {
    [[self.body textStorage] removeAttribute:NSStrokeWidthAttributeName range:[self.body selectedRange]];
}

-(void) preferredFontsSizeChange: (NSNotification*) notification {
    [self usePreferredFonts];

}

-(void) usePreferredFonts {
    [self.body setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [self.body setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
}

@end
