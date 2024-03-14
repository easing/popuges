# Уведомления (Notifications)

`/notifications`

Все виды уведомлений системы

## Область ответственности

- Подготовка уведомлений
- Отправка уведомлений в службы доставки**

## Команды

- **Создать уведомление**

## Потребляет события
  - Бизнес-события
    - `User::BalanceChanged` — изменился баланс пользователя 
  - Синхронизация данных 
    - `Task::Created` — добавлена задача
    - `Tasl::Updated` — обновилась задача

## Модель данных

### User
- id: UUID
- name: String
- email: String[required, unique]
- role: enum\<`admin`|`accountant`|`manager`|`popug`|`guest`>
- created\_at: DateTime
- updated\_at: DateTime

### Notification
- event_name: enum\<`WageCalculated`|`RoleChanged`>
- target: User
- data: JSON
- created\_at: DateTime
- updated\_at: DateTime

## Пользовательский интерфейс

### Страницы
- Список уведомлений
  - Пользователи с ролью `admin` видят все уведомления
  - Остальные пользователи видят только свои уведомления
- Карточка уведомления
