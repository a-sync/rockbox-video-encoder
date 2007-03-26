::Rockbox Video Encoder Batch file, created by Vector Akashi::
::cls
@echo off
if "%2"=="" goto error7
if "%4"=="UseSaved" goto loaded
echo.
:check0
if "%bitrate%"=="" goto bitrate
goto check1
:bitrate
Color 0A
set /p bitrate= Set the bitrate: 
if "%bitrate%"=="" goto error5
:check1
if "%mpeg%"=="" goto mpeg
goto startend
:mpeg
Color 0A
echo.
echo  [1] Use mpeg1video for the encoding
echo  [2] Use mpeg2video for the encoding
echo.
set /p mpeg= Select: 
echo.
if "%mpeg%"=="1" (
  set mpeg=mpeg1video
  goto startend
)
if "%mpeg%"=="2" (
  set mpeg=mpeg2video
  goto startend
)
goto error6
:startend
set startpos=
set /p startpos= Set the start position in the input (eg. 1:30 or empty): 
set endpos=
set /p endpos= Set the lenght of the output (eg. 90 or empty): 
:check2
if "%save%"=="" goto save
goto prefix
:save
set /p save= Save your settings (eg. save1 or empty): 
if "%save%"=="" goto prefix
echo ::RVE Save file::>bin\saved\%save%.bat
echo ::%save%::>>bin\saved\%save%.bat
echo set width="%2">>bin\saved\%save%.bat
echo set bitrate="%bitrate%">>bin\saved\%save%.bat
echo set mpeg=%mpeg%>>bin\saved\%save%.bat
echo set startpos="%startpos%">>bin\saved\%save%.bat
echo set endpos="%endpos%">>bin\saved\%save%.bat
if "%3"=="" goto saveauto
echo set height="%3">>bin\saved\%save%.bat
goto prefix
:saveauto
echo set height=Auto>>bin\saved\%save%.bat
:prefix
set save=NoN
set prefix=
set /p prefix= Add a prefix to the filenames (eg. _part1 or empty): 
:category
echo.
if "%3"=="" goto pre-set1
if "%3"=="Auto" goto pre-set1
if "%4"=="UseSaved" goto custom1
if "%4"=="" goto custom1
goto error7
:custom1
if "%startpos%"=="" goto custom3
if "%startpos%"=="""" goto custom3
if "%endpos%"=="" goto custom2
if "%endpos%"=="""" goto custom2
bin\mencoder %1 -of mpeg -oac lavc -lavcopts acodec=mp2:abitrate=192 -af resample=44100:0:0 -ovc lavc -lavcopts vcodec=%mpeg%:vbitrate=%bitrate% -vf scale=%~2:%~3,harddup -ofps 25 -ss %startpos% -endpos %endpos% -o "videos/%~n1%prefix%.mpg"
cls
goto exit
:custom2
if "%startpos%"=="" goto custom4
if "%startpos%"=="""" goto custom4
bin\mencoder %1 -of mpeg -oac lavc -lavcopts acodec=mp2:abitrate=192 -af resample=44100:0:0 -ovc lavc -lavcopts vcodec=%mpeg%:vbitrate=%bitrate% -vf scale=%~2:%~3,harddup -ofps 25 -ss %startpos% -o "videos/%~n1%prefix%.mpg"
cls
goto exit
:custom3
if "%endpos%"=="" goto custom4
if "%endpos%"=="""" goto custom4
bin\mencoder %1 -of mpeg -oac lavc -lavcopts acodec=mp2:abitrate=192 -af resample=44100:0:0 -ovc lavc -lavcopts vcodec=%mpeg%:vbitrate=%bitrate% -vf scale=%~2:%~3,harddup -ofps 25 -endpos %endpos% -o "videos/%~n1%prefix%.mpg"
cls
goto exit
:custom4
bin\mencoder %1 -of mpeg -oac lavc -lavcopts acodec=mp2:abitrate=192 -af resample=44100:0:0 -ovc lavc -lavcopts vcodec=%mpeg%:vbitrate=%bitrate% -vf scale=%~2:%~3,harddup -ofps 25 -o "videos/%~n1%prefix%.mpg"
cls
goto exit
:pre-set1
if "%startpos%"=="" goto pre-set3
if "%endpos%"=="" goto pre-set2
bin\mencoder %1 -of mpeg -oac lavc -lavcopts acodec=mp2:abitrate=192 -af resample=44100:0:0 -ovc lavc -lavcopts vcodec=%mpeg%:vbitrate=%bitrate% -vf scale,harddup -ofps 25 -ss %startpos% -endpos %endpos% -zoom -xy %~2 -o "videos/%~n1%prefix%.mpg"
cls
goto exit
:pre-set2
if "%startpos%"=="" goto pre-set4
bin\mencoder %1 -of mpeg -oac lavc -lavcopts acodec=mp2:abitrate=192 -af resample=44100:0:0 -ovc lavc -lavcopts vcodec=%mpeg%:vbitrate=%bitrate% -vf scale,harddup -ofps 25 -ss %startpos% -zoom -xy %~2 -o "videos/%~n1%prefix%.mpg"
cls
goto exit
:pre-set3
if "%endpos%"=="" goto pre-set4
bin\mencoder %1 -of mpeg -oac lavc -lavcopts acodec=mp2:abitrate=192 -af resample=44100:0:0 -ovc lavc -lavcopts vcodec=%mpeg%:vbitrate=%bitrate% -vf scale,harddup -ofps 25 -endpos %endpos% -zoom -xy %~2 -o "videos/%~n1%prefix%.mpg"
cls
goto exit
:pre-set4
bin\mencoder %1 -of mpeg -oac lavc -lavcopts acodec=mp2:abitrate=192 -af resample=44100:0:0 -ovc lavc -lavcopts vcodec=%mpeg%:vbitrate=%bitrate% -vf scale,harddup -ofps 25 -zoom -xy %~2 -o "videos/%~n1%prefix%.mpg"
cls
goto exit
:loaded
if "%set%"=="1" goto prefix
if "%set%"=="" goto category
set prefix=%set%
goto category
::Error handling::
:error5
color 4F
echo.
echo ERROR 05:
echo  You need to set the BITRATE of the video!
pause
echo.
cls
goto bitrate
:error6
color 4F
echo.
echo ERROR 06:
echo  Select from the LIST!
pause
echo.
cls
goto mpeg
:error7
color 4F
echo.
echo ERROR 06:
echo  Incorrect or missing parameters!
pause
echo.
cls
:exit