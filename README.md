# Домашнее задание к занятию 3 «Резервное копирование» - Мельник Юрий Александрович


## Задание 1


1. `Составьте команду rsync, которая позволяет создавать зеркальную копию домашней директории пользователя в директорию /tmp/backup`
2. `Необходимо исключить из синхронизации все директории, начинающиеся с точки (скрытые)`
3. `Необходимо сделать так, чтобы rsync подсчитывал хэш-суммы для всех файлов, даже если их время модификации и размер идентичны в источнике и приемнике`
4. `На проверку направить скриншот с командой и результатом ее выполнения`

 
## Решение 1
1. `Установим пакет rsync`  
![alt text](https://github.com/ysatii/backup/blob/main/img/image1.jpg)  

2. `команда и ее опции`  
```
rsync -ac --delete --exclude=".*/" . /tmp/backup --progress -v
```
-c - Проверка контрольных сумм для файлов;  
-a - Режим архивирования, когда сохраняются все атрибуты оригинальных файлов;  
--delete - Удалять файлы которых нет в источнике;  
--exclude - Исключить файлы по шаблону;  
--progress - Выводить прогресс передачи файла;  
-v - Выводить подробную информацию о процессе копирования;  

результат применения команды
![alt text](https://github.com/ysatii/backup/blob/main/img/image1_1.jpg)  

сравнение каталогов, нагляднее в утилите "MC"
![alt text](https://github.com/ysatii/backup/blob/main/img/image1_2.jpg) 

еще раз запустим скрипт 
```
rsync -ac --delete --exclude=".*/" . /tmp/backup --progress -v
```
передачи данных нет, файлы не изменялись!
![alt text](https://github.com/ysatii/backup/blob/main/img/image1_3.jpg) 

Данный файл содержиться в домашней директории, попробум зменить пару символов не изменяя общей длины  файла
и снова выполним синхронизацию 

видим что изменился только один файл!
![alt text](https://github.com/ysatii/backup/blob/main/img/image1_4.jpg) 
 

 
## Задание 2
1. `Написать скрипт и настроить задачу на регулярное резервное копирование домашней директории пользователя с помощью rsync и cron.` 
2. `Резервная копия должна быть полностью зеркальной`
3. `Резервная копия должна создаваться раз в день, в системном логе должна появляться запись об успешном или неуспешном выполнении операции`
4. `Резервная копия размещается локально, в директории /tmp/backup`
5. `На проверку направить файл crontab и скриншот с результатом работы утилиты.`
  
 



## Решение 2

1. `Создадим скрипт для выполнения задания`  
```
#!/bin/bash
if [[ $(rsync -ac --delete . /tmp/backup --progress -v) ]]  ; then
        $(logger success backup script.sh)
else
        $(logger error backup script.sh)
fi
```

в случании успеха получим в системном логе запись "logger success backup script.sh"  
В случаи проблем при выполнении получим ошибку "logger error backup script.sh"  

2. `Запустим скриптт и пострим системный лог`  
![alt text](https://github.com/ysatii/backup/blob/main/img/image2.jpg)   
скрипт отработал успешно   

посмотрим содержимое домашнего каталога и каталога с копией  
![alt text](https://github.com/ysatii/backup/blob/main/img/image2_1.jpg)   

2. `Cron`  
Редакириуем задание Cron и задаем путь до скрипта  
![alt text](https://github.com/ysatii/backup/blob/main/img/image2_2.jpg)   

Убеждаемся что задание присутвиет в списке Cron  
![alt text](https://github.com/ysatii/backup/blob/main/img/image2_3.jpg)   

Убеждаемся что файлы скопированы  
![alt text](https://github.com/ysatii/backup/blob/main/img/image2_3.jpg)   

3. `Cron файл `  
[файл cron](https://github.com/ysatii/backup/blob/main/crontabs/lamer)

