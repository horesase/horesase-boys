require "pathname"

task default: :build

BASE_DIR = Pathname(".")
DATA_DIR = BASE_DIR + "data"
BODY_DIR = BASE_DIR + "body"
DIST_DIR = BASE_DIR + "dist"
DIST_FILENAME = "meigens.json"
DIST_PATH = DIST_DIR + DIST_FILENAME

desc "Build #{DIST_PATH}"
task :build do
  require "yaml"
  require "json"

  puts "Generating %s ..." % DIST_PATH

  records = Dir[DATA_DIR + "*"].map do |path|
    data = YAML.load_file(path)
    body_path = BODY_DIR + (File.basename(path, ".yml") + ".txt")
    body = body_path.exist? ?
      body_path.read(encoding: Encoding::UTF_8) : nil
    data["body"] = body

    data
  end
  records = records.sort_by {|record| record["id"] }
  num_with_body = records.select {|record| record["body"] }.size
  puts "%d of %d (%0.1f%%) have body text" % [
    num_with_body,
    records.size,
    num_with_body.to_f / records.size.to_f * 100
  ]

  bytes_written = File.write(
    DIST_PATH,
    JSON.generate(records),
    encoding: Encoding::UTF_8
  )
  puts "%d bytes written" % bytes_written
end

desc "Fetch metadata"
task :fetch do
  require_relative "lib/jigokuno"
  require "psych"
  require "yaml"
  require "active_support/core_ext/hash"

  horesasu = Jigokuno::Misawa.new

  horesasu.each do |meigen|
    yaml_path = DATA_DIR + "#{meigen[:id]}.yml"
    text_path = BODY_DIR + "#{meigen[:id]}.txt"

    break if yaml_path.exist?
    break if text_path.exist?

    puts "[%3s] %s / %s / %s" % [:id, :title, :character, :image].map {|attr| meigen[attr] }

    body = meigen.delete(:body)

    yaml = YAML.dump(meigen.stringify_keys)
    File.write(yaml_path, yaml, encoding: Encoding::UTF_8)
    File.write(text_path, body, encoding: Encoding::UTF_8)

    sleep 2
  end
end

namespace :assets do
  task precompile: :build
end
