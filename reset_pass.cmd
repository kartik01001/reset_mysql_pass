@echo off
title MySQL Server Password Reset
cd c:\
set /p userInput="Enter new password: "
echo ALTER USER 'root'@'localhost' IDENTIFIED BY '%userInput%'; > reset.txt
cd C:\Program Files\MySQL\MySQL Server*\bin

set "service_name="
for /f "tokens=2 delims=: " %%s in ('sc query state^= all ^| find "MySQL"') do (
    if "%%s" neq "MySQL" (
        set "service_name=%%s"
        goto :found1
    )
)
echo Error: MySQL service not found.
exit /b 1

:found1
net stop "%service_name%"

set "mysql_ini="
for /D %%d in ("C:\ProgramData\MySQL\MySQL Server *") do (
    if exist "%%d\my.ini" (
        set "mysql_ini=%%d\my.ini"
        goto :found
    )
)
echo Error: MySQL configuration file not found.
exit /b 1

:found
start mysqld.exe --defaults-file="%mysql_ini%" --init-file=C:\reset.txt

timeout 5 > NUL

taskkill/im mysqld.exe /F
net start "%service_name%"
cd c:\
del reset.txt
