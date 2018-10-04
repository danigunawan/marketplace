# frozen_string_literal: true

class CategoriesController < ApplicationController
  include Service::Searchable
  include Service::Sortable

  before_action :category

  def show
    @services = records.joins(:service_categories).
      where(service_categories: { category_id: category_and_descendant_ids })
        .order(ordering)
        .page(params[:page])
    @subcategories = category.children
  end

  private

    def category_and_descendant_ids
      [category] + category.descendant_ids
    end

    def category
      @category ||= Category.find(params[:id])
    end
end
