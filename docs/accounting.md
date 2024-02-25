# Бухгалтерия (Accounting)

`/accounting`

Биллинг рабочих процессов

## Область ответственности

- Определение стоимости задач

- Расчёт зарплаты/прибыли компании

## Команды

- **Оценить задачу**

  - Задаче назначается два вида стоимости:

    - стоимость ассайна \[rand(10..20)] — списывается с ответственного за задачу

    - стоимость выполнения \[rand(20..40)] — начисляется ответственному

- **Обновить баланс пользователя**

  - Баланс пользователя обновляется 

    - **при назначении задачи** на пользователя или (списываются средства) 

    - **при выполнении задачи**, назначенной на пользователя (начисляются средства)

- **Рассчитать зарплату**

  - Если пользователь к моменту расчёта (за рабочий день) заработал больше нуля, «обнуляем» его баланс и выплачиваем зарплату. 
  - Если к концу рабочего дня баланс пользователя отрицательный, оставляем баланс как есть и ничего не выплачиваем.

## Производит события

  - Бизнес-события

    - `TaskPriced` — задача оценена

    - `BalanceUpdated` — баланс пользователя обновлён

    - `WageCalculated` — зарплата пользователя рассчитана

  - Синхронизация данных    

## Потребляет события

  - Бизнес-события

    - `TaskCreated` — задача создана

    - `TaskAssigned` — задача назначена

    - `TaskCompleted` — задача выполнена

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
- created\_by: User
- assigned\_to: User
- created\_at: DateTime
- updated\_at: DateTime
- version: Integer 

### TaskPrice

- id: UUID
- task: Task
- assign\_price: Money (10..20)
- complete\_price: Money (20..40)
- created\_at: DateTime
- updated\_at: DateTime
- version: Integer 

### Transaction

- id: UUID
- amount: Money (−Inf..+Inf)
- user: User
- event_name: \<TaskAssigned|TaskCompleted|WageCalculated>
- source_type: \<Task|Wage>
- source_id: UUID
- created\_at: DateTime
- updated\_at: DateTime
- version: Integer 

### Wage

- id: UUID
- user: User
- day: Date
- amount: Money (>= 0)**
- created\_at: DateTime
- updated\_at: DateTime
- version: Integer 

## Пользовательский интерфейс

### Страницы

- Дашборд

  - Показывает прибыль компании за один день

    - Сумма _стоимостей назначения_ всех задач за день минус сумма _стоимостей выполнения_ всех закрытых за день задач: \
      sum(assigned task fee) - sum(completed task amount))

- Список транзакций

  - Пользователям с ролью «Попуг» показываются только их транзакции

  - Администраторы, менеджеры, бухгалтеры видят все транзакции

--------------------------------------------------------------
