require 'bundler'

Bundler.require

Linguistics.use :en

# Just use Sequel::Model.descendants to get all descendants
class Sequel::Model
  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end
end

require 'yaml'
file_path = File.expand_path "../database.yaml", __FILE__
file = YAML.load_file file_path
DB = Sequel.connect(file)
