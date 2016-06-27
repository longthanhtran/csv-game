require_relative "./bootstrap"

# ap DB[:products] # shows the raw SQL query
# ap DB[:products].all
# ap DB[:products].where(id: 1).all # returns an array
# ap DB[:products].where(id: 1).first # returns an object
# ap DB[:products].order(:id).last
# ap DB[:products].where(id: 1..5).order(:name)
# ap DB[:products].where(id: 1..5).order(:name).all
# ap DB[:products].where(Sequel.like(:name, "%p%")).order(:name)
# ap DB[:products].where(Sequel.like(:name, "%p%")).order(:name).all
# ap DB[:products].limit(3)
# ap DB[:products].limit(3).all
# ap DB[:products].limit(3).offset(2)
# ap DB[:products].limit(3).offset(2).all
#
# id = DB[:products].insert(name: "Snicky", category: "Dairy")
# ap DB[:products].where(id: id).update(name: "Snickey")
#
class Product < Sequel::Model
end

ap Product.where(id: 1).first
