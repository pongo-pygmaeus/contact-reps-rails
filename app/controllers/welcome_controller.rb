class WelcomeController < ApplicationController
  def index
    redirect_to new_shipment_path
  end
end