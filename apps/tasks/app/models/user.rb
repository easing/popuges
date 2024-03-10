# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  role       :string
#  public_id  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  include UserConcern

  has_many :tasks, inverse_of: :assignee, dependent: :restrict_with_exception

  def has_no_tasks?
    tasks.not_completed.empty?
  end
end
