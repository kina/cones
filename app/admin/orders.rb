ActiveAdmin.register Order do
  form do |f|
    f.inputs "Venda" do
      f.input :product
      f.input :customer, as: :select, collection: Customer.order("name ASC").all
      f.input :quantity
      f.input :paid

      f.buttons
    end
  end

  index do
    column :customer
    column :product
    column :quantity
    column :paid
    column :paid_at
    column :created_at
  end
end
