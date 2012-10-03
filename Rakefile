task :default => :build

task :build do
  require "yaml"
  require "json"

  open("boys.json", "w") { |file|
    result = Dir["data/*"].inject([]) { |tmp, path|
      data = YAML.load_file(path)
      text_path = File.join('body', File.basename(path, '.yml') + '.txt')
      if File.exist?(text_path)
        data["body"] = File.read(text_path)
      end
      tmp << data
      tmp
    }

    file.puts JSON.generate(result, :indent => "\n")
  }
end

task :fetch do
  require_relative "lib/jigokuno"
  require "psych"
  require "yaml"
  require "active_support/core_ext"

  horesasu = Jigokuno::Misawa.new

  horesasu.each { |meigen|
    puts "[%3s] %s / %s / %s" % [:id, :title, :character, :image].map { |attr| meigen[attr] }

    open(File.join(File.dirname(__FILE__), "data", "#{meigen[:id]}.yml"), "w") { |file|
      YAML.dump(meigen.stringify_keys, file)
    }

    sleep 2
  }
end
