module Rockstar
  Version = File.open(File.join(File.dirname(__FILE__), "../../VERSION"), "r").read.strip
end
