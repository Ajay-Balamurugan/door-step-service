module AdminsHelper
  def display_service_request_items(service_request_items)
    yield if service_request_items.any?
  end

  def display_no_bookings(service_request_items)
    yield unless service_request_items.any?
  end
end
