# frozen_string_literal: true

module FirmaoManager
  # this module will import companies to the select
  class CompaniesImporter
    include Callable
    
    def call
      company_array = []
      response_result = JSON.parse(firmao_response.body)
      response_result['data'].each do |item|
        single_company = [item['label'], item['id']]
        company_array << single_company
      end
      company_array
    end

    def firmao_response
      FirmaoManager::FirmaoConnector.call
    end
  end
end
