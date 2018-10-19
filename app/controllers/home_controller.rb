# frozen_string_literal: true

class HomeController < ApplicationController
  def index
  end

  def products
    @categories = Category.take(4)
  end
end
