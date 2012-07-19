ActiveAdmin.register_page 'Sales By Date' do
  menu label: "Vendas por data", parent: "Orders"
  action_item { link_to "Nova Venda", new_admin_order_path }

  content do
    orders = Order.sales_by_date
    table_for orders do
      column("Data") { |o| o.created_at.strftime("%d/%m/%Y")}
      column("Total vendido") { |o| o.quantity * o.payment_value }
    end
  end
end

ActiveAdmin.register_page 'Debtors' do
  menu label: "A receber", parent: "Orders"
  action_item { link_to "Nova Venda", new_admin_order_path }
  content do
    customers = Customer.debtors
    table_for customers do
      column("Nome") { |c| link_to(c.name, admin_customer_path(c)) }
      column("Valor") { |c| c.balance}
    end
  end
end
