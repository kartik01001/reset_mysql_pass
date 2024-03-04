cd c:\
echo ALTER USER 'root'@'localhost' IDENTIFIED BY '1234'; > reset.txt
cd C:\Program Files\MySQL\MySQL Server*\bin
net stop MySQL83

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
net start MySQL83
cd c:\
del reset.txt
