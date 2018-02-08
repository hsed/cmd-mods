@echo off

:: Init Script for cmd.exe
:: Created as part of cmder project

:: !!! THIS FILE IS OVERWRITTEN WHEN CMDER IS UPDATED
:: !!! Use "%CMDER_ROOT%\config\user-profile.cmd" to add your own startup commands

:: Set to > 0 for verbose output to aid in debugging.
if not defined verbose-output ( set verbose-output=0 )


:: Remove trailing '\'
if "%CMDER_ROOT:~-1%" == "\" SET "CMDER_ROOT=%CMDER_ROOT:~0,-1%"

:: Pick right version of clink
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    set architecture=86
) else (
    set architecture=64
)

"%CMDER_ROOT%\vendor\clink\clink_x64.exe" inject --quiet --profile "%CMDER_ROOT%\config" --scripts "%CMDER_ROOT%\vendor"


:: I do not even know, copypasted from their .bat
set PLINK_PROTOCOL=ssh
if not defined TERM set TERM=cygwin

:: The idea:
:: * if the users points as to a specific git, use that
:: * test if a git is in path and if yes, use that
:: * last, use our vendored git
:: also check that we have a recent enough version of git (e.g. test for GIT\cmd\git.exe)
if defined GIT_INSTALL_ROOT (
    if exist "%GIT_INSTALL_ROOT%\cmd\git.exe" (goto :FOUND_GIT)
)


:FOUND_GIT
rem add the unix commands at the end to not shadow windows commands like more
set "PATH=%PATH%;%GIT_INSTALL_ROOT%\usr\bin;%GIT_INSTALL_ROOT%\usr\share\vim\vim74"
:: define SVN_SSH so we can use git svn with ssh svn repositories
if not defined SVN_SSH set "SVN_SSH=%GIT_INSTALL_ROOT:\=\\%\\bin\\ssh.exe"

endlocal & set "PATH=%PATH%" & set "SVN_SSH=%SVN_SSH%" & set "GIT_INSTALL_ROOT=%GIT_INSTALL_ROOT%"


:: Enhance Path
set "PATH=%CMDER_ROOT%\bin;%PATH%;%CMDER_ROOT%\"


:: Allows user to override default aliases store using profile.d
:: scripts run above by setting the 'aliases' env variable.
::
:: Note: If overriding default aliases store file the aliases
:: must also be self executing, see '.\user-aliases.cmd.example',
:: and be in profile.d folder.
set "user-aliases=%CMDER_ROOT%\config\user-aliases.cmd"


if not defined aliases (
  set "aliases=%user-aliases%"
)

:: Add aliases to the environment
call "%user-aliases%"

:: Set home path
if not defined HOME set "HOME=%USERPROFILE%"

:: This is either a env variable set by the user or the result of
:: cmder.exe setting this variable due to a commandline argument or a "cmder here"
if defined CMDER_START (
    pushd "%CMDER_START%"
)

if exist "%CMDER_ROOT%\config\user-profile.cmd" (
    REM Create this file and place your own command in there
    call "%CMDER_ROOT%\config\user-profile.cmd"
)


exit /b


