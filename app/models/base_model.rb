class BaseModel < ApiAsAModel::ApiModel  
  def initialize
    super(base_url: 'http://localhost:3000', 
          resource_name: self.class.name.pluralize,
          header: {'Accept' => 'application/vnd.testbackend.com.br; version=1'},
          authorization: {username: 'g_portugues@hotmail.com',
                          password: '123456',
                          uri_token: 'http://localhost:3000/auth/login'})
  end
end
