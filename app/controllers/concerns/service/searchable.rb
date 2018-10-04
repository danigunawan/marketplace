# frozen_string_literal: true

module Service::Searchable
  extend ActiveSupport::Concern

  # Add field filter methods HERE
  # Filter method should have following name and arguments:
  # filter_<field>(services, search_value)
  #
  module FieldFilterable
    extend ActiveSupport::Concern

    def filter_country(services, search_value)
      # TODO filter by parameter
      services
    end
  end

  include FieldFilterable


  # Add here new fields from filter form (:q is handled separately, as it requires calling of elasticsearch)
  @@searchable_fields = [:country]

  private
    def query_present?
      (@@searchable_fields + [:q]).map { |field| params[field].blank? } .include? false
    end

    def records
      query_present? ? scope.where(id: search_ids) : scope
    end

    def filter_by_field(elements, field)
      self.send("filter_#{field}".to_s, elements, params[field])
    end

    def filter_by_fields
      filtered_services = Service
      @@searchable_fields.each { |field| filtered_services = filter_by_field(filtered_services, field) }
      filtered_services
    end

    def search_ids
      filter_by_fields.search(params[:q]).records.ids
    end

    def scope
      Service.all
    end
end
