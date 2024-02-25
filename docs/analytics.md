# Analytics

`/analytics`

Аналитика работы компании

## Область ответственности

Аггрегация бизнес-метрик и подготовка отчётов о работе компании

## Команды

- **Обновить статистику**
  - Актуализирует сегодняшнюю статистику

## Производит события

  - Бизнес-события
    - —

  - Синхронизация данных
    - —

## Потребляет события

  - Бизнес-события
    - `BalanceUpdated`
    - `WageCalculated`

  - Синхронизация данных
    - —

## Модель данных

### User

- id: UUID
- name: String
- role: String
- created\_at: DateTime
- updated\_at: DateTime
- version: Integer 

### UserStats

- id: UUID
- user: User
- day: Date
- wage: Money
- created\_at: DateTime
- updated\_at: DateTime
- version: Integer 

### CompanyStats
- id: UUID
- day: Date
- profit: Money
- created\_at: DateTime
- updated\_at: DateTime
- version: Integer 

## Пользовательский интерфейс

### Страницы

- Список дней с рассчитанной статистикой
- Дашборд с метриками за один день
