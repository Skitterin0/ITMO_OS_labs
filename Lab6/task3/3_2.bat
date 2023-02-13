net stop Dnscache
timeout  5
net start > C:\LAB6\3\services2.txt
call "C:\LAB6\3\3_3.bat"
net start Dnscache
