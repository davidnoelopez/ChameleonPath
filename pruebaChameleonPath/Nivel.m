//
//  Nivel.m
//  pruebaChameleonPath
//
//  Created by Dave on 11/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
//

#import "Nivel.h"
#import "HelloWorldLayer.h"
#import "Pared.h"
#import "FinJuego.h"

@implementation Nivel

+(CCScene *) scene{
    CCScene *scene = [CCScene node];
    
    Nivel *layer = [Nivel node];
    
    [scene addChild: layer];
    
    return scene;
}

+(CCScene *) sceneWithMatrix:(int [][16])matrix{
    CCScene *scene = [CCScene node];
    
    Nivel *layer = [[Nivel alloc] initWithMatrix:matrix];
    
    //[[self alloc] initWithMatrix:matrix];
    
    [scene addChild: layer];
    
    return scene;
    
}

-(id) initWithMatrix:(int [][16])matrix
{
	if((self=[super init])) {
        self.isTouchEnabled = YES;
        
        //Dirección actual de los enemigos
        direccion1 = 1;
        direccion2 = 1;
        direccion3 = 1;
        direccion4 = 1;
        
        tengoLlave = FALSE;

        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        //Empieza el timer
        timer = 0;
        
        timerLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Arial" fontSize:24];
        timerLabel.position = CGPointMake(15, winSize.height-12);
        [self addChild:timerLabel z:2];
        
        //Actualiza el timer, sumandole uno
        [self schedule:@selector(update:)];

        
        //Crea el fondo, y lo agrega
        
        CCSprite *background = [CCSprite spriteWithFile:@"arena.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background z:-2];
        
        _tiles = [[NSMutableArray alloc] init];
        
        //crea paredes que se van a usar en el nivel
        Pared *p1 = [[Pared alloc] init];
        [p1 setParedSprite:[[NSString alloc] initWithString:@"tile.png"]];
        
        [p1 setTipo:1];
        [_tiles addObject:p1];
        
        //Revisa el tamaño de la pantalla
        if (winSize.width > 480) {
            offset = 40;
        }
        else {
            offset = 0;
        }
        
        /*
         Este ciclo, en base a la matriz, dibuja los objetos.
         1 - Paredes
         9 - Camaleon
         8 - Llave
         7 - Estrella
         3,4 - Mosca de Izquierda a Derecha
         5,6 - Mosca de Arriba a abajo
         11 - Puerta
         */
        for (int x = 0; x < 24; x++) {
            for (int y = 0; y < 16; y++) {
                mat[x][y] = matrix[x][y];
                int selectedTile = 0;
                Pared *auxPared = [_tiles objectAtIndex:selectedTile];
                
                CCSprite *tile = [[CCSprite alloc] initWithFile:[auxPared paredSprite]];
                if (matrix[x][y] == 1) {
                    tile.position = ccp((x*20+tile.contentSize.width/2) + offset,y*20+tile.contentSize.height/2);
                    //tile.position = ccp(0,0);
                    [self addChild:tile z:0];
                }
                else if (matrix[x][y] == 9){
                    xCam = x;
                    yCam = y;
                }
                else if (matrix[x][y] == 8){
                    llave = [CCSprite spriteWithFile:@"Key.png"];
                    llave.position = ccp(x*20+llave.contentSize.width/2 + offset,y*20+llave.contentSize.height/2);
                    [self addChild:llave z:1];
                }
                else if (matrix[x][y] == 7){
                    estrella = [CCSprite spriteWithFile:@"star.png"];
                    estrella.position = ccp(x*20+estrella.contentSize.width/2 + offset,y*20+estrella.contentSize.height/2);
                    [self addChild:estrella z:1];
                }
                else if (matrix[x][y] == 3){
                    xMos1 = x;
                    yMos1 = y;
                    mosca1 = [CCSprite spriteWithFile:@"fly.png"];
                    mosca1.position = ccp(x*20+mosca1.contentSize.width/2 + offset,y*20+mosca1.contentSize.height/2);
                    [self addChild:mosca1 z:1];
                    [self moveEnemyLados:mosca1 x:xMos1 y:yMos1 tipo:3 direccion:direccion1];

                }
                else if (matrix[x][y] == 4){
                    xMos2 = x;
                    yMos2 = y;
                    mosca2 = [CCSprite spriteWithFile:@"fly.png"];
                    mosca2.position = ccp(x*20+mosca2.contentSize.width/2 + offset,y*20+mosca2.contentSize.height/2);
                    [self addChild:mosca2 z:1];
                    [self moveEnemyLados:mosca2 x:xMos2 y:yMos2 tipo: 4 direccion:direccion2];
                    
                }
                else if (matrix[x][y] == 5){
                    xMos3 = x;
                    yMos3 = y;
                    mosca3 = [CCSprite spriteWithFile:@"fly.png"];
                    mosca3.position = ccp(x*20+mosca3.contentSize.width/2 + offset,y*20+mosca3.contentSize.height/2);
                    [self addChild:mosca3 z:1];
                    [self moveEnemyArribaAbajo:mosca3 x:xMos3 y:yMos3 tipo: 5 direccion:direccion3];
                    
                }
                else if (matrix[x][y] == 6){
                    xMos4 = x;
                    yMos4 = y;
                    mosca4 = [CCSprite spriteWithFile:@"fly.png"];
                    mosca4.position = ccp(x*20+mosca4.contentSize.width/2 + offset,y*20+mosca4.contentSize.height/2);
                    [self addChild:mosca4 z:1];
                    [self moveEnemyArribaAbajo:mosca4 x:xMos4 y:yMos4 tipo: 6 direccion:direccion4];
                    
                }
                else if (matrix[x][y] == 11){
                    puerta = [CCSprite spriteWithFile:@"door.png"];
                    puerta.position = ccp(x*20+puerta.contentSize.width/2 + offset,y*20+puerta.contentSize.height/2);
                    [self addChild:puerta z:1];
                    
                }
            }
        }
        camaleon = [CCSprite spriteWithFile:@"camaleon.png"];
        camaleon.position =  ccp(xCam*20+camaleon.contentSize.width/2 + offset,yCam*20+camaleon.contentSize.height/2);
        
        // agrega camaleon como child al layer
        [self addChild:camaleon z:2];
        
        CCSprite *flecha = [CCSprite spriteWithFile:@"flecha_der.png"];
        flecha.position =  ccp((winSize.width/3)*2 + flecha.contentSize.width/2,(winSize.height/3) + flecha.contentSize.height/2);
        flecha.opacity = 180;
        // agrega flecha derecha al layer
        [self addChild:flecha z:3];
        
        flecha = [CCSprite spriteWithFile:@"flecha_izq.png"];
        flecha.position =  ccp(0 + flecha.contentSize.width/2,(winSize.height/3) + flecha.contentSize.height/2);
        flecha.opacity = 180;
        // agrega flecha izquierda al layer
        [self addChild:flecha z:3];
        
        flecha = [CCSprite spriteWithFile:@"flecha_arr.png"];
        flecha.position =  ccp((winSize.width/3) + flecha.contentSize.width/2,(winSize.height/3)*2 + flecha.contentSize.height/2);
        flecha.opacity = 180;
        // agrega flecha arriba al layer
        [self addChild:flecha z:3];
        
        flecha = [CCSprite spriteWithFile:@"flecha_aba.png"];
        flecha.position =  ccp((winSize.width/3) + flecha.contentSize.width/2,flecha.contentSize.height/2);
        flecha.opacity = 180;
        // agrega flecha abajo al layer
        [self addChild:flecha z:3];
        
	}
	return self;
}

-(id) init
{
    if((self=[super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite *background = [CCSprite spriteWithFile:@"BlurryBackground.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background z:-2];
		
        CCSprite *opciones = [CCSprite spriteWithFile:@"OptionsButton.png"];
        opciones.position =  ccp(winSize.width/2 , 270 );
        [self addChild: opciones];
	}
	return self;

}

-(void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                              priority:0
                                                       swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	return YES;
}

-(void)setPlayerPosition:(CGPoint)position {
	camaleon.position = position;
}

-(void)setMoscaPosition:(CGPoint)position {
	//mosca.position = position;
}

/*
 Éste es el metodo para que los enemigos de tipo 3 o 4 se muevan hacia los lados.
 Recibe:
 xMos - posición en x de la Mosca que lo llama
 yMos - posición en y de la Mosca que lo llama
 tipo - tipo de la mosca que lo llama (3 o 4)
 direccion - hacia que dirección se mueve actualmente

 */
-(void)moveEnemyLados:(CCSprite *) enemigo x: (int)xMos y:(int)yMos tipo:(int) t direccion:(int) d{
    CGPoint moscaPos = enemigo.position;
    
        //Si se puede mover, actualiza la matriz
        if (mat[xMos + d][yMos] == 0) {
            mat[xMos][yMos] = 0;
            moscaPos.x+= enemigo.contentSize.width*d;
            xMos += d;
            enemigo.position = moscaPos;
            
            mat[xMos][yMos] = t;
        }else if (mat[xMos+d][yMos] == 1){ // Si hay pared, se mueve en dirección contraria
            d = d * -1;
        }else if (mat[xMos+d][yMos] == 9){ // Si choca con el camaleón, se llama al método "perdiste"
            [self perdiste];
        }
    
    //Ejecuta la acción del movimiento con cierta velocidad, y los nuevos valores
    [enemigo runAction:[CCSequence actions:[CCMoveTo actionWithDuration:.2 position:ccp(moscaPos.x, moscaPos.y)],[CCCallBlock actionWithBlock:^{
        [self moveEnemyLados:enemigo x:xMos y:yMos tipo:t direccion:d];
    }], nil]];

}


/*
 Éste es el metodo para que los enemigos de tipo 5 o 6 se muevan hacia los lados.
 Recibe:
 xMos - posición en x de la Mosca que lo llama
 yMos - posición en y de la Mosca que lo llama
 tipo - tipo de la mosca que lo llama (5 o 6)
 direccion - hacia que dirección se mueve actualmente
 
 */
-(void)moveEnemyArribaAbajo:(CCSprite *) enemigo x: (int)xMos y:(int)yMos tipo:(int) t direccion:(int)d{
    CGPoint moscaPos = enemigo.position;
    
    
    if (mat[xMos][yMos + d] == 0) {
        mat[xMos][yMos] = 0;
        moscaPos.y+= enemigo.contentSize.width*d;
        yMos += d;
        enemigo.position = moscaPos;
        
        mat[xMos][yMos] = t;
    }else if (mat[xMos][yMos+d] == 1){ // Si hay pared, se mueve en dirección contraria
        d = d * -1;
    }else if (mat[xMos][yMos+d] == 9){// Si choca con el camaleón, se llama al método "perdiste"
        [self perdiste];
    }
    
     //Ejecuta la acción del movimiento con cierta velocidad, y los nuevos valores
    [enemigo runAction:[CCSequence actions:[CCMoveTo actionWithDuration:.2 position:ccp(moscaPos.x, moscaPos.y)],[CCCallBlock actionWithBlock:^{
        [self moveEnemyArribaAbajo:enemigo x:xMos y:yMos tipo:t direccion:d];
    }], nil]];
    
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    CGPoint touchLocation = [touch locationInView:touch.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    
    CGPoint playerPos = camaleon.position;
    //CGPoint diff = ccpSub(touchLocation, playerPos);
    int cambioX = 0, cambioY = 0;
    
    //Lógica de las Flechas para moverse
    
    if( (touchLocation.x > 0 && touchLocation.x < winSize.width/3 ) && (touchLocation.y > winSize.height/3 && touchLocation.y < (winSize.height/3)*2 ))
        cambioX = -1;
    
    else if( (touchLocation.x > (winSize.width/3)*2 && touchLocation.x < winSize.width ) && (touchLocation.y > winSize.height/3 && touchLocation.y < (winSize.height/3)*2 ))
        cambioX = +1;
    
    else if( (touchLocation.x > winSize.width/3 && touchLocation.x < (winSize.width/3)*2 ) && (touchLocation.y > (winSize.height/3)*2 && touchLocation.y < winSize.height ))
        cambioY = +1;
    
    else if( (touchLocation.x > winSize.width/3 && touchLocation.x < (winSize.width/3)*2 ) && (touchLocation.y > 0 && touchLocation.y < winSize.height/3 ))
        cambioY = -1;

    //Cambia las posiciones
    if (!((xCam == 0 && cambioX < 0) || (yCam == 0 && cambioY < 0)))
        if (mat[xCam+cambioX][yCam+cambioY] == 0 || mat[xCam+cambioX][yCam+cambioY] == 8 || mat[xCam+cambioX][yCam+cambioY] == 7 || mat[xCam+cambioX][yCam+cambioY] == 11 || mat[xCam+cambioX][yCam+cambioY] == 12) {
            mat[xCam][yCam] = 0;
            playerPos.x += camaleon.contentSize.width*cambioX;
            xCam += cambioX;
            playerPos.y += camaleon.contentSize.height*cambioY;
            yCam += cambioY;
            [self setPlayerPosition:playerPos];
            
            switch (mat[xCam][yCam]) {
                case 8:
                    tengoLlave = TRUE;
                    [self removeChild:llave cleanup:YES];
                    break;
                    
                case 7:
                    tengoEstrella =TRUE;
                    [self removeChild:estrella cleanup:YES];
                    break;
                case 11:
                case 12:
                    if (tengoLlave) {
                        [self ganaste];
                    }
                    break;
                default:
                    break;
            }
            mat[xCam][yCam] = 9;
        }
}

/*
 Los siguientes métodos llaman a la escena post-nivel llamada "FinJuego", con un parámetro 1 si se perdió,
 y un parámetro 2 si se ganó.
 */
- (void) perdiste
{
    CCScene *EndScene = [FinJuego sceneWithEnd:1 t:timer e:tengoEstrella];
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:EndScene]];
}

- (void) ganaste
{
    CCScene *EndScene = [FinJuego sceneWithEnd:0 t:timer e:tengoEstrella];
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:EndScene]];
}


/*
 Parte del timer, simplemente actualiza cada segundo el valor del timer
 y lo dibuja en pantalla.
 */

-(void)update:(ccTime)dt{
    
    tiempoTotal += dt;
    tiempoActual = (int)tiempoTotal;
    if (timer < tiempoActual)
    {
        timer = tiempoActual;
        [timerLabel setString:[NSString stringWithFormat:@"%i", timer]];
    }
    
}


@end