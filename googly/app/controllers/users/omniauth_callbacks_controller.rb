class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def yahoo
  end

  def facebook
  end

  def google_oauth2

    #grab out of details
    deets = request.env["omniauth.auth"]

    # get deets
    uid = deets["uid"]
    access_token = deets.fetch("credentials").fetch("token")
    name = deets.fetch("info").fetch("name")
    photo_url = deets.fetch("info").fetch("image")

    # create login
    user = User.find_by uid: uid
    if user
      user.update access_token: access_token, name: name, photo_url: photo_url
    else
      user = User.create! uid: uid, access_token: access_token, name: name, photo_url: photo_url
    end

    # sign in user
    sign_in_and_redirect user



  end

end
