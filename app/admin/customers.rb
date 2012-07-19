ActiveAdmin.register Customer do
  action_item { link_to "Nova Venda", new_admin_order_path }

  filter :name

  sidebar "Venda" do
    button_to "Nova Venda", new_admin_order_path, method: :get
  end

  index do
    column :name
    column :email
    column :total_orders
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
