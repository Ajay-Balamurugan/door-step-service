class SlotMailer < ApplicationMailer
  def new_slot
    @slot = params[:employee_slot]
    mail(to: @slot.user.email, subject: 'New Service Assigned')
  end
end
