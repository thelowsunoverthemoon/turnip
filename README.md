<p align="center">
  <img src="https://i.imgur.com/uDJ4fuE.png">
</p>
<p align="center">
  <b>Batch Game Engine with Real Graphics, Mouse/Keyboard Input, and Audio, without External Exes</b>
</p>

## Features

* Simple to use, simply copy & paste!
* Supports images, sprites, shapes, text
* Supports keyboard and mouse input, including hover, dehover, and click
* Supports audio and related functions
* No external exes, contained within a single batch file
* Ideal Uses : simple simulations, non input-driven games, GUI, ect

## Drawbacks

* Hard to debug
* Not beginner friendly
* Uses Batch

## Showcase

<img align="left" src="https://i.imgur.com/5H3WosM.gif">

```
textbox

simple platforming

mouse/key input

walk/idle animation
```
<br clear="left"/>

<img align="left" src="https://i.imgur.com/guQTzJ4.gif">

```
textbox

data visualization

mouse/key input
```
<br clear="left"/>

<img align="left" src="https://i.imgur.com/A4z6Ceg.gif">

```
particle system
```
<br clear="left"/>

## How to Use

1. First, copy and paste the **header** [here](src/header.bat) at the very top of your batch file. Note that ```@ECHO OFF``` and ```SETLOCAL ENABLEDELAYEDEXPANSION``` are already used, and the code page is set to ```65001```. Do not edit it.

2. Next, as with most programming languages, you will have to have a ```MAIN``` section. Create a ```MAIN``` label. In this label, we will have to initiate the **turnip** engine. There is a macro for this called ```%TURNIP_INIT%```.

3. After this you can put whatever code you want to happen before your game starts.

4. Add all the objects and attributes you'd like in your game according to the documentation [here](doc/doc).

5. Add ```%TURNIP_START_GAME%``` to siginify you want your game to start.

6. Add a ```GAME``` label. This is where your game loop will be. You must begin with ```%TURNIP_GAME_LOOP%``` and end with ```%TURNIP_GAME_END%```.

7. Add a ```RETURN``` label. This is where your game will go after you tell it to end.

8. At the end of your batch file, copy and paste the engine [here](src/engine.bat) at the end. This is the "engine". Do not edit it.

9. READ THE EXAMPLES [here](src/engine.bat). These will give you a good idea on how to use **turnip**.

In practice, this looks like:

```Batch
<!-- :: ---------- turnip header v1, thelowsunoverthemoon ---------- ::
@ECHO OFF&SETLOCAL ENABLEDELAYEDEXPANSION&SET "d[f]=%~1"&SET "d[a]=%*"&CALL :TURNIP_ENGINE&TITLE &GOTO :MAIN
HTML --><HTML><HEAD><HTA:APPLICATION SCROLL="no" BORDER="thin" CAPTION="no" SHOWINTASKBAR="no" SYSMENU="no" ID="Game">
<META HTTP-EQUIV="x-ua-compatible" CONTENT="IE=9"><STYLE TYPE="TEXT/Batch">

:MAIN

%TURNIP_INIT%

::                 CODE BEFORE GAME HERE                 ::

%TURNIP_START_GAME%

:RETURN

::                 CODE AFTER GAME HERE                  ::

:GAME
%TURNIP_GAME_LOOP%

::                 GAME LOOP CODE HERE                   ::

%TURNIP_GAME_END%

:: ---------- turnip engine v1, thelowsunoverthemoon ---------- ::
:TURNIP_ENGINE
SET "TURNIP_MSG=ECHO ^!frame^!@"&SET "TURNIP_START_GAME=(START /B "" "%~F0" DISP ^!turnip[window]^!;^!turnip[img][a]^!;^!turnip[spr][a]^!;^!turnip[mus][l]^!;^!turnip[att]^!;^!turnip[img][l]^!;^!turnip[spr][l]^!)&(START /B "" "%~F0" GAME)>output.txt&EXIT"
SET "TURNIP_GAME_LOOP=SET /A "nex[ke]=1", "nex[ho]=2", "nex[an]=3", "frame=1"&ECHO 0&(FOR /L %%@ in ()DO ("&SET "TURNIP_GAME_END=)) 3>mouse.txt"
SET "TURNIP_INIT=(CHCP 65001)>NUL&(IF not "%d[f]%" == "" (IF "%d[f]%" == "GAME" (GOTO :GAME) else ((ECHO ^!d[a]:DISP =^! | MSHTA.exe "%~F0")&GOTO :RETURN)))&(COPY NUL input.txt)>NUL&(DEL /F /Q "*.1" "*.-1" "*.2" "*.-2" "*.3" "*.-3" "output.txt" "mouse.txt") 2>NUL&SET /A "turnip[img]=turnip[spr]=turnip[a]=turnip[mus]=0""
SET "TURNIP_GET_KEY=FOR %%K in (*.^!nex[ke]^!)DO ("&SET "TURNIP_END_KEY=SET /A nex[ke]*=-1)"
SET "TURNIP_GET_MOUSE=(FOR %%M in (*.^!nex[ho]^!)DO ("&SET "TURNIP_END_MOUSE=SET /A nex[ho]*=-1))>&3"
SET "TURNIP_GET_ANIM=FOR %%A in (*.^!nex[an]^!)DO (FOR %%F in (%%~nA)DO ("&SET "TURNIP_END_ANIM=)&SET /A nex[an]*=-1)"
SET "TURNIP_EXCL=`"&SET "TURNIP_AND=#"&SET "TURNIP_SOUND=~"&SET "TURNIP_MUSIC=*"
GOTO :EOF
:TURNIP_WINDOW
SET "turnip[window]=%1;%2;%3;%4;%5"&EXIT /B
:TURNIP_IMG
SET "turnip[img][l]=%turnip[img][l]%%~2@"&SET /A "%~1=%turnip[img]%", "turnip[img]+=1"&EXIT /B
:TURNIP_SPRITE
SET "turnip[spr][l]=%turnip[spr][l]%%~2#%3@"&SET /A "%~1=%turnip[spr]%", "turnip[spr]+=1"&EXIT /B
:TURNIP_ADD_IMG
SET "turnip[img][a]=%turnip[img][a]%%1.%2.%3.%4.%5.%6@"&EXIT /B
:TURNIP_ADD_SPR
SET "%~1=%turnip[a]%"&SET "turnip[spr][a]=%turnip[spr][a]%%2.%3.%4.%5.%6.%7.%8.%9@"&SET /A "turnip[a]+=1"&EXIT /B
:TURNIP_ADD_TEXT
SET "%~1=%turnip[a]%"&SET "turnip[spr][a]=%turnip[spr][a]%$.%2.%3.%4.%5.%6.%7.%8.%~9@"&SET /A "turnip[a]+=1"&EXIT /B
:TURNIP_ADD_SHAPE
SET "%~1=%turnip[a]%"&SET "turnip[spr][a]=%turnip[spr][a]%$.%2.%3.%4.%5.%6.%7.%8@"&SET /A "turnip[a]+=1"&EXIT /B
:TURNIP_ADD_ATTRIB
SET "turnip[att]=%turnip[att]%%1.%2@"&EXIT /B
:TURNIP_ADD_MUSIC
SET "%~1=%turnip[mus]%"&SET "turnip[mus][l]=%turnip[mus][l]%%~2#%3@"&SET /A "turnip[mus]+=1"&EXIT /B
</STYLE><STYLE TYPE="TEXT/CSS">body{overflow:hidden}.image,.sprite{position:absolute}.sprite div{position:relative;top:50%;-ms-transform:translateY(-50%);word-wrap:break-word}</STYLE></HEAD><BODY ID="Anchor"><SCRIPT LANGUAGE="JavaScript">
var inser=document.getElementById("Anchor"),fso=new ActiveXObject("Scripting.FileSystemObject"),user=fso.GetStandardStream(0).ReadLine().split(";");document.getElementById("Anchor").style.background=user[0];window.resizeTo(user[1],user[2]);window.moveTo(user[3],user[4]);var image=[];""!=user[9]&&setImage(altInput(user[9]));var sprite=[];""!=user[10]&&setSprite(altInput(user[10]));""!=user[5]&&makeScene(altInput(user[5]));var arr=[],sprInd=[],idInd=[];""!=user[6]&&makeSprite(altInput(user[6]));
var musInd=[];""!=user[7]&&makeMusic(altInput(user[7]));var hoveInd=[];""!=user[8]&&makeInter(altInput(user[8]));var pause=0;document.onkeypress=function(a){a=a||window.event;msgKey(a.keyCode)};var frame=0,prevKey=["0"],fileKey=readFile("output.txt");fileKey||window.close();var prevHov=["0"],fileHover=readFile("mouse.txt");fileHover||window.close();setInterval(function(){0==pause&&(updSprites(),getOutput(fileKey,prevKey),getOutput(fileHover,prevHov),frame++)},2);
function altInput(a){return a.slice(0,-1).split("@")}function setImage(a){for(i=0;i<a.length;i++)image[i]=a[i]}function setSprite(a){for(i=0;i<a.length;i++){var c=a[i].split("#");sprite[i]={src:c[0],n:c[1]}}}
function makeInter(a){for(i=0;i<a.length;i++){var c=a[i].split("."),b=document.getElementById("Sprite"+c[0]);"C"==c[1]?b.onclick=function(){msgMouse("C "+c[0])}:(b.onmouseleave=function(){msgMouse("D "+c[0]);hoveInd[i]=0},b.onmouseover=function(){hoveInd[i]||(msgMouse("H "+c[0]),hoveInd[i]=1)})}}
function updSprites(){var a="",c=arr.length;for(i=0;i<c;i++)frame%arr[i].eve||(idInd[arr[i].ind].style.backgroundPosition="-"+arr[i].w*arr[i].cur+"px 0",arr[i].cur==arr[i].max?(arr[i].cur=1,1==arr[i].onr&&(a+=arr[i].ind+",")):arr[i].cur+=1);""!=a&&msgAnim(a)}
function getOutput(a,c){for(var b;!a.AtEndOfStream;)b=a.ReadLine();if(null!=b&&(b=b.split("@"),c[0]!=b[0])){var d=b.length;for(k=1;k<d;k++){var f=b[k].split("$"),g=f.length;for(i=0;i<g;i++){var e=f[i].split(";");e[0]=e[0].slice(1);"~"==e[0]?editMusic(e):"*"==e[0]?makeSound(e):"S"==e[0]?window.close():"P"==e[0]?pause=1:"U"==e[0]?pause=0:editSprite(e)}}c[0]=b[0]}}function makeSound(a){(new Audio(a[1])).play()}
function editMusic(a){var c=musInd[a[1]];"0"==a[2]?c.play():"1"==a[2]?c.pause():(c.pause(),c.currentTime=0,c.play())}
function editSprite(a){var c=idInd[a[0]].style;c.left=a[1]+"px";c.top=a[2]+"px";c.width=a[3]+"px";c.height=a[4]+"px";c.msTransform=a[5];c.backgroundColor=a[6];if(null!=a[7]){c.display="none";c.backgroundImage="url('Sprites/"+sprite[a[7]].src+"')";c.backgroundSize=a[3]*sprite[a[7]].n+"px "+a[4]+"px";var b=sprInd[a[0]];arr[b]={max:sprite[a[7]].n-1,cur:arr[b].cur>sprite[a[7]].n?0:0==a[10]?arr[b].cur:0,w:a[3],eve:a[8],ind:arr[b].ind,onr:a[9]};c.display="block"}}
function readFile(a){try{return handle=fso.OpenTextFile(a,1)}catch(c){return null}}function makeScene(a){for(var c=0;c<a.length;c++){var b=a[c].split("."),d=makeElement();d.className="image";d.id="Image"+c;d.style.backgroundImage="url('Sprites/"+image[b[0]]+"')";d.style.backgroundSize=b[4]+"px "+b[5]+"px";d.style.backgroundRepeat="no-repeat";d.style.left=b[1]+"px";d.style.top=b[2]+"px";d.style.zIndex=String(b[3]);d.style.width=b[4]+"px";d.style.height=b[5]+"px"}}
function makeMusic(a){for(var c=0;c<a.length;c++){var b=a[c].split("#"),d=new Audio(b[0]);d.loop="true";1==b[1]&&d.play();musInd.push(d)}}
function makeSprite(a){for(var c=0;c<a.length;c++){var b=a[c].split("."),d=null==b[8]?makeElement():makeText(b[8],b[13]);d.className="sprite";d.id="Sprite"+c;idInd.push(d);"$"!=b[0]?(d.style.backgroundImage="url('Sprites/"+sprite[b[0]].src+"')",d.style.backgroundSize=b[5]*sprite[b[0]].n+"px "+b[6]+"px",sprInd[c]=arr.length,arr.push({max:sprite[b[0]].n-1,cur:1,w:b[5],eve:b[4],ind:c,onr:b[7]})):(d.style.backgroundColor=b[4],d.style.borderRadius=b[7]+"px",null!=b[8]&&(d.style.color=b[10],d.style.fontSize=
b[9]+"px",d.style.textAlign=b[11],d.style.fontFamily=b[12]));d.style.left=b[1]+"px";d.style.top=b[2]+"px";d.style.zIndex=String(b[3]);d.style.width=b[5]+"px";d.style.height=b[6]+"px"}}function makeElement(){var a=document.createElement("div"),c=document.getElementById("Anchor");c.parentNode.insertBefore(a,c);return a}
function makeText(a,c){var b=document.createElement("div"),d=document.getElementById("Anchor"),f=document.createElement("div");f.innerHTML=a.replace(/`/g,"!").replace(/#/g,"&");f.style.padding=c+"px";b.appendChild(f);d.parentNode.insertBefore(b,d);return b}function msgKey(a){msgKey.chk=-1*msgKey.chk||1;null!=msgKey.prev&&fso.DeleteFile(msgKey.prev);msgKey.prev=a+"."+msgKey.chk;fso.CopyFile("input.txt",msgKey.prev)}
function msgMouse(a){msgMouse.chk=-1*msgMouse.chk||2;null!=msgMouse.prev&&fso.DeleteFile(msgMouse.prev);msgMouse.prev=a+"."+msgMouse.chk;fso.CopyFile("input.txt",msgMouse.prev)}function msgAnim(a){msgAnim.chk=-1*msgAnim.chk||3;null!=msgAnim.prev&&fso.DeleteFile(msgAnim.prev);msgAnim.prev=a+"."+msgAnim.chk;fso.CopyFile("input.txt",msgAnim.prev)};
</SCRIPT></BODY><HTML>
```
