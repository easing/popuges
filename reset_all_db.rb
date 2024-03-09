require "pathname"

base_path = Pathname.new(Dir.pwd)

Dir.glob("apps/*").each do |dir|
  next if /\.+'/.match?(dir)

  puts dir

  Dir.chdir(base_path.join(dir))
  system("rails db:drop db:create db:migrate")
end
