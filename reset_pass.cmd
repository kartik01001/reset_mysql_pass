cd c:\
echo ALTER USER 'root'@'localhost' IDENTIFIED BY '1234'; > reset.txt
cd C:\Program Files\MySQL\MySQL Server 8.3\bin
net stop MySQL83
start mysqld --defaults-file="C:\\ProgramData\\MySQL\\MySQL Server 8.3\\my.ini" --init-file=C:\reset.txt

timeout 5 > NUL

taskkill/im mysqld.exe /F
net start MySQL83
cd c:\
del reset.txt