# frozen_string_literal: true

module FirmaoManager
  # this module will create new company importing data from Firmao API
  class CompanyCreator
    include Callable
    
    def initialize(company_id)
      @company_id = company_id
    end

    def call
      @company = Company.new
      company_data = get_company_data(firmao_response(@company_id))
      @company.name = company_data[0]
      @company.nip = company_data[1]
      @company.street = company_data[2]
      @company.post_code = company_data[3]
      @company.city = company_data[4]
      @company.liame = company_data[5]
      @company.phone = company_data[6]
      @company.save
      @company
    end

    def get_company_data(firmao_response)
      company_data = []
      response_result = JSON.parse(firmao_response.body)
      company = response_result['data'].first
      company_data << company['label']
      company_data << company['nipNumber']
      company_data << company['officeAddress']['street']
      company_data << company['officeAddress']['postCode']
      company_data << company['officeAddress']['city']
      company_data << company['email']
      company_data << company['phone']
      company_data
    end

    def firmao_response(company_id)
      FirmaoManager::FirmaoConnector.call(@company_id)
    end
  end
end
