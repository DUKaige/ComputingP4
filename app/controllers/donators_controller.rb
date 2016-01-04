class DonatorsController < ApplicationController

  def index
    @donators = Donator.all
  end


  def show
    @donator = Donator.find_by(id: params[:id])

  end

  def new
  end

  def create
    if params[:password] == params[:repassword]
      if Donator.find_by_user_name(params[:username]) or School.find_by_user_name(params[:username])
        session["errormessage"] = "the username already exists"
        redirect_to "/new_donator"
      else
        @donator = Donator.new
        @donator.name = params[:name]
        @donator.user_name = params[:username]
        @donator.password = params[:password]
        @donator.email = params[:email]
        @donator.password = params[:password]
        @donator.phone_number = params[:phone_number]

        if @donator.save
          redirect_to "/"
          session["id"] = @donator.id
          session["type"] = "donator"
        else
          session["errormessage"] = "error"
          render 'new'
        end
      end

    else
      session["errormessage"] = "the passwords are inconsistent"
      redirect_to "/new_donator"
    end

  end

  def edit
    if session["id"] and session["type"] == "donator"
      @donator = Donator.find_by(id: session["id"])
      k = "nothing happens"
    else
      redirect_to "/error_page"
    end
  end

  def update

    if session["id"] and session["type"] == "donator"
      @donator = Donator.find_by(id: session["id"])
      @donator.name = params[:name]
      @donator.user_name = params[:user_name]
      @donator.password = params[:password]
      @donator.email = params[:email]
      @donator.password = params[:password]
      @donator.phone_number = params[:phone_number]

      if @donator.save
        redirect_to "/donators/#{ @donator.id }"
      else
        render 'edit'
      end
    else
      redirect_to "/error_page"
    end

  end

  def show_related_children
    if session["id"] and session["type"] == "donator"
      donations = Donation.where(donator_id:session["id"]).to_a
      if donations
        @children = []
        if donations.class == [].class
          donations.each do |ddd|
            @children.append(Child.find_by_id(ddd.child_id))
          end
        else
          @children.append(Child.find_by_id(donations.child_id))
        end

      end
      if @children == nil
        @children = []
      end
    else
      redirect_to "/error_page"
    end

  end


  def account
    if session["id"] and session["type"] == "donator"
      redirect_to "/donators/"+session["id"].to_s
    else
      redirect_to "/error_page"
    end
  end

  def inside(arrayy,item)
    for i in arrayy
      if item == i
        return TRUE
        break
      end
    end
    return FALSE
  end

  def change_password
    if session["id"] and session["type"] == "donator"
      @donator = Donator.find_by(id: session["id"])
      render "change_password"
    else
      redirect_to "/error_page"
    end
  end

  def update_password
    if session["id"] and session["type"] == "donator"
      @donator = Donator.find_by(id: session["id"])
      if params["old"] == @donator.password
        if params["new"] == params["renew"]
          @donator.password = params["new"]
          @donator.save
          redirect_to "/donator_account"
        else
          render "change_password"
        end

      else
        render "change_password"
      end
    else
      redirect_to "/error_page"
    end

  end

  def destroy
    if session["type"] == "manager"
      @donator = Donator.find_by(id: params[:id])
      @donator.destroy
      redirect_to "/donators"
    else
      redirect_to "/error_page"
    end
  end
end
