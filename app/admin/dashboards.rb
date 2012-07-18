ActiveAdmin::Dashboards.build do
  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.

  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #

    section "TOP Clientes" do
      customers = Customer.all.sort_by {|c| c.total_orders}.reverse.take(4)
      table_for customers do |t|
        t.column("Nome") { |c| link_to(c.name, admin_customer_path(c)) }
        t.column("Valor") { |c| c.total_orders}
      end
    end

    section "A pagar" do
      customers = Customer.all.select {|c| c.balance < 0}.sort_by { |e| e.balance }
      table_for customers do |t|
        t.column("Nome") { |c| link_to(c.name, admin_customer_path(c)) }
        t.column("Valor") { |c| c.balance}
      end
    end

    section "Ultimas Vendas" do
      table_for Order.order("created_at DESC").limit(4) do |t|
        t.column("Produto") { |o| link_to(o.product.name, admin_product_path(o.product)) }
        t.column("Cliente") { |o| link_to(o.customer.name, admin_customer_path(o.customer))}
        t.column("Valor") { |o| o.total }
        t.column("Data") { |o| o.created_at.strftime("%d/%m/%Y %H:%M") }
      end
    end

  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end

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
