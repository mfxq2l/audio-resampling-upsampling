# audio-resampling-upsampling
🎵 Audio Resampling Tool — Upscale audio to Hi-Res via FFmpeg + soxr. Supports FLAC/WAV/MP3/M4A/AAC to 6 rates (96-3072 kHz). Auto-organizes output. Features FLAC cover conversion (JPEG↔PNG). Quick start: place ffmpeg.exe in System32, drop audio files in root, run .bat. Caution: high rates produce GB files. MIT License.
[README_en.md](https://github.com/user-attachments/files/29118370/README_en.md)
---

# 🎵 Audio Resampling & Upsampling Tool

A Windows batch toolset integrating **batch processing** and **high-precision resampling**, supporting one-click upsampling of regular audio to Hi-Res quality.

![Windows](https://img.shields.io/badge/Platform-Windows-blue?logo=windows)
![FFmpeg](https://img.shields.io/badge/Powered%20by-FFmpeg-brightgreen?logo=ffmpeg)
![Batch](https://img.shields.io/badge/Language-Batch-orange)
![License](https://img.shields.io/badge/License-MIT-yellow)

---
**Author:** mfxq2l

**QQ:** 404 Not Found

## 📖 Introduction

> Elevate the mundane to the stars.

Tired of memorizing complex commands for audio upsampling? This toolset handles everything in one go:

- ✅ **Tiered Upsampling Matrix:** 6 selectable sample rates from 96kHz to 3072kHz
- ✅ **Professional Resampling Engine:** Uses the soxr library with precision 33 for high-fidelity, low-distortion output
- ✅ **Universal Format Support:** Accepts FLAC / WAV / MP3 / M4A / AAC input
- ✅ **Auto-Organized Output:** Upsampled files are automatically sorted into corresponding folders
- ✅ **Bonus Cover Tool:** Built-in FLAC cover art conversion (JPEG ↔ PNG)

**Plug and play — no more manual commands!**

---

## ✨ Key Features

| Feature | Description |
|---------|-------------|
| **Multi-tier Upsampling** | Supports 96 / 192 / 384 / 768 / 1536 / 3072 kHz sample rates |
| **Smart Resampling** | Uses `soxr` resampler with precision=33 (highest quality) |
| **Adaptive Format** | Low rates output FLAC (24bit), ultra-high rates output WAV (24bit) |
| **Progress Visualization** | Real-time progress display (current/total files) with success/fail status |
| **Cover Management** | Includes JPEG↔PNG cover conversion scripts to keep your music library tidy |

---

## 🚀 Quick Start

### Requirements
- **Windows 7/10/11**
- **Sufficient disk space** (ultra-high sample rates produce GB-sized files)

### Steps
1. Copy `ffmpeg.exe`, `ffplay.exe`, and `ffprobe.exe` to `C:\Windows\System32` (or ensure they're in your PATH)
2. Place your audio files (`.flac` `.wav` `.mp3` `.m4a` `.aac`) in the project root
3. **Double-click** the desired upsampling script, e.g., `升频至384khz.bat`
4. Wait for processing to complete — upsampled files will be automatically saved to their output folders

---

## 📂 Project Structure

```
audio-resampling-upsampling/
├── README.md                 # Project documentation
├── LICENSE                   # MIT License
├── ffmpeg.exe                # FFmpeg core tool
├── ffplay.exe                # FFmpeg player
├── ffprobe.exe               # FFmpeg probe tool
├── 升频至96khz.bat           # → outputs to 升频music_96/
├── 升频至192khz.bat          # → outputs to 升频192khz_music/
├── 升频至384khz.bat          # → outputs to 升频384khz_music/
├── 升频至768khz.bat          # → outputs to 升频768khz_WAV/
├── 升频至1536khz.bat         # → outputs to 升频1536khz_WAV/
├── 升频至3072khz.bat         # → outputs to 升频3072khz_WAV/
├── JPEG2PNG.bat              # FLAC cover to PNG
├── png2jpeg.bat              # FLAC cover to JPEG
├── 升频music_96/             # 96kHz output directory (auto-generated)
├── 升频192khz_music/         # 192kHz output directory (auto-generated)
├── 升频384khz_music/         # 384kHz output directory (auto-generated)
├── 升频768khz_WAV/           # 768kHz output directory (auto-generated)
├── 升频1536khz_WAV/          # 1536kHz output directory (auto-generated)
└── 升频3072khz_WAV/          # 3072kHz output directory (auto-generated)
```

---

## ⚠️ Important Notes (Must Read!)

### FFmpeg Environment

> **You must place the three FFmpeg executables in `C:\Windows\System32` first, or the scripts will fail!** Alternatively, add the directory containing `ffmpeg.exe` to your system `PATH`.

### 🔥 Disk Space (Critical!)

> **Ultra-high sample rate = Ultra-large files. Leave plenty of room!**

Reference estimates:

| Sample Rate | Output Format | Estimated Size (4-min song) |
|-------------|---------------|-----------------------------|
| 96kHz | FLAC 24bit | ~150 MB |
| 192kHz | FLAC 24bit | ~300 MB |
| 384kHz | FLAC 24bit | ~600 MB |
| 768kHz | WAV 24bit | ~1.2 GB |
| 1536kHz | WAV 24bit | ~2.4 GB |
| **3072kHz** | **WAV 24bit** | **~4.8 GB** |

**It is recommended to reserve at least 50GB of free space**, especially when batch processing multiple songs.

### 🎧 On Listening Experience

Upsampling improves **information density** and **smoothness**, but it **cannot "create"** high-frequency details that weren't present in the original recording.

> **Analogy:** Upsampling is like upscaling a 480p image to 4K using AI — it looks smoother, but details that weren't there originally remain absent. Enjoy the process, and keep your expectations grounded.

---

## 🔄 Workflow

```
Launch script → Scan audio files in current directory
↓
Process one by one
↓
┌─────────────┴─────────────┐
↓                           ↓
Success ✅                  Failure ❌
↓                           ↓
Output to folder            Display error
↓
Processing complete, show statistics
```

---

## 🛠️ Technical Implementation

| Parameter | Description |
|-----------|-------------|
| `-af aresample=resampler=soxr:precision=33` | Uses soxr resampler, precision 33 (highest quality) |
| `-ar 192000` | Target sample rate 192kHz |
| `-c:a flac` | Output FLAC lossless compression |
| `-sample_fmt s32` | 32-bit signed integer sample format |
| `-y` | Auto-overwrite existing output files |

### Cover Conversion Principle

```
ffmpeg -i "%%f" -c:a copy -c:v png -map_metadata 0 -y "temp.flac"
```
- `-c:a copy` – Audio stream copied directly (lossless)
- `-c:v png` – Video/cover stream converted to PNG
- `-map_metadata 0` – Preserves original metadata (artist, album, title, etc.)

---

## 📝 Customization

### Change Target Sample Rate
Open any `.bat` script in Notepad, locate the `-ar` value, and replace it with your desired sample rate.

Example: Change `-ar 192000` to `-ar 176400` (4x CD sample rate).

### Change Output Format
Modify the `-c:a` parameter:

| Parameter | Output |
|-----------|--------|
| `-c:a flac` | FLAC lossless |
| `-c:a pcm_s24le` | WAV 24bit |
| `-c:a pcm_s16le` | WAV 16bit |
| `-c:a alac` | ALAC (Apple Lossless) |

### Change Resampling Precision
Locate `precision=33` and change to `28` (medium quality) or `20` (fast mode) for quicker processing.

---

## 🧪 Sample Output

```
🎵 Audio Upsampling Tool (192kHz FLAC 24bit)

📁 Found 5 audio files

[1/5] 🔄 Processing: 渡口 - 蔡琴.flac
    ✅ Done

[2/5] 🔄 Processing: 加州旅馆 - 老鹰乐队.flac
    ✅ Done

[3/5] 🔄 Processing: 梁祝 - 小提琴.flac
    ✅ Done

[4/5] 🔄 Processing: 贝多芬 - 第五交响曲.flac
    ✅ Done

[5/5] 🔄 Processing: 夜曲 - 肖邦.flac
    ✅ Done

✅ Complete! 5 files processed
```

### 📁 Output Directory: `C:\Users\xxx\升频192khz_music`

---

## 🤝 Contributing & Feedback

If you have suggestions for improvement, feel free to submit an Issue or PR.

### Planned Improvements:
- Drag-and-drop folder support
- GPU acceleration (using FFmpeg's CUDA features)
- DSF / DFF (DSD) output support
- GUI version

---

## 📄 License

**MIT License**

---

## 🙏 Acknowledgements

- **FFmpeg** – The Swiss Army knife of multimedia processing
- **soxr** – High-precision resampling library

---

> **One last thought:** Upsampling is an experience of resonating with the stars — but remember, your ears' hardware might only go up to 20kHz. Enjoy the technical journey, but don't let specs overshadow the music itself. 🎧✨

---
