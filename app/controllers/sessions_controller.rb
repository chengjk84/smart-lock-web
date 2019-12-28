class SessionsController < ApplicationController
  def new
  end
  
  def create
    if params[:username] && params[:password]
        @response = HTTParty.post('https://api.sciener.com/oauth2/token',
        :query => {
            :client_id => '9f59bb7268bd4ea3bb4b0da5133c3294',
            :client_secret => '33e6c1d1c4dff1f132825fca27be64a9',
            :grant_type => 'password',
            :username => params[:username],
            :password => Digest::MD5.hexdigest(params[:password]),
            :redirect_uri => 'https://open-sciener.herokuapp.com/'
        },
        :headers => {"Content-Type" => "application/x-www-form-urlencoded"}
        )

        puts @response.body
        puts @response.code
        puts @response.message
        puts @response.headers.inspect

        @user = JSON.parse(@response.body)

        if @user.key?(:errcode)
            flash.now.alert = @user[:errmsg]
            render new
        else
            session[:access_token] = @user["access_token"]
            session[:refresh_token] = @user["refresh_token"]
            session[:username] = params[:username]
            session[:scope] = @user[:scope].to_s
            session[:token_type] = @user["token_type"]
            session[:expires_at] = DateTime.now + 2.hours

            redirect_to root_path, notice: "success!!!"
        end
    else
        flash.now.alert = "Email or password is invalid"
        render new
    end
  end

  def destroy
      session[:access_token] = nil
      session[:refresh_token] = nil
      session[:username] = nil
      session[:scope] = nil
      session[:token_type] = nil
      session[:expires_at] = nil
      
      redirect_to new_session_url, notice: "Logged out!"
  end
end
