accounting-api: sh -c 'cd apps/accounting && bundle exec rails server -p 5001'
analytics-api: sh -c 'cd apps/analytics && bundle exec rails server -p 5002'
auth-api: sh -c 'cd apps/auth && bundle exec rails server -p 5003'
notifications-api: sh -c 'cd apps/notifications && bundle exec rails server -p 5004'
tasks-api: sh -c 'cd apps/tasks && bundle exec rails server -p 5005'

accounting-consumer: sh -c 'cd apps/accounting && bundle exec karafka server'
analytics-consumer: sh -c 'cd apps/analytics && bundle exec karafka server'
notifications-consumer: sh -c 'cd apps/notifications && bundle exec karafka server'
tasks-consumer: sh -c 'cd apps/tasks && bundle exec karafka server'
