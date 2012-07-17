ActiveAdmin.register Credit do
  index do
    column :customer
    column :value
    column :created_at
    column :used
  end
end
