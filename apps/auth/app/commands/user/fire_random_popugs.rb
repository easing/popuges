class User::FireRandomPopugs < ApplicationInteraction
  def execute
    limit = User.role_popug.count
    limit = limit > 20 ? (limit / 2) : rand(1..5)

    users_to_fire = User.role_popug.order("random()").limit(limit)
    users_to_fire.each do |u|
      u.update!(role: :guest)
    end

    users_to_fire
  end
end