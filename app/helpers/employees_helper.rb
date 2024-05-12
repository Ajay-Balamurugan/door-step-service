module EmployeesHelper
  def display_employee_slots(employee_slots)
    yield if employee_slots.any?
  end

  def display_no_slots(employee_slots)
    yield unless employee_slots.any?
  end
end
