### How does it work?
---
In ```MAIN```, the objects are put into a variables, which are then piped into ```MSHTA``` when the game starts. These are then parsed into images, sprites, ect. However, when MSHTA is launched, another process, going to ```GAME``` (which has the game loop) is launched as well. The entire process is redirected into ```output.txt```, which is read by MSHTA (the renderer). The file is kept alive at all times and skips until the latest line, so it does not waste time reading the same lines over and over again. For inputs related to the mouse however, it is redirected to ```mouse.txt``` to get more precise reading.

That is how the Batch file "messages" the renderer. However, to get key/mouse/animation input from renderer to Batch file, we do this through file names. Each type of input is represented by a number as the file extension, with the value in the file name. The batch file uses a simple ```FOR``` loop (not ```/F```) to detect the existence of the file and get the value with the ```~n``` modifier. However, since we do not want to read the same value over and over again, we multiply the previous file name (the number) by ```-1``` to alternate the file extension. These are then put into macros for ease of use. For example, in %TURNIP_GET_KEY% we have 

```Batch
FOR %%K in (*.^!nex[ke]^!)DO (
```

```nex[ke]``` represents the current number (negative or positive) so that it only runs if it finds such a file. The ending macro is simply

```Batch
SET /A nex[ke]*=-1)
```

When the renderer ends, it goes to the :RETURN label from the MSHTA process (the other processes are closed)
