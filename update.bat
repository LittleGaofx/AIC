@echo off

set fv=20
set /p lv=������汾�ţ�

:Run
set n=%random%
cd "%userprofile%\AppData\Local\Programs"
md temp%n%
if not exist "Clash for Windows" md "Clash for Windows"

@rem ����powershell���ظ��°�
powershell (new-object System.Net.WebClient).DownloadFile('https://github.com/Fndroid/clash_for_windows_pkg/releases/download/0.%fv%.%lv%/Clash.for.Windows-0.%fv%.%lv%-win.7z','temp%n%\Clash_0.%fv%.%lv%.7z')>NUL 2>NUL
powershell (new-object System.Net.WebClient).DownloadFile('https://github.com/BoyceLig/Clash_Chinese_Patch/releases/download/0.%fv%.%lv%/app.7z','temp%n%\Patch_0.%fv%.%lv%.7z')>NUL 2>NUL
cd temp%n%
if not exist Clash_0.%fv%.%lv%.7z goto DLF
if not exist Patch_0.%fv%.%lv%.7z goto PatchDLF

@rem ����7z��ѹ
7z x Clash_0.%fv%.%lv%.7z
7z x Patch_0.%fv%.%lv%.7z
if not exist "Clash for Windows.exe" goto ExtF
if not exist "app.asar" goto ExtF

@rem Ӧ�����Ĳ���
move /Y locales\zh-CN.pak zh-CN.pak
del /f /s /q locales\*
move zh-CN.pak locales\
move /Y app.asar resources\app.asar

@rem Ӧ�ø���
:apply
del /f /s /q LICENSE.electron.txt
del /f /s /q LICENSES.chromium.html
cd..
copy "Clash for Windows\update.bat" "temp%n%\update.bat"
taskkill /f /im "Clash for Windows.exe"
timeout /t 3
del /f /s /q "Clash for Windows\*.json"
del /f /s /q "Clash for Windows\*.dll"
del /f /s /q "Clash for Windows\*.exe"
del /f /s /q "Clash for Windows\*.dat"
del /f /s /q "Clash for Windows\*.pak"
del /f /s /q "Clash for Windows\*.bin"
del /f /s /q "Clash for Windows\*.json"
rd /s /q "Clash for Windows\resources"
timeout /t 1
xcopy /E /Y "temp%n%" "Clash for Windows"
del "Clash for Windows\Clash_0.%fv%.%lv%.7z"
del "Clash for Windows\Patch_0.%fv%.%lv%.7z"
explorer "Clash for Windows\Clash for Windows.exe"
rd /s /q temp%n%
cls&echo.&echo ���³ɹ�&echo.
pause>NUL 2>NUL
exit


:DLF
echo.&echo ����ʧ�ܣ������������ӻ�ȷ����ȷ����汾��
cd..
rd /s /q temp%n%
pause>NUL 2>NUL
exit

:PatchDLF
echo.&set /p sl=���غ�������ʧ�ܣ��Ƿ������(Y/N)
if sl==Y goto apply
if sl==N exit
exit

:ExtF
echo.&echo ��ѹʧ��
cd..
rd /s /q temp%n%
pause>NUL 2>NUL
exit