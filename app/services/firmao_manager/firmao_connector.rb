# frozen_string_literal: true

module FirmaoManager
  # this module will just connect to the firmao API
  class FirmaoConnector
    include Callable
    
    def initialize(company_id = nil)
      @company_id = company_id if company_id.present?
    end

    def call
      firmao_login = ENV.fetch('FIRMAO_LOGIN')
      firmao_password = ENV.fetch('FIRMAO_PASSWORD')
      firmao_organization = ENV.fetch('FIRMAO_ORGANIZATION')
        if @company_id.present?
          company_id = 'id(eq)=' + @company_id + '&'
        else
          company_id = ''
        end
      url = 'https://system.firmao.pl/' + firmao_organization + '/svc/v1/customers?' + company_id + 'limit=5000'
      connection = Faraday.new(url) do |conn|
        conn.basic_auth(firmao_login, firmao_password)
        conn.headers['Authorization']
      end

      response = connection.get url do |request|
      end
      response
    end
  end
end
