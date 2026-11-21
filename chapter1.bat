@echo off
chcp 65001 >nul
title Модуль 1 - Выбор облачной платформы
cls

rem ============================================================
rem  Модуль 1. Моделирование процесса выбора технологии
rem  Вариант 4: выбор облачной платформы для стартапа
rem  Кандидаты: Yandex Cloud, Selectel, Timeweb Cloud
rem  Контекст: MVP веб-приложения с прогнозируемым ростом нагрузки
rem ============================================================

rem --- Обнуляем баллы кандидатов (yc = Yandex Cloud, sel = Selectel, tw = Timeweb Cloud) ---
set /a score_yc=0
set /a score_sel=0
set /a score_tw=0
set "lab_rec="

echo ============================================
echo   МОДУЛЬ 1. ВЫБОР ОБЛАЧНОЙ ПЛАТФОРМЫ
echo ============================================
echo Ответьте на 5 вопросов о вашем проекте.
echo.

rem ------------------------------------------------------------
rem  Вопрос 1. Масштаб проекта и рост нагрузки
rem ------------------------------------------------------------
echo Вопрос 1 из 5: Какой масштаб нагрузки вы ожидаете?
echo   1. Небольшой: до нескольких сотен пользователей, плавный рост
echo   2. Средний: тысячи пользователей, предсказуемый рост в 5-10 раз за год
echo   3. Крупный: резкие пики нагрузки, нужно автоматическое масштабирование
choice /c 123 /n /m "Ваш выбор (1-3): "
set ans=%errorlevel%
set profile_scale=%ans%
if %ans%==1 (
    set /a score_tw+=10
    set /a score_sel+=5
    set /a score_yc+=3
)
if %ans%==2 (
    set /a score_sel+=10
    set /a score_yc+=10
    set /a score_tw+=4
)
if %ans%==3 (
    set /a score_yc+=15
    set /a score_sel+=6
)
echo.

rem ------------------------------------------------------------
rem  Вопрос 2. Бюджет
rem ------------------------------------------------------------
echo Вопрос 2 из 5: Какой бюджет на инфраструктуру в месяц?
echo   1. Минимальный: до 5 000 руб.
echo   2. Средний: от 5 000 до 30 000 руб.
echo   3. Свободный, либо есть грант или стартовые кредиты облака
choice /c 123 /n /m "Ваш выбор (1-3): "
set ans=%errorlevel%
set profile_budget=%ans%
if %ans%==1 (
    set /a score_tw+=15
    set /a score_sel+=4
    set /a score_yc+=2
)
if %ans%==2 (
    set /a score_sel+=10
    set /a score_tw+=8
    set /a score_yc+=6
)
if %ans%==3 (
    set /a score_yc+=15
    set /a score_sel+=7
    set /a score_tw+=3
)
echo.

rem ------------------------------------------------------------
rem  Вопрос 3. Сроки запуска MVP
rem ------------------------------------------------------------
echo Вопрос 3 из 5: Какие сроки запуска MVP?
echo   1. Срочно: в течение недели
echo   2. В течение 1-2 месяцев
echo   3. Сроки не ограничены, важна продуманная архитектура
choice /c 123 /n /m "Ваш выбор (1-3): "
set ans=%errorlevel%
set profile_time=%ans%
if %ans%==1 (
    set /a score_tw+=10
    set /a score_yc+=5
    set /a score_sel+=3
)
if %ans%==2 (
    set /a score_yc+=10
    set /a score_sel+=8
    set /a score_tw+=5
)
if %ans%==3 (
    set /a score_sel+=10
    set /a score_yc+=8
    set /a score_tw+=2
)
echo.

rem ------------------------------------------------------------
rem  Вопрос 4. Квалификация команды
rem ------------------------------------------------------------
echo Вопрос 4 из 5: Какая квалификация команды в администрировании?
echo   1. DevOps-инженера нет, нужен максимально простой интерфейс
echo   2. Есть базовый опыт администрирования Linux-серверов
echo   3. Есть DevOps-опыт: Kubernetes, Terraform, CI/CD
choice /c 123 /n /m "Ваш выбор (1-3): "
set ans=%errorlevel%
set profile_team=%ans%
if %ans%==1 (
    set /a score_tw+=15
    set /a score_yc+=5
    set /a score_sel+=3
)
if %ans%==2 (
    set /a score_sel+=10
    set /a score_yc+=8
    set /a score_tw+=8
)
if %ans%==3 (
    set /a score_yc+=15
    set /a score_sel+=12
    set /a score_tw+=2
)
echo.

rem ------------------------------------------------------------
rem  Вопрос 5. Потребность в управляемых сервисах
rem ------------------------------------------------------------
echo Вопрос 5 из 5: Что нужно от платформы по сервисам?
echo   1. Управляемые БД, очереди сообщений, мониторинг из коробки
echo   2. Достаточно виртуальных серверов с ручной настройкой
echo   3. Гибкая инфраструктура, включая выделенные серверы
choice /c 123 /n /m "Ваш выбор (1-3): "
set ans=%errorlevel%
set profile_services=%ans%
if %ans%==1 (
    set /a score_yc+=15
    set /a score_sel+=6
    set /a score_tw+=3
)
if %ans%==2 (
    set /a score_tw+=10
    set /a score_sel+=5
)
if %ans%==3 (
    set /a score_sel+=15
    set /a score_yc+=5
)
echo.

rem ------------------------------------------------------------
rem  Определяем рекомендацию: побеждает платформа с максимумом баллов.
rem  При равенстве приоритет: Yandex Cloud, затем Selectel, затем Timeweb Cloud.
rem ------------------------------------------------------------
set "lab_rec=Yandex Cloud"
set /a best=score_yc
if %score_sel% gtr %best% (
    set "lab_rec=Selectel"
    set /a best=score_sel
)
if %score_tw% gtr %best% (
    set "lab_rec=Timeweb Cloud"
    set /a best=score_tw
)

echo ============================================
echo   РЕЗУЛЬТАТ
echo ============================================
echo Профиль проекта (номера выбранных ответов):
echo   масштаб=%profile_scale%, бюджет=%profile_budget%, сроки=%profile_time%, команда=%profile_team%, сервисы=%profile_services%
echo.
echo Набранные баллы:
echo   Yandex Cloud   - %score_yc%
echo   Selectel       - %score_sel%
echo   Timeweb Cloud  - %score_tw%
echo.
echo Рекомендация: %lab_rec%
echo.

if "%lab_rec%"=="Yandex Cloud" echo Почему: богатый набор управляемых сервисов и автомасштабирование подходят для растущей нагрузки.
if "%lab_rec%"=="Selectel" echo Почему: гибкая инфраструктура и баланс цены и возможностей подходят для предсказуемого роста.
if "%lab_rec%"=="Timeweb Cloud" echo Почему: низкая цена и простота запуска идеальны для быстрого старта MVP.
echo.

pause
exit /b 0
