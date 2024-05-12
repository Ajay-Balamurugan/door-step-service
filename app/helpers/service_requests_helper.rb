module ServiceRequestsHelper
  def render_present_feedback(item)
    yield if item.feedback.present?
  end

  def render_feedback_form(item)
    yield unless item.feedback.present?
  end

  def rejected_indicator(item)
    yield if item.status == 'rejected'
  end

  def completed_indicator(item)
    yield if item.status == 'completed'
  end

  def view_status(item)
    yield if item.status != 'completed' && item.status != 'rejected'
  end

  def feedback_and_indicator(item)
    yield if item.status == 'completed' || item.status == 'rejected'
  end

  def display_service_requests(service_requests)
    yield if service_requests.any?
  end

  def display_no_bookings(service_requests)
    yield unless service_requests.any?
  end
end
