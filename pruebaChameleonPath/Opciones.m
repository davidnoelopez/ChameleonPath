//
//  Opciones.m
//  pruebaChameleonPath
//
//  Created by Diego de los Reyes on 13/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Opciones.h"
#import "SimpleAudioEngine.h"
#import "HelloWorldLayer.h"


CCMenuItem *_soundOn;

@implementation Opciones

+(CCScene *) scene{
	CCScene *scene = [CCScene node];
	
	Opciones *layer = [Opciones node];
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite *background = [CCSprite spriteWithFile:@"BlurryBackground.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background z:-2];
		
		
        CCSprite *opciones = [CCSprite spriteWithFile:@"OptionsButton.png"];
        opciones.position =  ccp(winSize.width/2 , 270 );
        [self addChild: opciones];
        
        // Check the sound system
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSObject * object = [defaults objectForKey:@"sound"];
        if(object == nil){
            NSNumber *soundValue = [[NSNumber alloc ] initWithInt:1];
            [defaults setObject:soundValue forKey:@"sound"];
        }
        int soundDefault = [defaults integerForKey:@"sound"];
        if (soundDefault == 1) {
            [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
            [[SimpleAudioEngine sharedEngine] setEffectsVolume:0.4f];
        }
        else {
            [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
        }

        
        _soundOn = [[CCMenuItemImage  itemWithNormalImage:@"soundOn.png"
                                                        selectedImage:@"soundOnSelected.png" target:nil selector:nil] retain];
        CCMenuItem *_soundOff = [[CCMenuItemImage itemWithNormalImage:@"soundOff.png"
                                                        selectedImage:@"soundOffSelected.png" target:nil selector:nil] retain];
        CCMenuItemToggle *toggleItem;
        if(soundDefault == 1)
            toggleItem = [CCMenuItemToggle itemWithTarget:self selector:@selector(cambiarSonido:) items:_soundOn, _soundOff, nil];
        else
            toggleItem = [CCMenuItemToggle itemWithTarget:self selector:@selector(cambiarSonido:) items:_soundOff,_soundOn, nil];
        
        
        CCMenuItem *resetHighscores = [CCMenuItemImage itemWithNormalImage:@"resetHighscores.png" selectedImage:@"resetHighscoresSelected.png" target:self selector:@selector(borrarPuntuacion:)];

        
        CCMenu *menu = [CCMenu menuWithItems:toggleItem, resetHighscores, nil];
        menu.position = ccp(winSize.width * 0.5f, winSize.height * 0.5f);
        [menu alignItemsVerticallyWithPadding:1];
        
        //Add the menu as a child to this layer
        [self addChild:menu];
        
        CCLabelTTF *atras = [CCLabelTTF labelWithString:@"Back" fontName:@"verdana" fontSize:25];
        CCMenuItemLabel *atras1 = [CCMenuItemLabel itemWithLabel:atras target:self selector:@selector(back)];
        
        CCMenu *menu2 = [CCMenu menuWithItems:atras1, nil];
        menu2.position = ccp(30, winSize.height-20);
        [menu2 alignItemsVerticallyWithPadding:1];
        
        //Add the menu as a child to this layer
        [self addChild:menu2];

        
	}
	return self;
}

- (void)cambiarSonido:(id)sender {
    CCMenuItemToggle *toggleItem = (CCMenuItemToggle *)sender;
    if (toggleItem.selectedItem == _soundOn) {
        NSLog(@"Sound Enabled");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"backgroundMusic.mp3"];
        [defaults setInteger:1 forKey:@"sound"];
        [defaults synchronize];
    } else {
        NSLog(@"Sound Disabled");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:0 forKey:@"sound"];
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
        [defaults synchronize];
    }
}


- (void)back {
	CCScene *MainMenuScene = [HelloWorldLayer scene];
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:MainMenuScene]];
}

@end
