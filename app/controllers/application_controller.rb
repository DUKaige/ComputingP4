class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def main
  end
  def login

  end

  def signup

  end

  def sign_in
    ifDonator = FALSE
    ifSchool = FALSE
    k = Donator.find_by_user_name(params["username"])
    if k
      u = Donator.find_by_user_name(params["username"])
      ifDonator = TRUE
    else
      k = School.find_by_user_name(params["username"])
      if k
        u = School.find_by_user_name(params["username"])
        ifSchool = TRUE
      else

      end
    end
    @test = u

    if u
      if u.password == params["password"]
          session["id"] = u.id
          if ifDonator
            session["type"] = "donator"
          elsif ifSchool
            session["type"] = "school"
          end
          redirect_to '/'
      else
        redirect_to "/login"

      end
    else
      redirect_to '/login'
    end

  end

  def sign_out
    session["id"] = nil
    session["type"] = nil
    redirect_to "/"
  end

  def error_page

  end
  def mytest

  end
end
