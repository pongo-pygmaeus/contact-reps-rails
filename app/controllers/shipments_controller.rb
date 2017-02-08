class ShipmentsController < ApplicationController

  def new

  end

  def create
    PrintJob.perform_now(to_address:   shipment_params[:to_address].to_h,
                         from_address: shipment_params[:from_address].to_h)
    redirect_to :root
  end

private

  def shipment_params
    # street1: "4181 Main Street",
    # city: "SACRAMENTO",
    # state: "CA",
    # zip: "94618",
    # country: "US",
    # company: "CONTACT-A-REP",
    # phone: "111-111-1111"}
    params.permit(to_address:   [:street1,
                                 :city,
                                 :state,
                                 :zip,
                                 :country,
                                 :company,
                                 :phone],
                  from_address: [:street1,
                                 :city,
                                 :state,
                                 :zip,
                                 :country,
                                 :company,
                                 :phone]                               
                               )

  end
end