## Documentation
### Table of Contents
  * [How to Use](#how)
  * [Window](#struct)
  * [Objects in turnip](#s)
  * [Loading Objects](#struct)
    * [Sprites](#obj)
    * [Images](#obj)
  * [Creating Objects](#obj)
    * [Sprites](#obj)
    * [Images](#obj)
    * [Shapes](#obj)
    * [Text](#obj)
    * [Audio](#obj)
  * [Adding Interactions](#obj)
  * [Editting Objects](#struct)
    * [Sprites](#obj)
    * [Images](#obj)
    * [Shapes](#obj)
    * [Text](#obj)
    * [Audio](#obj)
  * [Getting Key Input](#struct)
  * [Getting Mouse Input](#struct)
  * [Getting End of Animation](#struct)
  * [Important Rules](#rule)

<a name="how"/>

### How to Use

1. First, copy and paste the **header** [here](src/header.bat) at the very top of your batch file. Note that ```@ECHO OFF``` and ```SETLOCAL ENABLEDELAYEDEXPANSION``` are already used, and the code page is set to ```65001```. **Do not edit it**

2. Next, as with most programming languages, you will have to have a ```MAIN``` section. Create a ```MAIN``` label. In this label, we will have to initiate the engine. There is a macro for this called ```%TURNIP_INIT%```.

3. After this you can put whatever code you want to happen before your game starts.

4. Add all the objects and attributes you'd like in your game.

5. Add ```%TURNIP_START_GAME%``` to siginify you want your game to start.

6. Add a ```GAME``` label. This is where your game loop will be. You must begin with ```%TURNIP_GAME_LOOP%``` and end with ```%TURNIP_GAME_END%```.

7. Add a ```RETURN``` label. This is where your game will go after you tell it to end.

8. At the end of your batch file, copy and paste the **engine** [here](src/engine.bat) at the end. **Do not edit it**

9. **READ THE EXAMPLES** [here](src/engine.bat).

10. **READ THE RULES** [here](#rule).

In practice, this looks like:

```Batch
::                  TURNIP HEADER                   ::

:MAIN

%TURNIP_INIT%

::                 CODE BEFORE GAME                 ::

%TURNIP_START_GAME%

:RETURN

::                 CODE AFTER GAME                  ::

:GAME
%TURNIP_GAME_LOOP%

::                 GAME LOOP                        ::

%TURNIP_GAME_END%


::                 TURNIP ENGINE                    ::
```
### Window
The window is the canvas that you render on, and cannot be changed. If not called, the defaults are **bkg** : #FFFFFF, **w** : 500, **h** : 500, **x** : 0, **y** : 0, **framerate** : 10

```Batch
CALL :TURNIP_WINDOW bkg w h x y framerate
```

* **bkg** : background color in hex format
* **w** : width in px
* **h** : height in px
* **x** : x coordinate in px
* **y** : y coordinate in px
* **framerate** : the render framerate in milleseconds (1 frame every n ms), cannot be lower than 10

### Objects in turnip
Objects refer to anything you can see on the screen. In turnip, objects **CANNOT** be created dynamically. That is, you have a set number of objects before the game starts and cannot create anymore later. Only objects that you specify with (see ) are interactable. When the action is used, a signal will be sent to the batch file, which you can capture through the key and mouse macros (see ). Object attributes can then be editted with the ```%TURNIP_MSG%``` macro (see). There are 4 types of objects in turnip:

* **Sprites** : animated images that can be editted and interacted with, **MUST** be loaded first (see), and **MUST** be horizontally packed
* **Images** : still images that **CANNOT** be editted and interacted with, example usage would be backgrounds that never move nor change, **MUST** be loaded first (see)
* **Shapes** : solid color that can be editted and interacted with
* **Text** : text box that can be editted and interacted with, text is always centered vertically
* **Audio** : audio that can be editted

### Loading Objects
#### Sprites
```Batch
CALL :TURNIP_SPRITE id file frame
```

* **id** : variable to return sprite id to
* **file** : name of spritesheet
* **frame** : number of frames in spritesheet

#### Images
```Batch
CALL :TURNIP_IMG id file
```

* **id** : variable to return image id to
* **file** : name of image

### Creating Objects
#### Sprites

```Batch
CALL :TURNIP_ADD_SPR id spr x y order framerate w h finish 
```

* **id** : variable to return object id to
* **spr** : sprite id given from ```CALL :TURNIP_SPRITE```
* **x** : x coordinate in px
* **y** : y coordinate in px
* **order** : display order relative to other objects
* **framerate** : change sprite frame every n frames
* **w** : width in px
* **h** : height in px
* **finish** : if 1, signal batch file when animation ends (see ), 0 if not

#### Images

```Batch
CALL :TURNIP_ADD_IMG img x y order w h
```

* **img** : img id given from ```CALL :TURNIP_IMG```
* **x** : x coordinate in px
* **y** : y coordinate in px
* **order** : display order relative to other objects
* **w** : width in px
* **h** : height in px

####  Shapes

```Batch
CALL :TURNIP_ADD_SHAPE id x y order bkg w h round
```

* **id** : variable to return object id to
* **x** : x coordinate in px
* **y** : y coordinate in px
* **order** : display order relative to other objects
* **bkg** : background color in hex format
* **w** : width in px
* **h** : height in px
* **round** : border radius (roundness) in px

####  Text

```Batch
CALL :TURNIP_ADD_TEXT id x y order bkg w h round "text$size$color$align$font$padding"
```

* **id** : variable to return object id to
* **x** : x coordinate in px
* **y** : y coordinate in px
* **order** : display order relative to other objects
* **bkg** : background color in hex format
* **w** : width in px
* **h** : height in px
* **round** : border radius (roundness) in px
* **text** : text
* **size** : font size in px
* **color** : text color
* **align** : text alignment (see [here](https://www.w3schools.com/cssref/pr_text_text-align.ASP))
* **font** : font used (see [here](https://www.w3schools.com/cssref/pr_font_font-family.asp))
* **padding** : space around text in px

#### Audio

```Batch
CALL :TURNIP_ADD_MUSIC id audio start
```

* **id** : variable to return object id to
* **audio** : name of audio file
* **start** : 1 to immediatly start playing, 0 to not

### Adding Interactions

```Batch
CALL :TURNIP_ADD_ATTRIB obj attrib
```

* **obj** : the sprite/image/shape/text object id
* **attrib** : C to return click signal, H to return hover and unhover signal

<a name="rule"/>

### Important Rules

1. **Use ```%TURNIP_MSG%``` AS LITTLE AS POSSIBLE**. There is no need to update every frame; the engine renders in the same state until another ```%TURNIP_MSG%```. It will become very slow if you do so. Look at the examples to see ideal usage.

2. **THERE ARE RESTRICTED CHARACTERS**. The following characters cannot be used in values : ```$```  ```;```  ```|```  ```&```  ```!``` ```<``` ```>``` `` ` `` ```#```. However ```!``` can be used by writing instead ```%TURNIP_EXCL%``` and ```&``` can be used with ```%TURNIP_AND%```.

3. **HAVE FUN**.


