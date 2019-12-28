class PasscodesController < ApplicationController
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
      response = HTTParty.get('https://api.sciener.com/v3/lock/listKeyboardPwd', options)
    end

    @passcodes = JSON.parse(response.body)
  end
end
