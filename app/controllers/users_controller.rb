class UsersController < ApplicationController
  def index
    options = {
      query: {
        clientId: '9f59bb7268bd4ea3bb4b0da5133c3294',
        clientSecret: '33e6c1d1c4dff1f132825fca27be64a9',
        startDate: 0,
        endDate: 0,
        pageNo: 1,
        pageSize: 100,
        date: DateTime.now.strftime('%Q').to_i
      }
    }
    response = HTTParty.get('https://api.sciener.com/v3/user/list', options)

    @users = JSON.parse(response.body)
  end

  def new
  end

  def create
    if params[:username] && params[:password]
      @response = HTTParty.post('https://api.sciener.com/v3/user/register',
        :query => {
          :clientId => '9f59bb7268bd4ea3bb4b0da5133c3294',
          :clientSecret => '33e6c1d1c4dff1f132825fca27be64a9',
          :grant_type => 'password',
          :username => params[:username],
          :password => Digest::MD5.hexdigest(params[:password]),
          :date => DateTime.now.strftime('%Q')
        },
        :headers => {"Content-Type" => "application/x-www-form-urlencoded"}
      )

      puts @response.body
      puts @response.code
      puts @response.message
      puts @response.headers.inspect

      redirect_to users_url, notice: "Thank you for signing up!"
    else
      render new
    end
  end
end
