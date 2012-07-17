ActiveAdmin.register Customer do
  index do
    column :name
    column :email
    column :total_paid_orders
    column :balance

    default_actions
  end

  show title: :name do
    # attributes_table do
    #   row :email
    #   row :balance
    # end

    render "show"
  end
end
