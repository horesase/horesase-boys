task :default => :build

desc "Build boys.json"
task :build do
  require "yaml"
  require "json"

  result = Dir["data/*"].map do |path|
    data = YAML.load_file(path)
    body_path = File.join("body", File.basename(path, ".yml") + ".txt")
    body = File.exist?(body_path) ? File.read(body_path) : nil
    data["body"] = body

    data
  end

  File.write("boys.json", JSON.pretty_generate(result))
end

desc "Fetch metadata"
task :fetch do
  require_relative "lib/jigokuno"
  require "psych"
  require "yaml"
  require "active_support/core_ext"

  horesasu = Jigokuno::Misawa.new

  horesasu.each { |meigen|
    puts "[%3s] %s / %s / %s" % [:id, :title, :character, :image].map { |attr| meigen[attr] }

    yaml_path = File.join(File.dirname(__FILE__), "data", "#{meigen[:id]}.yml")
    yaml = YAML.dump(meigen.stringify_keys)
    File.write(yaml_path, yaml)

    sleep 2
  }
end
