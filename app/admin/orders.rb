ActiveAdmin.register Order do
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
