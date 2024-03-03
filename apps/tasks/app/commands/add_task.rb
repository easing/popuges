class AddTask < ApplicationInteraction
  string :subject, default: -> { SecureRandom.hex }

  def execute
    user = random_popug || transform_random_user_to_popug

    return errors.add(:base, "Всех людей пожрал долгоносик, милорд. Некому делать задачи") unless user

    task = Task.create!(subject: subject, assigned_to: user)
    stream TaskAdded, task if task.persisted?
  end

  private

  def random_popug
    User.role_popug.reorder(Arel.sql("RANDOM()")).first
  end

  # @return [User|nil]
  def transform_random_user_to_popug
    user = User.reorder(Arel.sql("RANDOM()")).first
    user.update!(role: User.roles[:popug])
  end
end