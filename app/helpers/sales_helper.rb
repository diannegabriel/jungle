module SalesHelper
  def active_sale?
    Sale.active.any?
  end

  def sale_title
    Sale.title
  end

  def sale_percent
    Sale.discount
  end
end
