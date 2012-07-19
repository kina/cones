ActiveAdmin.register Order do
  action_item only: :show do
    link_to "Nova Venda", new_admin_order_path
  end

  form do |f|
    f.inputs "Venda" do
      f.input :product
      f.input :customer, as: :select, collection: Customer.order("name ASC").all
      f.input :quantity
      f.input :payment_value

      f.buttons
    end
  end

  index do
    column :customer
    column :product
    column :quantity
    column :payment_value
    column :created_at

    default_actions
  end
end
