ActiveAdmin::Dashboards.build do
  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.

  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #

    section "Top Clientes", priority: 2 do
      customers = Customer.all.sort_by { |c| c.total_orders }.reverse.take(5)
      table_for customers do
        column("Nome") { |c| link_to(c.name, admin_customer_path(c)) }
        column("Valor") { |c| c.total_orders}
      end
    end

    section "A receber", priority: 3 do
      limit = 5
      customers = Customer.debtors
      table_for customers.take(limit) do
        column("Nome") { |c| link_to(c.name, admin_customer_path(c)) }
        column("Valor") { |c| c.balance}
      end

      if customers.size > limit
        div { link_to "ver mais", "/admin/debtors" }
      end
    end

    section "Ultimas Vendas", priority: 4 do
      table_for Order.order("created_at DESC").limit(3) do
        column("Produto") { |o| link_to(o.product.name, admin_product_path(o.product)) }
        column("Cliente") { |o| link_to(o.customer.name, admin_customer_path(o.customer))}
        column("Valor") { |o| o.total }
        column("Data") { |o| o.created_at.strftime("%d/%m/%Y %H:%M") }
      end
    end

    section "Vendas por data", priority: 5 do
      limit = 3
      orders = Order.sales_by_date.limit(limit)
      table_for orders do
        column("Data") { |o| o.created_at.strftime("%d/%m/%Y")}
        column("Total vendido") { |o| o.quantity * o.payment_value }
      end

      div { link_to "ver mais", "/admin/sales_by_date" }
    end

    section "Nova Venda", priority: 1 do
      div { render 'form_order', order: Order.new }
    end

  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #

  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1

  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

  # == Conditionally Display
  # Provide a method name or Proc object to conditionally render a section at run time.
  #
  # section "Membership Summary", :if => :memberships_enabled?
  # section "Membership Summary", :if => Proc.new { current_admin_user.account.memberships.any? }

end
