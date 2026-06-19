@echo off
chcp 65001 >nul
title Audio Upsampling Tool - 96kHz FLAC 24bit

setlocal enabledelayedexpansion

echo ============================================================
echo    🎵 Audio Upsampling Tool (96kHz FLAC 24bit)
echo ============================================================
echo.

set "outputdir=%~dp0upsampled_96"

if not exist "%outputdir%" mkdir "%outputdir%"

set count=0
set total=0

for %%f in (*.flac *.wav *.mp3 *.m4a *.aac) do set /a total+=1 2>nul

if %total%==0 (
    echo ❌ No audio files found in current folder
    echo    Supported formats: .flac .wav .mp3 .m4a .aac
    pause
    exit /b
)

echo   Found %total% audio file(s)
echo.

for %%f in (*.flac *.wav *.mp3 *.m4a *.aac) do (
    set /a count+=1
    echo [!count!/%total%] 🔄 Processing: %%f
    ffmpeg -i "%%f" -af aresample=resampler=soxr:precision=33 -ar 96000 -c:a flac -sample_fmt s32 -y -hide_banner -loglevel error "%outputdir%\%%~nf.flac"
    if errorlevel 1 (
        echo     ❌ Failed
    ) else (
        echo     ✅ Done
    )
    echo.
)

echo ============================================================
echo ✅ Complete! %count% file(s) processed
echo 📁 Output directory: %outputdir%
echo ============================================================
pause