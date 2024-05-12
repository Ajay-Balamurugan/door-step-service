module ServiceRequestItemsHelper
  def display_cart_items(service_request_items)
    yield if service_request_items.any?
  end

  def display_empty_cart(service_request_items)
    yield unless service_request_items.any?
  end
end
