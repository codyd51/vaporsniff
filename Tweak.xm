
// TODO put in common.h
#define PRODUCT_NAME @"VaporSniff"
#define PRODUCT_ERROR_DOMAIN @"com.phillipt.vaporsniff"

#define NSLog(FORMAT, ...) NSLog(@"[%@: %s - %i] %@", PRODUCT_NAME, __FILE__, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__])

@interface PXFirmwareUpdater : NSObject {

}

+ (id)sharedInstance;
- (void)_updateFirmwareForDevice:(id)arg1;
- (void)beginUpdateAtFilePath:(id)arg1;
- (id)currentAppVersionInfoForModel:(id)arg1;
- (void)dfuProgressDidChangeFor:(long long)arg1 outOf:(long long)arg2 to:(long long)arg3 currentSpeedBytesPerSecond:(double)arg4 avgSpeedBytesPerSecond:(double)arg5;
- (void)dfuStateDidChangeTo:(long long)arg1;
- (void)dfuTargetSeen:(id)arg1;
- (void)updateFirmwareForDevice:(id)arg1;

@end

@interface PXPeripheralColorTheme : NSObject
@property(retain, nonatomic) NSMutableArray *states; // @synthesize states=_states;
@property(retain, nonatomic) NSString *title; // @synthesize title=_title;
@property(retain, nonatomic) NSArray *displayColor; // @synthesize displayColor=_displayColor;
- (id)init;
- (id)initWithDictionary:(id)arg1;
- (void *)toBytes:(unsigned long long *)arg1;
- (void)updateFromBytes:(char *)arg1;
@end

@interface PXPeripheralColorState : NSObject
@property(nonatomic) long long animation; // @synthesize animation=_animation;
@property(retain, nonatomic) NSArray *color1; // @synthesize color1=_color1;
@property(retain, nonatomic) NSArray *color2; // @synthesize color2=_color2;
@property(nonatomic) unsigned long long frequency; // @synthesize frequency=_frequency;
- (id)init;
@end

%hook PXPeripheralColorTheme
- (id)initWithDictionary:(id)arg1 {
	NSArray* a = (NSArray*)arg1[@"color_states"];
	NSLog(@"PXPeripheralColorTheme %@ initWithDictionary %@", ((NSObject*)a[0]).class, arg1);
	return %orig;
}
%end

@interface PXPeripheral : NSObject
-(void)setColorTheme:(id)theme;
@end

@interface PXDeviceControlViewController : UIViewController
@property (nonatomic, retain) PXPeripheral* peripheral;
@end

@interface PXHomeViewController : UIViewController
@end

#import "ColorPicker2/FCColorPickerViewController.h"

#import <stdint.h>

uint32_t colors[9][13] = {
	{
		0x330000,
		0x331900,
		0x333300,
		0x193300,
		0x003300,
		0x003319,
		0x003333,
		0x001933,
		0x000033,
		0x190033,
		0x330033,
		0x330019,
		0x000000,
	},
	{
		0x660000,
		0x663300,
		0x666600,
		0x336600,
		0x006600,
		0x006633,
		0x006666,
		0x003366,
		0x000066,
		0x330066,
		0x660066,
		0x660033,
		0x202020,
	},
	{
		0x990000,
		0x994C00,
		0x999900,
		0x4C9900,
		0x009900,
		0x00994C,
		0x009999,
		0x004C99,
		0x000099,
		0x4C0099,
		0x990099,
		0x99004C,
		0x404040,
	},
	{
		0xCC0000,
		0xCC6600,
		0xCCCC00,
		0x66CC00,
		0x00CC00,
		0x00CC66,
		0x00CCCC,
		0x0066CC,
		0x0000CC,
		0x6600CC,
		0xCC00CC,
		0xCC0066,
		0x606060,
	},
	{
		0xFF0000,
		0xFF8000,
		0xFFFF00,
		0x80FF00,
		0x00FF00,
		0x00FF80,
		0x00FFFF,
		0x0080FF,
		0x0000FF,
		0x7F00FF,
		0xFF00FF,
		0xFF007F,
		0x808080,
	},
	{
		0xFF3333,
		0xFF9933,
		0xFFFF33,
		0x99FF33,
		0x33FF33,
		0x33FF99,
		0x33FFFF,
		0x3399FF,
		0x3333FF,
		0x9933FF,
		0xFF33FF,
		0xFF3399,
		0xA0A0A0,
	},
	{
		0xFF6666,
		0xFFB266,
		0xFFFF66,
		0xB2FF66,
		0x66FF66,
		0x66FFB2,
		0x66FFFF,
		0x66B2FF,
		0x6666FF,
		0xB266FF,
		0xFF66FF,
		0xFF66B2,
		0xC0C0C0,
	},
	{
		0xFF9999,
		0xFFCC99,
		0xFFFF99,
		0xCCFF99,
		0x99FF99,
		0x99FFCC,
		0x99FFFF,
		0x99CCFF,
		0x9999FF,
		0xCC99FF,
		0xFF99FF,
		0xFF99CC,
		0xE0E0E0,
	},
	{
		0xFFCCCC,
		0xFFE5CC,
		0xFFFFCC,
		0xE5FFCC,
		0xCCFFCC,
		0xCCFFE5,
		0xCCFFFF,
		0xCCE5FF,
		0xCCCCFF,
		0xE5CCFF,
		0xFFCCFF,
		0xFFCCE5,
		0xFFFFFF,
	},
};

#define LEN(arr) ((int) (sizeof (arr) / sizeof (arr)[0]))
#define ROWS(arr) (LEN(arr)) //9
#define COLS(arr) (LEN(arr[0])) //13

@interface PTColorsViewController : UIViewController
@property (nonatomic, retain) PXPeripheral* peripheral;
@end

@implementation PTColorsViewController
 
-(void)viewWillAppear:(BOOL)animated {
	self.view.backgroundColor = [UIColor whiteColor];

	UILabel* l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
	l.text = @"Choose your PAX's LED color";
	l.center = CGPointMake(self.view.center.x, self.view.frame.size.height * 0.05);
	l.textColor = [UIColor blackColor];
	l.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:l];

	UILabel* l2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
	l2.text = @"by @phillipten";
	l2.center = CGPointMake(self.view.center.x, self.view.frame.size.height * 0.1);
	l2.textColor = [UIColor blackColor];
	l2.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:l2];

	[self layoutColorGrid];

	UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[closeButton setTitle:@"Close" forState:UIControlStateNormal];
	[closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

	CGSize screenSize = [[UIScreen mainScreen] bounds].size;
	closeButton.frame = CGRectMake(0, 0, 100, 100);
	closeButton.center = CGPointMake(screenSize.width / 2, screenSize.height * 0.95);
	[self.view addSubview:closeButton];
	NSLog(@"closeButton %@", closeButton);
}

-(void)layoutColorGrid {
	/*
	for (int j = 0; j < multiarray[k].length; j++)
    	multiarray[k][j]; // do something
    */
    int rows = 9;
    int cols = 13;

    int squareWidth = 30;
    int squareHeight = 27.5;
    CGPoint originOffset = CGPointMake(
    	25,
    	75
    );
    UIView* pallete = [[UIView alloc] initWithFrame:CGRectMake(
    	originOffset.x,
    	originOffset.y,
    	squareWidth * rows,
    	squareHeight * cols
    )];
    [self.view addSubview:pallete];

	//for every row
	//each row corresopnds to a slice of colors
	for (int y = 0; y < 13; y++) {
		//go through every color in this slice
		for (int x = 0; x < 9; x++) {
			uint32_t raw_color = colors[x][y];

			uint8_t r = (raw_color >> 0) & 0XFF;
			uint8_t g = (raw_color >> 8) & 0XFF;
			uint8_t b = (raw_color >> 16) & 0XFF;
			UIColor* c = [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1.0];

			CGPoint origin = CGPointMake(
				x * squareWidth,
				y * squareHeight
			);
			UIButton* colorButton = [UIButton buttonWithType:UIButtonTypePlain];
			colorButton.frame = CGRectMake(
				origin.x,
				origin.y,
				squareWidth,
				squareHeight
			);
			[colorButton setBackgroundColor:c];
			[pallete addSubview:colorButton];
			
			[colorButton addTarget:self action:@selector(colorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
			colorButton.layer.borderWidth = 1.0f;
			colorButton.layer.cornerRadius = 2.0f;
			colorButton.layer.borderColor = [UIColor blackColor].CGColor;
		}
	}
}

-(PXPeripheralColorTheme*)getThemeWithRed:(int)r green:(int)g blue:(int)b {
	NSDictionary* theme = [self colorSchemeFromRed:r green:g blue:b];
	PXPeripheralColorTheme* pxTheme = [[%c(PXPeripheralColorTheme) alloc] initWithDictionary:theme];
	NSLog(@"returning theme %@", pxTheme);
	return pxTheme;
}

-(void)colorButtonPressed:(UIButton*)sender {
	UIColor* c = sender.backgroundColor;
	CGFloat r, g, b, a;
	[c getRed:&r green:&g blue:&b alpha:&a];
	r *= 255;
	g *= 255;
	b *= 255;
	NSLog(@"setting PAX %@ to (%f, %f, %f)", self.peripheral, r, g, b);

	[self.peripheral setColorTheme:[self getThemeWithRed:r green:g blue:b]];
}

/*
[VaporSniff: Tweak.xm - 431] setColorTheme {
    "color_states" =     (
                {
            animation = 2;
            color1 =             (
                255,
                255,
                51
            );
            color2 =             (
                255,
                255,
                51
            );
            frequency = 11;
        }
    );
    "display_color" =     (
        255,
        255,
        51,
        255
    );
    title = "Phillip's Theme";
}
[VaporSniff: Tweak.xm - 43] PXPeripheralColorTheme initWithDictionary {
    "color_states" =     (
                {
            animation = 2;
            color1 =             (
                253,
                149,
                40
            );
            color2 =             (
                153,
                0,
                136
            );
            frequency = 11;
        }
    );
    "display_color" =     (
        252,
        218,
        102,
        255
    );
    title = Sunset;
@property(retain, nonatomic) NSMutableArray *states; // @synthesize states=_states;
@property(retain, nonatomic) NSString *title; // @synthesize title=_title;
@property(retain, nonatomic) NSArray *displayColor; // @synthesize displayColor=_displayColor;
@end
@interface PXPeripheralColorState : NSObject
@property(nonatomic) long long animation; // @synthesize animation=_animation;
@property(retain, nonatomic) NSArray *color1; // @synthesize color1=_color1;
@property(retain, nonatomic) NSArray *color2; // @synthesize color2=_color2;
@property(nonatomic) unsigned long long frequency; // @synthesize frequency=_frequency;
}
*/

-(NSDictionary*)colorSchemeFromRed:(int)r green:(int)g blue:(int)b {
	//PXPeripheralColorState* state = [[PXPeripheralColorState alloc] init];
	NSArray* displayColor = @[@(r), @(g), @(b)];
	NSArray* fullDisplayColor = @[@(r), @(g), @(b), @255];
	NSArray* states = @[
		@{
			@"animation": @2,
			@"color1": displayColor,
			@"color2": displayColor,
			@"frequency": @11,
		}
	];
	NSDictionary* theme = @{
		@"color_states": states,
		@"display_color": fullDisplayColor,
		@"title": @"Sunset",
	};
	//NSLog(@"setting theme %@", theme);
	return theme;
}

-(void)closeButtonPressed:(UIButton*)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

@end

%hook PXDeviceControlViewController
//%hook PXHomeViewController

-(void)viewDidAppear:(BOOL)animated {
	NSLog(@"viewDidAppear");

	UIButton* colorsButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[colorsButton setTitle:@"Colors" forState:UIControlStateNormal];
	[colorsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[colorsButton addTarget:self action:@selector(colorsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

	CGSize screenSize = [[UIScreen mainScreen] bounds].size;
	colorsButton.frame = CGRectMake(0, 0, 100, 100);
	colorsButton.center = CGPointMake(screenSize.width * 0.25, screenSize.height * 0.9);
	[self.view addSubview:colorsButton];
	NSLog(@"colorsButton %@", colorsButton);

	//PTColorsViewController* vc = [[PTColorsViewController alloc] init];
	//[self.navigationController pushViewController:vc animated:YES];
}

%new
-(void)colorsButtonPressed:(UIButton*)sender {
	NSLog(@"Colors pressed");
	PTColorsViewController* vc = [[PTColorsViewController alloc] init];
	vc.peripheral = self.peripheral;
	[self.navigationController pushViewController:vc animated:YES];
}

%end

%hook PXFirmwareUpdater

- (void)_updateFirmwareForDevice:(id)arg1 {
	NSLog(@"_updateFirmwareForDevice: %@", arg1);
	%orig;
}

- (void)beginUpdateAtFilePath:(id)arg1 {
	NSLog(@"beginUpdateAtFilePath: %@", arg1);
	%orig;
}

- (id)currentAppVersionInfoForModel:(id)arg1 {
	NSLog(@"currentAppVersionInfoForModel: %@", arg1);
	return %orig;
}

- (void)dfuProgressDidChangeFor:(long long)arg1 outOf:(long long)arg2 to:(long long)arg3 currentSpeedBytesPerSecond:(double)arg4 avgSpeedBytesPerSecond:(double)arg5 {
	NSLog(@"dfuProgressDidChangeFor: %lld outOf: %lld to: %lld currentSpeedBytesPerSecond: %f avgSpeedBytesPerSecond: %f", arg1, arg2, arg3, arg4, arg5);
	%orig;
}

- (void)dfuStateDidChangeTo:(long long)arg1 {
	%orig;
	NSLog(@"dfuStateDidChangeTo: %lld", arg1);
}

- (void)dfuTargetSeen:(id)arg1 {
	NSLog(@"dfuTargetSeen: %@", arg1);
	%orig;
}

- (void)updateFirmwareForDevice:(id)arg1 {
	NSLog(@"updateFirmwareForDevice: %@", arg1);
	%orig;
}

%end
