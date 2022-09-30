class ClientController < ApplicationController
  before_action :initialize_cart

  def index
    @categories = Category.all.includes(:products)
  end
end
