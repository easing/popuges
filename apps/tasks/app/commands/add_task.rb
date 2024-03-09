class AddTask < ApplicationInteraction
  string :subject, default: -> { SecureRandom.hex }
  record :user, default: nil

  def execute
    assignee = user if user&.role_popug?
    assignee ||= random_popug

    return errors.add(:base, "Всех людей пожрал долгоносик, милорд. Некому делать задачи") unless assignee

    task = Task.create!(subject: subject, assignee: assignee)
    task
  end

  private

  def random_popug
    User.role_popug.reorder(Arel.sql("RANDOM()")).first
  end
end