module ApiAsAModel
  class ApiAccess

    def initilize(base_url, resource_name, authorization: {username:, password:, uri_token:, token:}, header:)
      @base_url = base_url
      @authorization = authorization
      @resource_name = resource_name

      RestClient.add_before_execution_proc do
        if !@authorization.token      
          @authorization.token = RestClient::Request.execute(method: :post,
                                                              url: !@authorization.uri_token,
                                                            ){ |response, request, result|
                                                              http_response(response)
                                                            }
        end
      end
    end

    def call_get(resource_id, query_parameters:)
      merge_parameters query_parameters
      RestClient.get(url: uri,                     
                     params: query_parameters){|response, request, result|
                                                http_response(response)
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

    private

      def mount_header
        {

        }
      end

      def http_response(response)
        case response.code
        when 200, 201, 204
          return JSON.parse(response.body)
        else
          Log.error "HTTP #{response.code} - #{response.body}"
          return []
        end
      end

      def uri(resource_id)
        if resource_id
          @base_url + "/#{resource}/#{resource_id}"
        else
          @base_url + "/#{resource}"
        end
      end

      def merge_parameters(parameters)
        parameters ||= {}
        auth =  { :Authorization => "Bearer #{token}" }
        parameters.merge! auth
      end

  end
end
    