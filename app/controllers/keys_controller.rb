class KeysController < ApplicationController
  def index
    if params[:lock_id]
      options = {
        query: {
          clientId: '9f59bb7268bd4ea3bb4b0da5133c3294',
          accessToken: session[:access_token],
          lockId: params[:lock_id],
          pageNo: 1,
          pageSize: 100,
          date: DateTime.now.strftime('%Q').to_i
        }
      }
      response = HTTParty.get('https://api.sciener.com/v3/lock/listKey', options)
    else
      options = {
        query: {
          clientId: '9f59bb7268bd4ea3bb4b0da5133c3294',
          accessToken: session[:access_token],
          pageNo: 1,
          pageSize: 100,
          date: DateTime.now.strftime('%Q').to_i
        }
      }
      response = HTTParty.get('https://api.sciener.com/v3/key/list', options)
    end

    @keys = JSON.parse(response.body)
  end

  def new
  end

  def create
    if params[:lock_id] && params[:name] && params[:email] && params[:started_at] && params[:expired_at]
      puts params[:lock_id]
      puts params[:name]
      puts params[:email]
      puts params[:started_at]
      puts params[:expired_at]
      @response = HTTParty.post('https://api.sciener.com/v3/key/send',
        :query => {
          :clientId => '9f59bb7268bd4ea3bb4b0da5133c3294',
          :accessToken => session[:access_token],
          :lockId => params[:lock_id],
          :receiverUsername => params[:email],
          :keyName => params[:name],
          :startDate => DateTime.strptime(params[:started_at], '%Q'),
          :endDate => DateTime.strptime(params[:expired_at], '%Q'),
          :date => DateTime.now.strftime('%Q')
        },
        :headers => {"Content-Type" => "application/x-www-form-urlencoded"}
      )

      puts @response.body
      puts @response.code
      puts @response.message
      puts @response.headers.inspect

      redirect_to lock_keys_url(params[:lock_id]), notice: "Thank you for signing up!"
    else
      render new
    end
  end
end
