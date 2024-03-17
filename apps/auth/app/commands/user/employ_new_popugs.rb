class User::EmployNewPopugs < ApplicationInteraction

  def execute
    new_popugs = rand(10..30).times.map do |n|
      name = SecureRandom.hex(2)

      {
        name: "Popug #{name}",
        email: "popug-#{name}@easing.ru",
        role: :popug,
        public_id: SecureRandom.uuid,
        created_at: Time.current,
        updated_at: Time.current
      }
    end

    User.insert_all(new_popugs)

    EDA.stream_batch(new_popugs.map { |u| User::Registered.new(u) })
  end
end