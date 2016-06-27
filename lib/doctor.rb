require 'sequel'

DB = Sequel.sqlite

# DB.create_table :doctors do
#   primary_key :id
#   varchar :name
#   varchar :address
# end

class Doctor < Sequel::Model
  # plugin :schema
  # set_schema do
  #   primary_key :id
  #   var_char :name, :empty => false
  #   var_char :address
  # end
end
