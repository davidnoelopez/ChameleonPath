//
//  Puntuacion.m
//  pruebaChameleonPath
//
//  Created by Diego de los Reyes on 13/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//


#import "Puntuacion.h"
#import "HelloWorldLayer.h"


@implementation Puntuacion


+(CCScene *) scene{
	CCScene *scene = [CCScene node];
	
	Puntuacion *layer = [Puntuacion node];
	
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
		
		
        CCSprite *highscores = [CCSprite spriteWithFile:@"HighscoresButton.png"];
        highscores.position =  ccp(winSize.width/2 , 270 );
        
        // add the label as a child to this Layer
        [self addChild: highscores];
        
        CCLabelTTF *atras = [CCLabelTTF labelWithString:@"Back" fontName:@"verdana" fontSize:25];
        CCMenuItemLabel *atras1 = [CCMenuItemLabel itemWithLabel:atras target:self selector:@selector(back)];
        
        CCMenu *menu = [CCMenu menuWithItems:atras1, nil];
        menu.position = ccp(30, winSize.height-20);
        [menu alignItemsVerticallyWithPadding:1];
        
        //Add the menu as a child to this layer
        [self addChild:menu];
        
	}
	return self;
}

- (void)back {
	CCScene *MainMenuScene = [HelloWorldLayer scene];
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:MainMenuScene]];
}


@end
