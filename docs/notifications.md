# Уведомления (Notifications)

`/notifications`

Все виды уведомлений системы

## Область ответственности

- Подготовка уведомлений

- Отправка уведомлений в службы доставки**

## Команды

- **Создать уведомление**

## Производит события

  - Бизнес-события
    - `NotificationCreated` — создано уведомление

  - Синхронизация данных
    - —

## Потребляет события
  - Бизнес-события
    - `WageCalculated` — зарплата рассчитана
  - Синхронизация данных
    - —

## Модель данных

### User
- id: UUID
- name: String
- email: String[required, unique]
- role: enum\<`Admin`|`Accountant`|`Manager`|`Popug`>
- created\_at: DateTime
- updated\_at: DateTime
- version: Integer

### Notification
- event_name: enum\<`WageCalculated`|`RoleChanged`>
- target: User
- data: JSON
- created\_at: DateTime
- updated\_at: DateTime
- version: Integer 

## Пользовательский интерфейс

### Страницы
- Список уведомлений
  - Пользователи с ролью `Admin` видят все уведомления
  - Остальные пользователи видят только свои уведомления
* Карточка уведомления
