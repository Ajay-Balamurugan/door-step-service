class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  ADMIN_ROLE_ID = Role.find_by(name: 'admin').id
  EMPLOYEE_ROLE_ID = Role.find_by(name: 'employee').id
  CUSTOMER_ROLE_ID = Role.find_by(name: 'customer').id
end
