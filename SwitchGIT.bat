@ECHO OFF

@SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

 

FOR %%p IN (git.exe) DO SET "progpath=%%~$PATH:p"

IF NOT DEFINED progpath (

  ECHO The path to git.exe doesn't exist in PATH variable, inserting it:

  SET "PATH=%PATH%;C:\Program Files\Git\bin\;"

)

 

SET "ShortTeamName=UE"

SET "LongTeamName=User_Experience"

SET "LongTFSTeamName=User Experience"

SET "WorkingPath=C:\Toolbox\Connexus [Working 2]"

 

IF %1.==. GOTO Function_NoBranch

IF %2.==. GOTO Function_NoTask

IF NOT %3.==. GOTO Function_ToMany

SET branch=%1

SET task=%2

 

ECHO %branch%| findstr /r "[0-9]*[\.][0-9]*[\.][0-9]*$">NUL

if NOT %errorlevel% equ 0 (

    GOTO Function_BranchFormat

)

 

ECHO %task%| findstr /r "[0-9][\d]*$">NUL

if NOT %errorlevel% equ 0 (

    GOTO Function_TaskFormat

)

 

:MAIN

  ECHO.

    ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    ECHO :: The %~nx0 script args are:

    ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    FOR %%I IN (%*) DO ECHO %%I

  ECHO.

    IF NOT EXIST "%WorkingPath%" (

      ECHO.

      ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

      ECHO :: Cloning ConnexUs

      ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

        git.exe clone -v --recurse-submodules --progress "https://walmart.visualstudio.com/Connexus/_git/ConnexUs" "%WorkingPath%"

      ECHO.

    )

  ECHO.

    ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    ECHO :: Changing to %WorkingPath% directory...

    ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    CD %WorkingPath%

    ECHO.

  ECHO.

    REM ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    REM ECHO :: Checking out %1

    REM ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    REM   git.exe checkout remotes/origin/%1

  REM ECHO.

    REM ECHO.

  ECHO.

    ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    ECHO :: Checking out %1_%2

    ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

      REM git.exe checkout -f --track -B "%LongTeamName%/%1_%2" "remotes/origin/%1"

      git.exe checkout -f --track -B "%LongTeamName%/%UserName%/%1_%2" "remotes/origin/development"

      REM git.exe checkout -f --track -B "%ShortTeamName%/%UserName%/%1_%2" remotes/origin/%1

    ECHO.

  ECHO.

    ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    ECHO :: Pulling Origin

    ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

      git.exe pull --progress -v --no-rebase "origin"

    ECHO.

  ECHO.

    ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    ECHO :: Pushing remote %1_%2

    ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

      REM git.exe push -u origin "%LongTeamName%/%1_%2"

      git.exe push -u origin "%LongTeamName%/%UserName%/%1_%2"

      REM git.exe push -u origin "%ShortTeamName%/%UserName%/%1_%2"

    ECHO.

  ECHO.

    ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    ECHO :: Launching Task

    ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

      start "" "https://walmart.visualstudio.com/Connexus/%LongTFSTeamName%/_workitems?id=%2%&_a=edit"

  ECHO.

    ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    ECHO :: Launching Pull Request

    ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

      start "" "https://walmart.visualstudio.com/Connexus/%LongTFSTeamName%/_git/ConnexUs/pullrequests?_a=mine"

  ECHO.

  FOR /F "TOKENS=1,2,3,4 DELIMS= " %%a IN ('NET USER "%USERNAME%" /DOMAIN ^| FIND /I "FULL NAME"') DO SET first=%%a&SET second=%%b&SET FName=%%c&SET LName=%%d

  ECHO So, %FName%, what's happening? Aahh, now, are you going to go ahead and have

  ECHO those TPS reports for us this afternoon?

  ECHO.

GOTO:EOF

 

:Function_NoBranch

  IF %1.==. (

    ECHO No Branch supplied, usage: SwitchGit Branch TFSTaskID

    ECHO EXAMPLE: SwitchGit 3.13.0 123456

  )

  GOTO:EOF

 

:Function_NoTask

  IF %2.==. (

    ECHO No TFSTaskID supplied, usage: SwitchGit Branch TFSTaskID

    ECHO EXAMPLE: SwitchGit 3.13.0 123456

  )

  GOTO:EOF

 

:Function_ToMany

  IF NOT %3.==. (

    ECHO Too Many Parameters, usage: SwitchGit Branch TFSTaskID

    ECHO EXAMPLE: SwitchGit 3.13.0 123456

  )

  GOTO:EOF

 

  :Function_BranchFormat

    IF %1.==. (

    ECHO Invalid Branch supplied, usage: SwitchGit Branch TFSTaskID

    ECHO EXAMPLE: SwitchGit 3.13.0 123456

  )

  GOTO:EOF

 

:Function_TaskFormat

  IF %2.==. (

    ECHO Invalid TFSTaskID supplied, usage: SwitchGit Branch TFSTaskID

    ECHO EXAMPLE: SwitchGit 3.13.0 123456

  )

  GOTO:EOF

 

(ENDLOCAL)