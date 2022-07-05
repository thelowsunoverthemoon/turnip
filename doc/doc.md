## Documentation
### Table of Contents
  * [How to Use](#how)
  * [Loading Objects](#struct)
    * [Sprites](#obj)
    * [Images](#obj)
  * [Creating Objects](#obj)
    * [Sprites](#obj)
    * [Images](#obj)
    * [Text](#obj)
    * [Audio](#obj)
    * [Interactions](#obj)
  * [Editting Objects](#struct)
    * [Sprites](#obj)
    * [Images](#obj)
    * [Text](#obj)
    * [Audio](#obj)
  * [Getting Key Input](#struct)
  * [Getting Mouse Input](#struct)
  * [Getting End of Animation](#struct)

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

### Creating Objects

<a name="rule"/>

### IMPORTANT RULES WHEN USING THIS ENGINE

1. **Use ```%TURNIP_MSG%``` AS LITTLE AS POSSIBLE**. There is no need to update every frame; the engine renders in the same state until another ```%TURNIP_MSG%```. It will become very slow if you do so. Look at the examples to see ideal usage.

2. **THERE ARE RESTRICTED CHARACTERS**. The following characters cannot be used in values : ```$```  ```;```  ```|```  ```&```  ```!``` ```<``` ```>``` `` ` `` ```#```. However ```!``` can be used by writing instead ```%TURNIP_EXCL%``` and ```&``` can be used with ```%TURNIP_AND%```.

3. **HAVE FUN**.


