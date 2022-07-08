<!-- :: ---------- turnip header v1, thelowsunoverthemoon ---------- ::
@ECHO OFF&SETLOCAL ENABLEDELAYEDEXPANSION&SET "d[f]=%~1"&SET "d[a]=%*"&CALL :TURNIP_ENGINE&TITLE &GOTO :MAIN
HTML --><HTML><HEAD><HTA:APPLICATION SCROLL="no" BORDER="thin" CAPTION="no" SHOWINTASKBAR="no" SYSMENU="no" ID="Game">
<META HTTP-EQUIV="x-ua-compatible" CONTENT="IE=9"><STYLE TYPE="TEXT/Batch">

:MAIN
%TURNIP_INIT%

CALL :TURNIP_WINDOW #FFFFFF 900 450 100 100 10

CALL :TURNIP_IMG bkg "bkg.jpg"
CALL :TURNIP_ADD_IMG %bkg% 0 0 0 900 450

FOR %%Q in (Music/*.mp3) DO (
    SET /A "aud[num]+=1", "tex[y]=aud[num] * 70 + 50"
    CALL :TURNIP_ADD_AUDIO aud[!aud[num]!] "Music/%%~Q" 0
    CALL :TURNIP_ADD_TEXT tex[!aud[num]!] 30 !tex[y]! 2 #8c8cde 200 60 10 "Play$25$black$center$good times rg"
    CALL :TURNIP_ADD_TEXT tex 280 !tex[y]! 2 #b769db 500 60 10 "%%~nQ$25$black$center$good times rg"
    FOR %%N in (!aud[num]!) DO (
        SET "play[!tex[%%N]!]=0"
        SET "bri[!tex[%%N]!]=!aud[%%N]!"
        CALL :TURNIP_ADD_ATTRIB !tex[%%N]! C
    )
)

%TURNIP_START_GAME%

:RETURN
EXIT

:GAME
%TURNIP_GAME_LOOP%
IF "!every!" == "0" (
    %TURNIP_GET_MOUSE%
        FOR /F "tokens=1-2" %%A in ("%%~nM") DO (
            IF "!play[%%B]!" == "0" (
                %TURNIP_MSG% ~;!bri[%%B]!;3@ %%B;f$black$25$center$good times rg$Stop
                SET "play[%%B]=1"
            ) else (
                %TURNIP_MSG% ~;!bri[%%B]!;1@ %%B;f$black$25$center$good times rg$Play
                SET "play[%%B]=0"
            )
        )
    %TURNIP_END_MOUSE%
)
SET /A "frame+=1", "every=frame %% 2"
%TURNIP_GAME_END%

:: ---------- turnip engine v1, thelowsunoverthemoon ---------- ::
:TURNIP_ENGINE
SET "TURNIP_MSG=ECHO ^!frame^!@"&SET "TURNIP_START_GAME=(IF not defined turnip[window] SET turnip[window]=;;;;;)&(START /B "" "%~F0" DISP ^!turnip[window]^!;^!turnip[img][a]^!;^!turnip[spr][a]^!;^!turnip[mus][l]^!;^!turnip[att]^!;^!turnip[img][l]^!;^!turnip[spr][l]^!)&(START /B "" "%~F0" GAME)>output.txt&EXIT"
SET "TURNIP_GAME_LOOP=SET /A "nex[ke]=1", "nex[ho]=2", "nex[an]=3", "frame=1"&ECHO 0&(FOR /L %%@ in ()DO ("&SET "TURNIP_GAME_END=)) 3>mouse.txt"&SET "TURNIP_GAME_STOP=ECHO @ S&EXIT"
SET "TURNIP_INIT=((CHCP 65001)>NUL&(IF not "%d[f]%" == "" (IF "%d[f]%" == "GAME" (GOTO :GAME) else ((ECHO ^!d[a]:DISP =^! | MSHTA.exe "%~F0")&GOTO :RETURN)))&(COPY NUL input.txt)>NUL&(DEL /F /Q "*.1" "*.-1" "*.2" "*.-2" "*.3" "*.-3" "output.txt" "mouse.txt") 2>NUL&SET /A "turnip[img]=turnip[spr]=turnip[a]=turnip[mus]=0")>NUL"
SET "TURNIP_GET_KEY=FOR %%K in (*.^!nex[ke]^!)DO ("&SET "TURNIP_END_KEY=SET /A nex[ke]*=-1)"
SET "TURNIP_GET_MOUSE=(FOR %%M in (*.^!nex[ho]^!)DO ("&SET "TURNIP_END_MOUSE=SET /A nex[ho]*=-1))>&3"
SET "TURNIP_GET_ANIM=FOR %%A in (*.^!nex[an]^!)DO (FOR %%F in (%%~nA)DO ("&SET "TURNIP_END_ANIM=)&SET /A nex[an]*=-1)"
SET "TURNIP_EXCL=`"&SET "TURNIP_AND=#"&SET "TURNIP_SOUND=~"&SET "TURNIP_AUDIO=*"&SET "TURNIP_QUESTION=~"
GOTO :EOF
:TURNIP_WINDOW
SET "turnip[window]=%1;%2;%3;%4;%5;%6"&EXIT /B
:TURNIP_IMG
SET "turnip[img][l]=%turnip[img][l]%%~2@"&SET /A "%~1=%turnip[img]%", "turnip[img]+=1"&EXIT /B
:TURNIP_SPRITE
SET "turnip[spr][l]=%turnip[spr][l]%%~2#%3@"&SET /A "%~1=%turnip[spr]%", "turnip[spr]+=1"&EXIT /B
:TURNIP_ADD_IMG
SET "turnip[img][a]=%turnip[img][a]%%1$%2$%3$%4$%5$%6@"&EXIT /B
:TURNIP_ADD_SPR
SET "%~1=%turnip[a]%"&SET "turnip[spr][a]=%turnip[spr][a]%%2$%3$%4$%5$%6$%7$%8$%9@"&SET /A "turnip[a]+=1"&EXIT /B
:TURNIP_ADD_TEXT
SET "%~1=%turnip[a]%"&SET "turnip[spr][a]=%turnip[spr][a]%~$%2$%3$%4$%5$%6$%7$%8$%~9@"&SET /A "turnip[a]+=1"&EXIT /B
:TURNIP_ADD_SHAPE
SET "%~1=%turnip[a]%"&SET "turnip[spr][a]=%turnip[spr][a]%~$%2$%3$%4$%5$%6$%7$%8@"&SET /A "turnip[a]+=1"&EXIT /B
:TURNIP_ADD_ATTRIB
SET "turnip[att]=%turnip[att]%%1.%2@"&EXIT /B
:TURNIP_ADD_AUDIO
SET "%~1=%turnip[mus]%"&SET "turnip[mus][l]=%turnip[mus][l]%%~2#%3@"&SET /A "turnip[mus]+=1"&EXIT /B
</STYLE><STYLE TYPE="TEXT/CSS">body{overflow:hidden}.image,.sprite{position:absolute}.sprite div{position:relative;top:50%;-ms-transform:translateY(-50%);word-wrap:break-word}</STYLE></HEAD><BODY ID="Anchor"><SCRIPT LANGUAGE="JavaScript">
var inser=document.getElementById("Anchor"),fso=new ActiveXObject("Scripting.FileSystemObject"),user=fso.GetStandardStream(0).ReadLine().split(";");""==user[0]&&(user[0]="#FFFFFF");""==user[1]&&(user[1]=500);""==user[2]&&(user[2]=500);""==user[3]&&(user[3]=0);""==user[4]&&(user[4]=0);""==user[5]&&(user[5]=10);document.getElementById("Anchor").style.background=user[0];window.resizeTo(user[1],user[2]);window.moveTo(user[3],user[4]);var image=[];""!=user[10]&&setImage(altInput(user[10]));
var sprite=[];""!=user[11]&&setSprite(altInput(user[11]));""!=user[6]&&makeScene(altInput(user[6]));var arr=[],sprInd=[],idInd=[];""!=user[7]&&makeSprite(altInput(user[7]));var arrLen=arr.length,musInd=[];""!=user[8]&&makeMusic(altInput(user[8]));var hoveInd=[];""!=user[9]&&makeInter(altInput(user[9]));var pause=0;document.onkeypress=function(c){c=c||window.event;msgKey(c.keyCode)};var frame=0,prevKey=["0"],fileKey=readFile("output.txt");fileKey||window.close();var prevHov=["0"],fileHover=readFile("mouse.txt");
fileHover||window.close();setInterval(function(){0==pause&&(updSprites(),frame++)},user[5]);setInterval(function(){getOutput(fileKey,prevKey);getOutput2(fileHover,prevHov)},10);function altInput(c){return c.slice(0,-1).split("@")}function setImage(c){for(i=0;i<c.length;i++)image[i]=c[i]}function setSprite(c){for(i=0;i<c.length;i++){var d=c[i].split("#");sprite[i]={src:d[0],n:d[1]}}}
function makeInter(c){for(i=0;i<c.length;i++)(function(d){var b=c[d].split("."),a=document.getElementById("Sprite"+b[0]);"C"==b[1]?a.onclick=function(){msgMouse("C "+b[0])}:(a.onmouseleave=function(){msgMouse("D "+b[0]);hoveInd[d]=0},a.onmouseover=function(){hoveInd[d]||(msgMouse("H "+b[0]),hoveInd[d]=1)})})(i)}
function updSprites(){var c="";for(i=0;i<arrLen;i++)frame%arr[i].eve||(idInd[arr[i].ind].style.backgroundPosition="-"+arr[i].w*arr[i].cur+"px 0",arr[i].cur==arr[i].max?(arr[i].cur=1,1==arr[i].onr&&(c+=arr[i].ind+",")):arr[i].cur+=1);""!=c&&msgAnim(c)}
function getOutput(c,d){for(var b;!c.AtEndOfStream;)b=c.ReadLine();if(null!=b&&(b=b.split("@"),d[0]!=b[0])){for(var a=b.length,e=1;e<a;e++){var f=b[e].split(";");f[0]=f[0].slice(1);switch(f[0]){case "~":editMusic(f);break;case "*":makeSound(f);break;case "S":window.close();break;case "P":pause=1;break;case "U":pause=0;break;default:editSprite(f)}}d[0]=b[0]}}
function getOutput2(c,d){for(var b;!c.AtEndOfStream;)if(b=c.ReadLine(),b=b.split("@"),d[0]!=b[0]){for(var a=b.length,e=1;e<a;e++){var f=b[e].split(";");f[0]=f[0].slice(1);switch(f[0]){case "~":editMusic(f);break;case "*":makeSound(f);break;case "S":window.close();break;case "P":pause=1;break;case "U":pause=0;break;default:editSprite(f)}}d[0]=b[0]}}function makeSound(c){(new Audio(c[1])).play()}
function editMusic(c){var d=musInd[c[1]];"0"==c[2]?d.play():"1"==c[2]?d.pause():(d.pause(),d.currentTime=0,d.play())}
function editSprite(c){var d=idInd[c[0]].style,b=c.length;for(k=1;k<b;k++){var a=c[k].split("$");switch(a[0]){case "x":d.left=a[1]+"px";break;case "y":d.top=a[1]+"px";break;case "w":d.width=a[1]+"px";break;case "h":d.height=a[1]+"px";break;case "t":d.msTransform=a[1];break;case "b":d.backgroundColor=a[1];break;case "r":d.borderRadius=a[1]+"px";break;case "s":d.display="none";d.backgroundImage="url('"+sprite[a[1]].src+"')";d.backgroundSize=a[2]*sprite[a[1]].n+"px "+a[3]+"px";var e=sprInd[c[0]];arr[e]=
{max:sprite[a[1]].n-1,cur:arr[e].cur>sprite[a[1]].n?0:0==a[6]?arr[e].cur:0,w:a[2],eve:a[4],ind:arr[e].ind,onr:a[5]};d.display="block";break;case "f":d.color=a[1],d.fontSize=a[2]+"px",d.textAlign=a[3],d.fontFamily=a[4],idInd[c[0]].getElementsByClassName("text")[0].innerHTML=a[5].replace(/`/g,"!").replace(/#/g,"&").replace(/~/g,"?")}}}function readFile(c){try{return handle=fso.OpenTextFile(c,1)}catch(d){return null}}
function makeScene(c){for(var d=0;d<c.length;d++){var b=c[d].split("$"),a=makeElement();a.className="image";a.id="Image"+d;a.style.backgroundImage="url('"+image[b[0]]+"')";a.style.backgroundSize=b[4]+"px "+b[5]+"px";a.style.backgroundRepeat="no-repeat";a.style.left=b[1]+"px";a.style.top=b[2]+"px";a.style.zIndex=String(b[3]);a.style.width=b[4]+"px";a.style.height=b[5]+"px"}}
function makeMusic(c){for(var d=0;d<c.length;d++){var b=c[d].split("#"),a=new Audio(b[0]);a.loop="true";1==b[1]&&a.play();musInd.push(a)}}
function makeSprite(c){for(var d=0;d<c.length;d++){var b=c[d].split("$"),a=null==b[8]?makeElement():makeText(b[8],b[13]);a.className="sprite";a.id="Sprite"+d;idInd.push(a);"~"==b[0]?(a.style.backgroundColor=b[4],a.style.borderRadius=b[7]+"px",null!=b[8]&&(a.style.color=b[10],a.style.fontSize=b[9]+"px",a.style.textAlign=b[11],a.style.fontFamily=b[12])):(a.style.backgroundImage="url('"+sprite[b[0]].src+"')",a.style.backgroundSize=b[5]*sprite[b[0]].n+"px "+b[6]+"px",sprInd[d]=arr.length,arr.push({max:sprite[b[0]].n-
1,cur:1,w:b[5],eve:b[4],ind:d,onr:b[7]}));a.style.left=b[1]+"px";a.style.top=b[2]+"px";a.style.zIndex=String(b[3]);a.style.width=b[5]+"px";a.style.height=b[6]+"px"}}function makeElement(){var c=document.createElement("div"),d=document.getElementById("Anchor");d.parentNode.insertBefore(c,d);return c}
function makeText(c,d){var b=document.createElement("div"),a=document.getElementById("Anchor"),e=document.createElement("div");e.className="text";e.innerHTML=c.replace(/`/g,"!").replace(/#/g,"&").replace(/~/g,"?");e.style.padding=d+"px";b.appendChild(e);a.parentNode.insertBefore(b,a);return b}function msgKey(c){msgKey.chk=-1*msgKey.chk||1;null!=msgKey.prev&&fso.DeleteFile(msgKey.prev);msgKey.prev=c+"."+msgKey.chk;fso.CopyFile("input.txt",msgKey.prev)}
function msgMouse(c){msgMouse.chk=-1*msgMouse.chk||2;null!=msgMouse.prev&&fso.DeleteFile(msgMouse.prev);msgMouse.prev=c+"."+msgMouse.chk;fso.CopyFile("input.txt",msgMouse.prev)}function msgAnim(c){msgAnim.chk=-1*msgAnim.chk||3;null!=msgAnim.prev&&fso.DeleteFile(msgAnim.prev);msgAnim.prev=c+"."+msgAnim.chk;fso.CopyFile("input.txt",msgAnim.prev)};
</SCRIPT></BODY><HTML>