require "fileutils"
require "json"
require "yaml"

SOURCE_DIR = File.expand_path("./doc/openapi/openapi/")
TARGET_DIR = File.expand_path("./swagger-ui/dist")
source = File.join(SOURCE_DIR, "openapi.yaml")
target = File.join(TARGET_DIR, "openapi.js")
html   = File.join(TARGET_DIR, "index.html")

puts "--> Git clone swagger-ui"
`git clone https://github.com/swagger-api/swagger-ui.git`

puts "--> Rewriting #{source} to #{target}"
File.write(target, "const spec = " + JSON.pretty_generate(YAML.load(File.read(source))))

puts "--> Rewriting #{html}"
File.write(
  html,
  File.read(html)
    .sub(/<div id=\"swagger-ui\"><\/div>/, "<div id=\"swagger-ui\"><\/div><script src=\"./openapi.js\"></script>")
    .sub(/url: \"https:\/\/petstore.swagger.io\/v2\/swagger.json\"/, "spec: spec")
)
