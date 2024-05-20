module CustomersHelper
  def render_service_image_link(service)
    yield if service.images.any?
  end

  def render_service_text_link(service)
    yield if service.images.none?
  end

  def display_book_now_button
    yield if user_signed_in?
  end

  def display_log_in_button
    yield unless user_signed_in?
  end
end
