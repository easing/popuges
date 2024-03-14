# Analytics

`/analytics`

Аналитика работы компании

## Область ответственности

Аггрегация бизнес-метрик и подготовка отчётов о работе компании

## Команды

- **Обновить статистику**
  - Актуализирует сегодняшнюю статистику

## Производит события

## Потребляет события

  - Бизнес-события
    - `User::BalanceUpdated`

  - Синхронизация данных
    - `User::Created`
    - `User::Updated`
    - `Task::Created`
    - `Task::Updated`

## Модель данных

### User

- id: UUID
- name: String
- role: enum\<`admin`|`accountant`|`manager`|`popug`|`guest`>
- created\_at: DateTime
- updated\_at: DateTime

### UserStats

- id: UUID
- user: User
- day: Date
- balance: Money
- created\_at: DateTime
- updated\_at: DateTime

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
