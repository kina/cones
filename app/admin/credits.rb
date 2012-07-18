ActiveAdmin.register Credit do
  index do
    column :customer
    column :value
    column :created_at

    default_actions
  end
end
