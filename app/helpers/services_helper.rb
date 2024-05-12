module ServicesHelper
  def display_service_options(service)
    yield if service.options.any?
  end

  def no_options(service)
    yield unless service.options.any?
  end

  def display_services(services)
    yield if services.any?
  end

  def no_services(services)
    yield unless services.any?
  end

  def show_for_admin
    yield if user_is_admin?
  end

  def show_for_customer
    yield if user_is_customer?
  end
end
