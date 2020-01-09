module ApiAsAModel
  class ApiAccess
    attr_reader :api_core

    protected :api_core

    def initialize(base_url:, resource_name:, authorization:, header: nil)
      @api_core = ApiCore.new
      @api_core.base_url = base_url      
      @api_core.authorization = authorization
      @api_core.resource_name = resource_name.downcase
      @api_core.header = header

      @persisted = false

      if !@api_core.authorization[:token]
        get_token
      end
    end

    def call_get(resource_id = nil, query_parameters = nil)
      @persisted = true
      params = mount_header
      params.merge! params: query_parameters unless query_parameters.nil?

      RestClient.get(uri(resource_id),
                     mount_header
                    ){|response, request, result|
                      parsed_request = http_response(response)
                      if parsed_request[@api_core.resource_name]
                        parsed_request = parsed_request[@api_core.resource_name]
                      else
                        parsed_request = parsed_request[@api_core.resource_name.singularize]
                      end
                      if parsed_request.is_a?(Array)
                        collection = []
                        parsed_request.each do |item|
                          new_item = clone
                          new_item.inject_attributes(item)
                          collection.push new_item
                        end
                        collection
                      else
                        inject_attributes parsed_request
                        self
                      end
                    }
    end

    def call_post(filter = {})
      payload = {action: @action,
                 APIkey: API_KEY}
      payload.merge! filter           

      RestClient::Request.execute(method: :post,
                                  url: URL,
                                  payload: payload.to_json
                                  ){ |response, request, result|
                                    http_response(response)
                                  }
    end

    def call_patch(filter = {})
      payload = {action: @action,
                APIkey: API_KEY}
      payload.merge! filter           

      RestClient::Request.execute(method: :patch,
                                  url: URL,
                                  payload: payload.to_json
                                ){ |response, request, result|
                                  http_response(response)
                                }
    end

    def call_update(filter = {})
      payload = {action: @action,
                APIkey: API_KEY}
      payload.merge! filter           

      RestClient::Request.execute(method: :update,
                                  url: URL,
                                  payload: payload.to_json
                                ){ |response, request, result|
                                  http_response(response)
                                }
    end

    def call_delete(id)
      params =  { action: @action,
                  APIkey: API_KEY }
      params.merge! filter
      RestClient.get(URL, params: params){|response, request, result|
                                          http_response(response)
                                        }
    end

    def to_model
      self
    end

    def model_name
      @_model_name ||= begin
        ApiName.new(self.class)
      end
    end

    def persisted?
      @persisted
    end

    private

      def mount_header
        auth = {
          'Authorization': "Bearer #{@api_core.authorization[:token]['access_token']}"
        }
        auth.merge @api_core.header
      end

      def http_response(response)
        case response.code
        when 200, 201, 204
          return JSON.parse(response.body)
        else
          Rails.logger.error "HTTP #{response.code} - #{response.body}"
          return []
        end
      end

      def uri(resource_id)
        if resource_id
          "#{@api_core.base_url}/#{@api_core.resource_name}/#{resource_id}"
        else
          "#{@api_core.base_url}/#{@api_core.resource_name}"
        end
      end

      def merge_parameters(parameters)
        parameters ||= {}
        auth =  { :Authorization => "Bearer #{token}" }
        parameters.merge! auth
      end

      def get_token
        headers = {
          'Authorization': "Basic "+Base64.strict_encode64("#{@api_core.authorization[:username]}:#{@api_core.authorization[:password]}")
        }
        headers.merge! @api_core.header

        @api_core.authorization[:token] = RestClient::Request.execute(method: :post,
                                                             url: @api_core.authorization[:uri_token],
                                                             headers: headers
                                                            ){ |response, request, result|
                                                              http_response(response)
                                                            }
      end

    protected

      def inject_attributes(class_fields)
        class_fields.each do |key, value|
          class_eval %Q"
            attr_accessor :#{key}
          "          
          send("#{key}=", value)
        end
      end
  end
end
