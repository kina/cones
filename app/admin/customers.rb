ActiveAdmin.register Customer do
  index do
    column :name
    column :email

    default_actions
  end

  show title: :name do
    attributes_table do
      row :email
      row :balance
    end
  end
end
