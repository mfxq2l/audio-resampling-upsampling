@echo off
chcp 65001 >nul
title Audio Upsampling Tool - 3072kHz WAV 24bit

setlocal enabledelayedexpansion

echo ============================================================
echo    🎵 Audio Upsampling Tool (3072kHz WAV 24bit)
echo ============================================================
echo.

set "outputdir=%~dp0upsampled_3072_WAV"

if not exist "%outputdir%" mkdir "%outputdir%"

set count=0
set total=0

for %%f in (*.flac *.wav) do set /a total+=1 2>nul

if %total%==0 (
    echo ❌ No FLAC/WAV files found in current folder
    pause
    exit /b
)

echo   Found %total% audio file(s)
echo.

for %%f in (*.flac *.wav) do (
    set /a count+=1
    echo [!count!/%total%] 🔄 Processing: %%f
    ffmpeg -i "%%f" -af aresample=resampler=soxr:precision=33 -ar 3072000 -c:a pcm_s24le -y -hide_banner -loglevel error "%outputdir%\%%~nf.wav"
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