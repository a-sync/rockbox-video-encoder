::Rockbox Video Encoder Batch file, created by Vector Akashi::
TITLE Rockbox Video Encoder
Color 0E
cls
@echo off
if "%1"=="" goto intro
goto %1
:intro
cls
echo.
echo      »»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»
echo      »   __  __                 __                     »
echo      »  /\ \/\ \               /\ \__                  »
echo      »  \ \ \ \ \     __    ___\ \ ,_\   ___   _ __    »
echo      »   \ \ \ \ \  /'__`\ /'___\ \ \/  / __`\/\`'__\  »
echo      »    \ \ \_/ \/\  __//\ \__/\ \ \_/\ \_\ \ \ \/   »
echo      »     \ `\___/\ \____\ \____\\ \__\ \____/\ \_\   »
echo      »      `\/__/  \/____/\/____/ \/__/\/___/  \/_/   »
echo      »                                                 »
echo      »         Rockbox Video Encoder Batch file        »
echo      »      by Vector Akashi (gecman @ gmail.com)      »
echo      »                                                 »
echo      »                   Version 1.3                   »
echo      »                                                 »
echo      »                 www.rockbox.org                 »
echo      »                                                 »
echo      »                www.mplayerhq.hu                 »
echo      »                                                 »
echo      »»%DATE%»»»»»»»»»»»»»»»»»»»»»»»%TIME%»»
echo.
pause
:filter
Color 0A
set filter=
cls
echo.
echo  Set the files to encode: the selected fles in the directory will be converted.
echo  You can use wildcards. (eg. *.avi or vid00?.avi)
echo  Type in your file filter. (Mencoder will abort on non video file.)
echo.
set /p filter= Set: 
if "%filter%"=="" goto error0
:files
Color 0A
set files=
echo.
echo  Selected files:
echo  ==========
dir/b/on %filter%
echo  ==========
echo.
echo  [1] New file filter
echo  [2] Load a saved settings file
echo.
echo  [Enter] Next settings
echo.
set /p files= Select: 
echo.
if "%files%"=="" goto res
if "%files%"=="1" goto filter
if "%files%"=="2" goto load
set error2=files
goto error2
:res
Color 0A
set res=
cls
echo.
echo  Please select a Resolution
echo.
echo  4:3 Video
echo  ==========
echo  [0] 128x96    (iriver H10 5/6GB)
echo  [1] 160x128   (iaudio X5 and iriver H10 20GB)
echo  [2] 176x128   (ipod Nano)
echo  [3] 224x176   (iriver H300, ipod Color/Photo and Sansa e200)
echo  [4] 320x240   (ipod Video and Gigabeat)
echo.
echo  16:9 Video
echo  ==========
echo  [5] 128x80    (iriver H10 5/6GB)
echo  [6] 160x96    (iaudio X5 and iriver H10 20GB)
echo  [7] 176x96    (ipod Nano)
echo  [8] 224x128   (iriver H300, ipod Color/Photo and Sansa e200)
echo  [9] 320x176   (ipod Video and Gigabeat)
echo.
echo  [Enter] Custom Options
echo.
set /P res= Select: 
echo.
if "%res%"=="0" goto 128x96
if "%res%"=="1" goto 160x128
if "%res%"=="2" goto 176x128
if "%res%"=="3" goto 224x176
if "%res%"=="4" goto 320x240
if "%res%"=="5" goto 128x80
if "%res%"=="6" goto 160x96
if "%res%"=="7" goto 176x96
if "%res%"=="8" goto 224x128
if "%res%"=="9" goto 320x176
if "%res%"=="" goto custom
set error2=res
goto error2
:128x96
FOR %%i IN (%filter%) DO bin\perform "%%i" 128
goto error0
:160x128
FOR %%i IN (%filter%) DO bin\perform "%%i" 160
goto error0
:176x128
FOR %%i IN (%filter%) DO bin\perform "%%i" 176
goto error0
:224x176
FOR %%i IN (%filter%) DO bin\perform "%%i" 224
goto error0
:320x240
FOR %%i IN (%filter%) DO bin\perform "%%i" 320
goto error0
:128x80
FOR %%i IN (%filter%) DO bin\perform "%%i" 128
goto error0
:160x96
FOR %%i IN (%filter%) DO bin\perform "%%i" 160
goto error0
:176x96
FOR %%i IN (%filter%) DO bin\perform "%%i" 176
goto error0
:224x128
FOR %%i IN (%filter%) DO bin\perform "%%i" 224
goto error0
:320x176
FOR %%i IN (%filter%) DO bin\perform "%%i" 320
goto error0
:custom
cls
echo.
echo  Custom Options
echo.
:width
Color 0A
set /p width= Set the width: 
if "%width%"=="" goto error3
:height
Color 0A
set /p height= Set the height: 
if "%height%"=="" goto error4
FOR %%i IN (%filter%) DO bin\perform "%%i" %width% %height%
goto error0
:load
Color 0A
set width=
set load=
cls
echo.
echo  Load a saved settings file or hit [Enter] to go back.
echo  ==========
dir/b/on bin\saved\*.bat
echo  ==========
echo.
set /p load= Load: 
echo.
if "%load%"=="" goto files
call bin\saved\%load%
echo.
if "%width%"=="" goto error1
echo  Video settings loaded... (%load%)
echo  ==========
echo  Width: %width%  Height: %height%
echo.
echo  Bitrate: %bitrate%kbps
echo  Encoding: %mpeg%
echo.
echo  Start position in the input set to: %startpos%
echo  Lenght of the output set to: %endpos%
echo  ==========
echo.
:settings
Color 0A
set set=
echo.
echo  Entering anything else will be used as a global prefix for all files.
echo.
echo  [1] Start encoding and ask for prefixes
echo  [2] Load new settings
echo  [3] Go to selected files
echo.
echo  [Enter] Start encoding and no prefixes
echo.
set /p set= Select: 
echo.
cls
if "%set%"=="2" goto load
if "%set%"=="3" goto files
FOR %%i IN (%filter%) DO bin\perform "%%i" %width% %height% UseSaved
goto error0
::Error handling::
:error0
color 4F
echo.
echo ERROR 00:
echo  No files selected. You need to set a correct FILE FILTER!
pause
echo.
cls
goto filter
:error1
color 4F
echo ERROR 01:
echo  No such saved file! Try again!
pause
echo.
cls
goto load
:error2
color 4F
echo ERROR 02 (%error2%):
echo  Select from the LIST!
pause
echo.
cls
goto %error2%
:error3
color 4F
echo.
echo ERROR 03:
echo  You need to set the WIDTH of the video!
pause
echo.
cls
goto width
:error4
color 4F
echo.
echo ERROR 04:
echo  You need to set the HEIGHT of the video!
pause
echo.
cls
goto height
:exit