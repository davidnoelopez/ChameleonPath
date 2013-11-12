//
//  HelloWorldLayer.m
//  pruebaChameleonPath
//
//  Created by Diego de los Reyes on 13/10/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

// Otras clases
#import "Puntuacion.h"
#import "Opciones.h"
#import "SimpleAudioEngine.h"
#import "Nivel.h"

NSUserDefaults *defaults;

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		

        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite *background = [CCSprite spriteWithFile:@"Background.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background z:-2];		
		
		
        CCSprite *logo = [CCSprite spriteWithFile:@"Logo.png"];
        logo.position =  ccp(winSize.width/2 , 250 );
        
        // add the label as a child to this Layer
        [self addChild: logo];

        
        CCMenuItem *play = [CCMenuItemImage itemWithNormalImage:@"PlayButton.png" selectedImage:@"PlayButtonSelected.png" target:self selector:@selector(iniciarJuego)];
        CCMenuItem *highscores = [CCMenuItemImage itemWithNormalImage:@"HighscoresButton.png" selectedImage:@"HighscoresButtonSelected.png" target:self selector:@selector(verPuntuacion)];
        CCMenuItem *options = [CCMenuItemImage itemWithNormalImage:@"OptionsButton.png" selectedImage:@"OptionsButtonSelected.png" target:self selector:@selector(verOpciones)];

        CCMenu *menu = [CCMenu menuWithItems:play, highscores, options, nil];
        menu.position = ccp(winSize.width * 0.5f, winSize.height * 0.3f);
        [menu alignItemsVerticallyWithPadding:1];
        
        //Add the menu as a child to this layer
        [self addChild:menu];
        
        defaults = [NSUserDefaults standardUserDefaults];
        
        int soundDefault = [defaults integerForKey:@"sound"];
        if (soundDefault == 1 && [[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying] == NO) {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"backgroundMusic.mp3"];
            [[SimpleAudioEngine sharedEngine] setEffectsVolume:0.4f];
        }


	}
	return self;
}

- (void)iniciarJuego {
    int matrix[24][16] = {

        1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
        1,7,0,0,0,1,0,0,0,0,0,0,1,0,9,1,
        1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,1,
        1,1,1,0,0,1,0,0,1,1,0,3,1,0,0,1,
        1,0,0,0,0,1,0,0,1,0,0,0,1,0,0,1,
        1,0,0,0,0,1,0,0,1,0,0,0,0,0,0,1,
        1,0,0,1,1,1,0,0,1,1,0,0,0,0,0,1,
        1,0,0,0,0,1,0,0,1,0,0,0,1,0,0,1,
        1,0,0,0,0,1,0,0,1,0,0,0,1,0,0,1,
        1,1,1,0,0,1,0,0,1,1,1,1,1,1,1,1,
        1,0,0,0,0,1,0,0,0,0,1,0,0,0,11,12,
        1,0,0,0,0,1,0,0,0,0,1,0,0,0,12,12,
        1,0,0,1,1,1,1,1,0,0,1,0,0,1,1,1,
        1,0,0,1,0,0,0,0,0,0,1,0,0,0,0,1,
        1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,
        1,0,0,0,0,0,1,0,0,0,1,1,1,0,0,1,
        1,1,1,1,1,1,1,0,0,4,0,0,0,0,0,1,
        1,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,
        1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,
        1,0,0,0,0,0,1,0,0,1,0,0,1,0,0,1,
        1,0,0,0,0,0,1,0,0,1,1,1,1,1,1,1,
        1,8,0,1,0,0,0,0,0,0,5,0,0,0,0,1,
        1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,
        1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

    };
    
	CCScene *nivelScene = [Nivel sceneWithMatrix:matrix];
    
    //CCScene *nivelScene = [Nivel scene];

	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:nivelScene]];
}

- (void)verPuntuacion {
	CCScene *PuntuacionScene = [Puntuacion scene];
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:PuntuacionScene]];
}

- (void)verOpciones {
	CCScene *OpcionesScene = [Opciones scene];
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:OpcionesScene]];
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}



@end
