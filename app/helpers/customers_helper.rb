module CustomersHelper
  def render_service_image_link(service)
    yield if service.images.any?
  end

  def render_service_text_link(service)
    yield if service.images.none?
  end
end
