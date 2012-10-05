task :default => :build

desc "Build dist/meigens.json"
task :build do
  require "yaml"
  require "json"

  records = Dir["data/*"].map do |path|
    data = YAML.load_file(path)
    body_path = File.join("body", File.basename(path, ".yml") + ".txt")
    body = File.exist?(body_path) ? File.read(body_path) : nil
    data["body"] = body

    data
  end
  records = records.sort_by {|record| record["id"] }

  File.write("dist/meigens.json", JSON.pretty_generate(records))
end

desc "Fetch metadata"
task :fetch do
  require_relative "lib/jigokuno"
  require "psych"
  require "yaml"
  require "active_support/core_ext"

  horesasu = Jigokuno::Misawa.new

  horesasu.each { |meigen|
    yaml_path = File.join(File.dirname(__FILE__), "data", "#{meigen[:id]}.yml")
    break if File.exist? yaml_path

    puts "[%3s] %s / %s / %s" % [:id, :title, :character, :image].map { |attr| meigen[attr] }

    yaml = YAML.dump(meigen.stringify_keys)
    File.write(yaml_path, yaml)

    sleep 2
  }
end

desc "Upload to Github Download section"
task :upload => :build do
  require "github_downloads"
  uploader = GithubDownloads::Uploader.new
  uploader.authorize

  uploader.upload_file("meigens.json", "Latest build", "dist/meigens.json")
end
