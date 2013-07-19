use Rack::Static,
  urls: ["/meigens.json"],
  root: "dist",
  header_rules: [
    [:all, {'Content-Type' => 'application/json; charset=utf-8'}]
  ]

run lambda {|env| [404, {'Content-Type' => 'text/plain'}, ['Not Found']] }

