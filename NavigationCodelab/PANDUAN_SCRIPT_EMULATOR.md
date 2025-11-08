# 🛠️ SCRIPT BANTUAN EMULATOR ANDROID

## 📋 Daftar Script yang Tersedia

### 1. **restart-emulator.bat** ✅ SUDAH ADA
**Fungsi**: Restart emulator yang hang atau bermasalah
**Kapan digunakan**: 
- Emulator lambat atau tidak responsif
- ADB tidak terdeteksi
- Device menunjukkan status "offline"

**Cara pakai**: Double-click file `restart-emulator.bat`

---

### 2. **fix-emulator.bat** ✅ SUDAH ADA
**Fungsi**: Fix masalah signature dan install app
**Kapan digunakan**:
- Error: `INSTALL_FAILED_UPDATE_INCOMPATIBLE`
- Ingin uninstall app lama dan install yang baru
- Setelah emulator berhasil running

**Cara pakai**: 
1. Pastikan emulator sudah running
2. Double-click file `fix-emulator.bat`

---

### 3. **diagnose-emulator.bat** ✅ BARU DIBUAT
**Fungsi**: Diagnosa lengkap masalah emulator
**Kapan digunakan**: 
- Tidak tahu kenapa emulator bermasalah
- Ingin lihat status lengkap sistem
- Troubleshooting awal

**Cara pakai**: Double-click file `diagnose-emulator.bat`

**Output yang ditampilkan**:
- ADB version
- Connected devices
- Running processes
- Android SDK path
- Available emulators
- Installed apps

---

### 4. **start-emulator.bat** ✅ BARU DIBUAT
**Fungsi**: Start emulator dari command line
**Kapan digunakan**:
- Ingin start emulator tanpa buka Android Studio
- Android Studio terlalu berat
- Troubleshooting boot emulator

**Cara pakai**: 
1. Double-click file `start-emulator.bat`
2. Pilih nama emulator (atau Enter untuk default)
3. Tunggu emulator boot

---

## 🚀 ALUR KERJA YANG DIREKOMENDASIKAN

### Scenario 1: Emulator Pertama Kali
```
1. Buka Android Studio > Tools > Device Manager
2. Create new emulator (Pixel 4, API 30)
3. Klik Play ▶ dan tunggu boot (2-5 menit)
4. Jalankan: fix-emulator.bat
5. SELESAI! App terinstall
```

### Scenario 2: Emulator Hang/Lambat
```
1. Jalankan: restart-emulator.bat
2. Buka Android Studio > Tools > Device Manager
3. Klik Play ▶ pada emulator
4. Jalankan: fix-emulator.bat
```

### Scenario 3: Tidak Tahu Masalahnya Apa
```
1. Jalankan: diagnose-emulator.bat
2. Baca output diagnostic
3. Ikuti rekomendasi yang muncul
```

### Scenario 4: Error Signature Conflict
```
1. Pastikan emulator running
2. Jalankan: fix-emulator.bat
   (Script akan auto-uninstall app lama)
```

### Scenario 5: Start Emulator Tanpa Android Studio
```
1. Jalankan: start-emulator.bat
2. Tunggu emulator boot
3. Jalankan: fix-emulator.bat
```

---

## ❓ FAQ - Pertanyaan Sering Ditanya

### Q: Kenapa emulator lambat banget?
**A**: 
- First boot memang lambat (2-5 menit) - INI NORMAL!
- Pastikan RAM tersisa minimal 4GB
- Enable hardware acceleration di BIOS (Intel VT-x / AMD-V)
- Gunakan emulator dengan spec lebih rendah

### Q: Device tidak muncul di `adb devices`
**A**: 
1. Jalankan `restart-emulator.bat`
2. Pastikan emulator benar-benar sudah boot lengkap
3. Tunggu sampai melihat home screen Android

### Q: Error "INSTALL_FAILED_UPDATE_INCOMPATIBLE"
**A**: 
Jalankan `fix-emulator.bat` - script akan auto-uninstall app lama

### Q: Emulator tidak bisa start sama sekali
**A**: 
1. Jalankan `diagnose-emulator.bat` untuk lihat masalahnya
2. Coba start manual: `start-emulator.bat`
3. Jika masih gagal, buat emulator baru di Android Studio

### Q: "adb" is not recognized as internal or external command
**A**: 
ADB belum ada di PATH. Solusi:
- Gunakan Android Studio untuk run app (lebih mudah)
- Atau set PATH di environment variables

### Q: Setelah restart Windows, emulator tidak muncul
**A**: 
Ini normal. Jalankan `start-emulator.bat` atau start dari Android Studio

---

## 🎯 TIPS & TRIK

### ✅ DO (Lakukan):
- **Gunakan Quick Boot** setelah first boot (jauh lebih cepat!)
- **Minimize emulator** jika masih akan digunakan, jangan close
- **Keep emulator running** saat develop (hemat waktu)
- **Gunakan Pixel 4/5** untuk balance performa dan akurasi
- **API 30-33** lebih stabil dari API 34-35

### ❌ DON'T (Jangan):
- Jangan close emulator setiap kali selesai testing
- Jangan buka banyak emulator sekaligus (makan RAM)
- Jangan gunakan emulator dengan resolusi terlalu tinggi
- Jangan cold boot tiap kali (gunakan quick boot)

---

## 🔧 Troubleshooting Cepat

| Masalah | Solusi Cepat |
|---------|--------------|
| Emulator hang | `restart-emulator.bat` |
| Signature error | `fix-emulator.bat` |
| Tidak tahu masalahnya | `diagnose-emulator.bat` |
| Emulator tidak bisa start | `start-emulator.bat` |
| Device offline | `restart-emulator.bat` |
| App tidak terinstall | `fix-emulator.bat` |

---

## 📞 Jika Semua Script Gagal

Coba solusi manual:

### 1. Cold Boot Emulator
```
Android Studio > Tools > Device Manager > 
Klik ▼ pada emulator > Cold Boot Now
```

### 2. Wipe Data
```
Android Studio > Tools > Device Manager > 
Klik ▼ pada emulator > Wipe Data
```

### 3. Buat Emulator Baru
```
Android Studio > Tools > Device Manager > 
Create Device > Pilih Pixel 4 > API 30
```

### 4. Gunakan Physical Device
Hubungkan HP Android via USB:
```
1. Enable Developer Options di HP
2. Enable USB Debugging
3. Hubungkan ke komputer
4. Run dari Android Studio
```

---

## 📚 Dokumentasi Lengkap

Baca file: **SOLUSI_EMULATOR.md** untuk panduan detail dan troubleshooting advanced.

---

**Dibuat**: 8 November 2025  
**Update Terakhir**: 8 November 2025  
**Compatible dengan**: Android Studio Arctic Fox atau lebih baru

---

**💡 Pro Tip**: Simpan folder ini di bookmark agar mudah akses script-script ini kapan saja!

