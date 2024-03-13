class Task::Pricify < ApplicationInteraction
  record :task

  def execute
    if task.assign_price.blank? && task.complete_price.blank?
      task.update!(assign_price: rand(10..20), complete_price: rand(20..40))
    end
  end
end