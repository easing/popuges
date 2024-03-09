# Задачник (Tasks)

`/tasks`

Таск-трекер компании

## Область ответственности

Создание, редактирование и распределение задач

## Команды

- **Создать задачу**
  - **при создании задачи** на неё назначается случайный пользователь с ролью `popug`
- **Назначить задачи**
  - **при запуске команды** все невыполненные задачи случайным образом распределяются между пользователями с ролью `popug`
- **Выполнить задачу**
  - задача отмечается выполненной

## Производит события

- Бизнес-события
  - `TaskAdded`
  - `TaskAssigned`
  - `TaskCompleted`

- Синхронизация данных
  - `TaskCreated`
  - `TaskUpdated`

## Потребляет события

- Бизнес-события
  - `UserRegistered`
  - `UserRoleChanged`

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

### Task 
- id: UUID
- subject: String
- assigned\_to: User
- completed\_at: DateTime
- created\_at: DateTime
- updated\_at: DateTime

## Пользовательский интерфейс

### Страницы

- Список задач
- Создать задачу
- Карточка задачи
- Редактирование задачи
