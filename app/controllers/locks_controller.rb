class LocksController < ApplicationController
  before_filter :authorize, only: [:index, :show]

  def index
    options = {
      query: {
        clientId: '9f59bb7268bd4ea3bb4b0da5133c3294',
        accessToken: session[:access_token],
        pageNo: 1,
        pageSize: 100,
        date: DateTime.now.strftime('%Q').to_i
      }
    }
    response = HTTParty.get('https://api.sciener.com/v3/lock/list', options)

    @locks = JSON.parse(response.body)
  end

  def show
    options = {
      query: {
        clientId: '9f59bb7268bd4ea3bb4b0da5133c3294',
        accessToken: session[:access_token],
        lockId: params[:id],
        date: DateTime.now.strftime('%Q').to_i
      }
    }
    response = HTTParty.get('https://api.sciener.com/v3/lock/detail', options)

    @lock = JSON.parse(response.body)
  end
end
