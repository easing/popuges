# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :uuid             not null, primary key
#  name       :string           default(""), not null
#  role       :string           default(NULL), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  include UserConcern

  has_many :tasks, foreign_key: :assignee_id

  def has_no_tasks?
    tasks.not_completed.empty?
  end
end
