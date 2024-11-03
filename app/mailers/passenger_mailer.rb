class PassengerMailer < ApplicationMailer
  default from: "phadnis.sankalp691@gmail.com"

  def booking_confirmation
    @flight = params[:flight]
    @passenger = params[:passenger]

    mail(to: @passenger.email, subject: "Your flight is booked!")
  end
end
