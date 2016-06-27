require_relative 'bootstrap'
require './lib/npi'

npi = NPI.new("./npidata_small.csv")

# DB = Sequel.sqlite

tables_with_fields = npi.extract_row(npi.header)
tables = npi.table_type.map { |item| item.gsub(" ", "_").downcase.en.plural }
merged_table = tables.zip tables_with_fields

# Create tables in database
# merged_table.each do |table|
#   DB.create_table table[0].to_sym do
#     primary_key :id
#     # integer :doctor_id if table[0].match("addresses")
#     table[1].each do |field|
#       String field.to_sym
#     end
#   end
# end
# Create Model objects
# classeses include Doctor, MailingAddress, LocationAddress, ..
models_name = npi.table_type.map { |table| table.gsub(" ", "") }
classes = []
models_name.each do |model|
  eval <<-end_eval
    class #{model} < Sequel::Model; end
    classes << #{model}
  end_eval
end

# Create mapping table
# DB.create_table :doctor_addresses do
#   primary_key :id
#   Integer :doctor_id
#   Integer :address_id
# end
class DoctorAddresses < Sequel::Model; end

npi.get_row(10000) do |data| # [ [model1], [model2], [model3] ]
  DB.transaction do
    mapping_id = 0
    data.each_with_index do |d, i|
      classes[i].columns.shift(1) # I don't want to mess with id

      hd = Hash[classes[i].columns.zip d]
      mapping_id = classes[i].create(hd).id
    end
    DoctorAddresses.create(:doctor_id => mapping_id, :address_id => mapping_id)
  end
end
