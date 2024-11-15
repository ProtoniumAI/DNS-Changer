@echo off
setlocal enabledelayedexpansion
title Simple DNS Changer
mode con: cols=100 lines=50
color 0F

:menu
cls
echo.
echo.
echo                  ================================================
echo                  =            Simple DNS Changer                =
echo                  ================================================
echo.
echo.
echo                         Available DNS Providers
echo                         ---------------------
echo.
echo                         [1] Google DNS
echo                             8.8.8.8, 8.8.4.4
echo                             Fast, reliable, global coverage
echo.
echo                         [2] Cloudflare
echo                             1.1.1.1, 1.0.0.1  
echo                             Privacy-focused, ultra fast
echo.
echo                         [3] OpenDNS
echo                             208.67.222.222, 208.67.220.220
echo                             Security and content filtering
echo.
echo                         [4] Quad9
echo                             9.9.9.9, 149.112.112.112
echo                             Threat blocking, privacy protection
echo.
echo                         [5] AdGuard DNS
echo                             94.140.14.14, 94.140.15.15
echo                             Ad and tracker blocking
echo.
echo                         [6] Level3 DNS
echo                             4.2.2.1, 4.2.2.2
echo                             Enterprise-grade reliability
echo.
echo                         [7] Comodo Secure DNS
echo                             8.26.56.26, 8.20.247.20
echo                             Security-enhanced filtering
echo.
echo                         Commands
echo                         --------
echo                         [R] Reset to Default DNS
echo                         [X] Exit
echo.
echo.

set /p choice="                         Select an option > "

if "%choice%"=="1" (
    echo.
    echo                  ================================================
    echo                  =               Google DNS Selected            =
    echo                  ================================================
    echo.
    echo                         Primary DNS:   8.8.8.8
    echo                         Secondary DNS: 8.8.4.4
    echo.
    echo                         Benefits:
    echo                         - Industry-leading reliability and uptime
    echo                         - Protection against DNS spoofing attacks
    echo                         - Optimized for streaming services
    echo                         - Global server coverage for fast access
    set "primary=8.8.8.8"
    set "secondary=8.8.4.4"
    goto :change_dns
) else if "%choice%"=="2" (
    echo.
    echo                  ================================================
    echo                  =             Cloudflare DNS Selected         =
    echo                  ================================================
    echo.
    echo                         Primary DNS:   1.1.1.1
    echo                         Secondary DNS: 1.0.0.1
    echo.
    echo                         Benefits:
    echo                         - Fastest public DNS resolver available
    echo                         - Built-in DNSSEC validation
    echo                         - No query logging or data selling
    echo                         - Supports DNS over HTTPS/TLS
    set "primary=1.1.1.1"
    set "secondary=1.0.0.1"
    goto :change_dns
) else if "%choice%"=="3" (
    echo.
    echo                  ================================================
    echo                  =              OpenDNS Selected              =
    echo                  ================================================
    echo.
    echo                         Primary DNS:   208.67.222.222
    echo                         Secondary DNS: 208.67.220.220
    echo.
    echo                         Benefits:
    echo                         - Advanced web content filtering
    echo                         - Phishing and botnet protection
    echo                         - Detailed network statistics
    echo                         - Customizable security settings
    set "primary=208.67.222.222"
    set "secondary=208.67.220.220"
    goto :change_dns
) else if "%choice%"=="4" (
    echo.
    echo                  ================================================
    echo                  =               Quad9 Selected               =
    echo                  ================================================
    echo.
    echo                         Primary DNS:   9.9.9.9
    echo                         Secondary DNS: 149.112.112.112
    echo.
    echo                         Benefits:
    echo                         - Automatic malicious domain blocking
    echo                         - Strong privacy protection policies
    echo                         - Built-in DNSSEC validation
    echo                         - No personal data collection
    set "primary=9.9.9.9"
    set "secondary=149.112.112.112"
    goto :change_dns
) else if "%choice%"=="5" (
    echo.
    echo                  ================================================
    echo                  =             AdGuard DNS Selected           =
    echo                  ================================================
    echo.
    echo                         Primary DNS:   94.140.14.14
    echo                         Secondary DNS: 94.140.15.15
    echo.
    echo                         Benefits:
    echo                         - Blocks ads at DNS level
    echo                         - Prevents tracking and analytics
    echo                         - Family protection features
    echo                         - No DNS query logging
    set "primary=94.140.14.14"
    set "secondary=94.140.15.15"
    goto :change_dns
) else if "%choice%"=="6" (
    echo.
    echo                  ================================================
    echo                  =             Level3 DNS Selected            =
    echo                  ================================================
    echo.
    echo                         Primary DNS:   4.2.2.1
    echo                         Secondary DNS: 4.2.2.2
    echo.
    echo                         Benefits:
    echo                         - Enterprise-grade infrastructure
    echo                         - Minimal DNS filtering
    echo                         - High-performance resolution
    echo                         - Global network presence
    set "primary=4.2.2.1"
    set "secondary=4.2.2.2"
    goto :change_dns
) else if "%choice%"=="7" (
    echo.
    echo                  ================================================
    echo                  =           Comodo Secure DNS Selected       =
    echo                  ================================================
    echo.
    echo                         Primary DNS:   8.26.56.26
    echo                         Secondary DNS: 8.20.247.20
    echo.
    echo                         Benefits:
    echo                         - Real-time malware domain blocking
    echo                         - Worldwide server infrastructure
    echo                         - Domain filtering and protection
    echo                         - Fast response times
    set "primary=8.26.56.26"
    set "secondary=8.20.247.20"
    goto :change_dns
) else if /i "%choice%"=="r" (
    goto :reset_dns
) else if /i "%choice%"=="x" (
    goto :end
) else (
    echo                         Invalid option. Please try again.
    timeout /t 2 >nul
    goto :menu
)

:change_dns
echo.
echo                         Applying new DNS settings...

for /f "tokens=1,2 delims=:" %%a in ('ipconfig ^| find "Ethernet" /i') do (
    set "adapter=%%a"
    netsh interface ip set dns name="!adapter!" static %primary% primary >nul 2>&1
    netsh interface ip add dns name="!adapter!" %secondary% index=2 >nul 2>&1
    echo                         Updated !adapter!
)

for /f "tokens=1,2 delims=:" %%a in ('ipconfig ^| find "Wi-Fi" /i') do (
    set "adapter=%%a"
    netsh interface ip set dns name="!adapter!" static %primary% primary >nul 2>&1
    netsh interface ip add dns name="!adapter!" %secondary% index=2 >nul 2>&1
    echo                         Updated !adapter!
)

ipconfig /flushdns >nul 2>&1
echo                         DNS cache cleared
echo.
pause
goto :menu

:reset_dns
echo.
echo                         Resetting to default DNS...

for /f "tokens=1,2 delims=:" %%a in ('ipconfig ^| find "Ethernet" /i') do (
    set "adapter=%%a"
    netsh interface ip set dns name="!adapter!" dhcp >nul 2>&1
    echo                         Reset !adapter!
)

for /f "tokens=1,2 delims=:" %%a in ('ipconfig ^| find "Wi-Fi" /i') do (
    set "adapter=%%a"
    netsh interface ip set dns name="!adapter!" dhcp >nul 2>&1
    echo                         Reset !adapter!
)

ipconfig /flushdns >nul 2>&1
echo                         DNS cache cleared
echo.
pause
goto :menu

:end
echo.
echo                         Thanks for using Simple DNS Changer
timeout /t 1 >nul
exit /b 0