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
    - —
  - Синхронизация данных
    - `NotificationCreated` — создано уведомление

## Потребляет события
  - Бизнес-события
    - `WageCalculated` — зарплата рассчитана
    - `TaskAdded` — добавлена задача
    - `TaskAssigned` — назначена задача
  - Синхронизация данных 
    - —  

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
