@db = Sequel.connect('sqlite://audiogarden.db')

@db.create_table :notes do
  primary_key :id
  integer     :x
  integer     :y
  string      :name
  string      :color
end rescue nil