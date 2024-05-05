class SlotMailer < ApplicationMailer
  def new_slot
    @slot = params[:employee_slot]
    mail(to: @slot.employee.user.email, subject: 'New Service Assigned')
  end
end
