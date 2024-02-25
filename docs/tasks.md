# Задачник (Tasks)

`/tasks`

Таск-трекер компании

## Область ответственности

Создание, редактирование и распределение задач

## Команды

- **Создать задачу**
  - при создании задачи на неё назначается случайный пользователь с ролью Popug
- **Назначить задачи**
  - при запуске команды все невыполненные задачи случайным образом распределяются между пользователями с ролью «Попуг»
- **Выполнить задачу**
  - задача отмечается выполненной

## Производит события

- Бизнес-события
  - `TaskCreated`
  - `TaskAssigned`
  - `TaskCompleted`

- Синхронизация данных

## Потребляет события

- Бизнес-события
  - `UserRoleChanged`

- Синхронизация данных
  - `UserCreated`
  - `UserUpdated`

## Модель данных

### User
- id: UUID
- name: String
- email: String[required, unique]
- role: enum\<`Admin`|`Accountant`|`Manager`|`Popug`>
- created\_at: DateTime
- updated\_at: DateTime
- version: Integer 

### Task 
- id: UUID
- subject: String
- assigned\_to: User
- completed\_at: DateTime
- created\_at: DateTime
- updated\_at: DateTime
- version: Integer 

## Пользовательский интерфейс

### Страницы

- Список задач
- Создать задачу
- Карточка задачи
- Редактирование задачи
