## Documentation
### Table of Contents
---
  * [How to Use](#how)
  * [Overview](#ov)
    * [In General](#ig)
    * [How it Works](#hw)
    * [Objects in turnip](#ot)
  * [Window](#wi)
  * [Loading Objects](#lo)
    * [Sprites](#los)
    * [Images](#loi)
  * [Creating Objects](#co)
    * [Sprites](#cos)
    * [Images](#coi)
    * [Shapes](#cosp)
    * [Text](#cot)
    * [Audio](#coa)
  * [Adding Interactions](#ai)
  * [Editting Objects](#eo)
    * [Audio](#eoa)
    * [Sound](#eos)
    * [Sprites/Shapes/Text](#eoe)
  * [Global Effects](#ge)
  * [Getting Input](#gi)
    * [Getting Key Input](#gk)
    * [Getting Mouse Input](#gm)
    * [Getting End of Animation](#ga)
  * [Important Rules](#rule)

<a name="how"/>

### How to Use
---
1. First, copy and paste the **header** [here](../src/header.bat) at the very top of your batch file. Note that ```@ECHO OFF``` and ```SETLOCAL ENABLEDELAYEDEXPANSION``` are already used, and the code page is set to ```65001```. **Do not edit it**

2. Next, as with most programming languages, you will have to have a ```MAIN``` section. Create a ```MAIN``` label. In this label, we will have to initiate the engine. There is a macro for this called ```%TURNIP_INIT%```.

3. After this you can put whatever code you want to happen before your game starts.

4. Add all the objects and attributes you'd like in your game.

5. Add ```%TURNIP_START_GAME%``` to siginify you want your game to start.

6. Add a ```GAME``` label. This is where your game loop will be. You must begin with ```%TURNIP_GAME_LOOP%``` and end with ```%TURNIP_GAME_END%```.

7. Add a ```RETURN``` label. This is where your game will go after you tell it to end.

8. At the end of your batch file, copy and paste the **engine** [here](../src/engine.bat) at the end. **Do not edit it**

9. **READ THE EXAMPLES** [here](../ex).

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

<a name="ov"/>

### Overview
---
<a name="ig"/>

#### In General

Inside ```MAIN```, you add the objects you would like with the ```ADD``` functions (see [here](#co)). Sprites and images, however, must be "loaded" first (see [here](#lo)). To add interactivity to shapes, text, and sprites, see [here](#ai). This is not a traditional renderer, where you must load all objects every frame. Only message what needs to be changed each frame; if nothing changes, there is no need to message anything. We message the renderer via the ```%TURNIP_MSG%```macro. To change multiple objects at once, simply seperate with ```@ ```. See examples for usage of this. To pause, stop, or unpause the rendering, see [here](#ge). Getting key/mouse input and end of animation is through macros as well (see [here](#gi)). The game goes to the ```RETURN``` label when finished.

<a name="hw"/>

#### How it Works

**turnip** works through MSHTA. MSHTA is an exe that executes HTA applications (think web page); therefore, you can combine CSS, HTML, and Javascript into one file. However, user Aacini from DOStips [here](https://www.dostips.com/forum/viewtopic.php?t=6581) found a way to combine Batch script and HTAs together. This is just a natural extension of those programs. By taking advantage of a web browser renderer, we can achieve real graphics, all while containing the logic inside a Batch file.

<a name="ot"/>

#### Objects in turnip

Objects refer to anything you can see on the screen and cannot be destroyed. In turnip, objects **CANNOT** be created dynamically. That is, you have a set number of objects before the game starts and cannot create anymore later. Only objects that you specify with (see [here](#ai)) are interactable. There is **ONE** exception to this rule, and that is to audio. As you can see below, the **audio** object is looping, and that cannot be changed. However, you can "dynamically" create a sound (non looping) in a game loop that cannot be editted. Thus, the **audio** object might be used for a overlaying soundtrack, while a sound can be used as a sound effect (see [here](#eos)). When the action is used, a signal will be sent to the batch file, which you can capture through the key and mouse macros (see [here](#gi)). Object attributes can then be editted with the ```%TURNIP_MSG%``` macro (see [here](#eo)). There are 4 types of objects in turnip:

* **Sprites** : animated images that can be editted and interacted with, **MUST** be loaded first (see [here](#lo)), and **MUST** be horizontally packed
* **Images** : still images that **CANNOT** be editted and interacted with, example usage would be backgrounds that never move nor change, **MUST** be loaded first (see [here](#lo))
* **Shapes** : solid color that can be editted and interacted with
* **Text** : text box that can be editted and interacted with, text is always centered vertically
* **Audio** : looping audio that can be editted

<a name="wi"/>

### Window
---
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

<a name="lo"/>

### Loading Objects
---

<a name="los"/>

#### Sprites
```Batch
CALL :TURNIP_SPRITE id file frame
```

* **id** : variable to return sprite id to
* **file** : name of spritesheet
* **frame** : number of frames in spritesheet
* 
<a name="loi"/>

#### Images
```Batch
CALL :TURNIP_IMG id file
```

* **id** : variable to return image id to
* **file** : name of image

<a name="co"/>

### Creating Objects
---

<a name="cos"/>

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
* **finish** : if 1, signal batch file when animation ends (see [here](#ga)), 0 if not

<a name="coi"/>

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

<a name="cosp"/>

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

<a name="cot"/>

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

<a name="coa"/>

#### Audio

```Batch
CALL :TURNIP_ADD_MUSIC id audio start
```

* **id** : variable to return object id to
* **audio** : name of audio file
* **start** : 1 to immediatly start playing, 0 to not

<a name="ai"/>

### Adding Interactions
---
```Batch
CALL :TURNIP_ADD_ATTRIB obj attrib
```

* **obj** : the sprite/image/shape/text object id
* **attrib** : C to return click signal, H to return hover and unhover signal

<a name="eo"/>

### Editting Objects
---

<a name="eoa"/>

#### Audio
```Batch
%TURNIP_MSG% ~;id;type
```

* **id** : audio id given from ```CALL :TURNIP_ADD_MUISC```
* **type** : 0 to play, 1 to pause, 2 to restart (start from begininning and play)

<a name="eos"/>

#### Sound

```Batch
%TURNIP_MSG% *;sound
```

* **sound** : name of sound file

<a name="eoe"/>

#### Sprites/Shapes/Text

```Batch
%TURNIP_MSG% id;params
```

* **id** : object id from ```CALL :TURNIP_ADD_SPR```, ```CALL :TURNIP_ADD_SHAPE```, ```CALL :TURNIP_ADD_TEXT```
* **params** : in the form type$value seperated by ```;```, all other values will remain the same until changed; ie x$5;y$2 will change x position to 5 and y position to 2

| Type  | Description | Applicable |
| ------------- | ------------- | ------------- | 
| ```x``` | x position in px | Sprites/Shapes/Text |
| ```y``` | y position in px | Sprites/Shapes/Text |
| ```w``` | width in px | Sprites/Shapes/Text |
| ```h``` | height in px | Sprites/Shapes/Text |
| ```t``` | transformation (see [here](https://developer.mozilla.org/en-US/docs/Web/CSS/transform), only those supported in IE 9) | Sprites/Shapes/Text |
| ```b``` | background colour in hex format OR rgb(r,g,b) | Shapes/Text |
| ```r``` | border radius (roundness) in px | Shapes/Text|
| ```s``` | change sprite; must specify all 6 values : id, w, h, framerate, finish, and either 1 to reset current frame to 0, or 0 to not (see [here](#cos)) | Sprites |
| ```f``` | text; must specify all 5 values : color, size, align, font, text (see [here](#cot)) | Text |

<a name="ge"/>

### Global Effects

---

```Batch
%TURNIP_MSG% global
```

* **global** : P to pause the game, U to unpause the game

```Batch
%TURNIP_GAME_STOP%
```
Use to end the game and close window

<a name="gi"/>

### Getting Input
---

<a name="gk"/>

#### Key Input

To get key input use the macros ```%TURNIP_GET_KEY%``` and ```%TURNIP_END_KEY%```. The value is returned in ```%%~nK```, and is the decimal key code of the key pressed. Most computers use ASCII encoding, so it can be looked up [here](https://www.asciitable.com/). For example, to test for the character ```a```:

```Batch
%TURNIP_GET_KEY%
    IF "%%~nK" == "97" (
        :: what happens after pressing 'a'? ::
    )
%TURNIP_END_KEY%
```

<a name="gm"/>

#### Mouse Input

To get key input use the macros ```%TURNIP_GET_MOUSE%``` and ```%TURNIP_END_MOUSE%```. The value is returned in ```%%~nM```, and is in the form "type id". **type** is one of H (hovered), C (clicked) or D (dehovered). **id** is the object id. For example, the test if object 2 is hovered and object 3 is clicked:

```Batch
%TURNIP_GET_MOUSE%
    IF "%%~nM" == "H 2" (
        :: what happens when hovered? ::
    ) else IF "%%~nM" == "C 3" (
       :: what happens when clicked? ::
    )
%TURNIP_END_MOUSE%
```

<a name="ga"/>


#### End of Animation

To get the end of animation for a sprite, the sprite must have **finish** set to 1. The value returned is in ```%%F``` annd is the object id. Please note that multiple ids can be returned at once, since multiple animations can end at the same time. Hence, in that case, this will loop through each id. For example, to test if object 4's animation ended: (though in this case since it's only one object, you can just forget the IF)

```Batch
%TURNIP_GET_ANIM%
    IF "%%F" == "4" (
        :: what happens when it ends? ::
    )
%TURNIP_END_ANIM%
```
<a name="rule"/>

### Important Rules
---
1. **Use ```%TURNIP_MSG%``` AS LITTLE AS POSSIBLE**. There is no need to update every frame; the engine renders in the same state until another ```%TURNIP_MSG%```. It will become very slow if you do so. Look at the examples to see ideal usage.

2. **THERE ARE RESTRICTED CHARACTERS**. The following characters cannot be used in values : ```$```  ```;```  ```|```  ```&```  ```!``` ```<``` ```>``` `` ` `` ```#``` ```?```. However ```!``` can be used by writing instead ```%TURNIP_EXCL%```, ```?``` can be used with ```%TURNIP_QUESTION%``` and ```&``` can be used with ```%TURNIP_AND%```.

3. **HAVE FUN**.


