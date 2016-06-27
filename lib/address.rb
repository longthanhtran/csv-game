require 'sequel'

def create_address
  klass = Class.new do |name|
    include Sequel
  end
end
