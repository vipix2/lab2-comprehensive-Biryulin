@echo off
chcp 65001 >nul
title Система моделирования процессов разработки ПО

rem ============================================================
rem  Главный файл: объединяет модули chapter1.bat, chapter2.bat, chapter3.bat
rem  Модули запускаются командой call в том же окне, поэтому их результаты
rem  (переменные lab_rec, lab_level, lab_winner) доступны главному файлу.
rem ============================================================

rem --- Значения по умолчанию, пока модули не пройдены ---
set "lab_rec=не определена"
set "lab_level=не определён"
set "lab_winner=не определён"

:menu
cls
echo ========================================
echo   СИСТЕМА МОДЕЛИРОВАНИЯ ПРОЦЕССОВ РАЗРАБОТКИ ПО
echo   Вариант 4: выбор облачной платформы для стартапа
echo ========================================
echo.
echo 1. Модуль выбора технологий
echo 2. Модуль инспекции кода
echo 3. Модуль сравнительного анализа
echo 4. Запустить все модули последовательно
echo 5. Выход
echo.
set "menu_choice="
set /p "menu_choice=Ваш выбор: "

if "%menu_choice%"=="1" goto :run1
if "%menu_choice%"=="2" goto :run2
if "%menu_choice%"=="3" goto :run3
if "%menu_choice%"=="4" goto :run_all
if "%menu_choice%"=="5" goto :quit

echo.
echo Неверный выбор. Введите число от 1 до 5.
pause
goto :menu

:run1
call "%~dp0chapter1.bat"
goto :menu

:run2
call "%~dp0chapter2.bat"
goto :menu

:run3
call "%~dp0chapter3.bat"
goto :menu

rem ------------------------------------------------------------
rem  Пункт 4: все модули подряд, затем итоговый отчёт и report.txt
rem ------------------------------------------------------------
:run_all
set "lab_rec=не определена"
set "lab_level=не определён"
set "lab_winner=не определён"
call "%~dp0chapter1.bat"
call "%~dp0chapter2.bat"
call "%~dp0chapter3.bat"

rem --- Сравниваем результаты модуля 1 и модуля 3 ---
set "lab_note=Результаты модулей 1 и 3 расходятся - стоит обсудить выбор в команде."
if "%lab_rec%"=="%lab_winner%" set "lab_note=Результаты модулей 1 и 3 совпадают - выбор платформы подтверждён."

cls
echo ========================================
echo   ИТОГОВЫЙ ОТЧЁТ СИСТЕМЫ
echo ========================================
echo Все модули пройдены.
echo.
echo Модуль 1: рекомендация по технологии - %lab_rec%
echo Модуль 2: уровень ревьюера - %lab_level% Reviewer, верных ответов %lab_correct% из %lab_total%, точность %lab_accuracy%%%
echo Модуль 3: победитель сравнительного анализа - %lab_winner%
echo.
echo %lab_note%
echo.

rem --- Сохраняем отчёт в report.txt в той же папке ---
(
    echo ========================================
    echo   ИТОГОВЫЙ ОТЧЁТ СИСТЕМЫ
    echo   Вариант 4: выбор облачной платформы для стартапа
    echo ========================================
    echo Дата и время: %date% %time%
    echo.
    echo Модуль 1. Рекомендация по технологии: %lab_rec%
    echo Модуль 2. Уровень ревьюера: %lab_level% Reviewer
    echo           Правильных ответов: %lab_correct% из %lab_total%, точность %lab_accuracy%%%
    echo Модуль 3. Победитель сравнительного анализа: %lab_winner%
    echo.
    echo %lab_note%
) > "%~dp0report.txt"

echo Результаты сохранены в report.txt
echo.
pause
goto :menu

:quit
exit /b 0
