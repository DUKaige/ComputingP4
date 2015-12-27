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
    @donator = Donator.find_by(id: params[:id])
  end

  def update
    @donator = Donator.find_by(id: params[:id])
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
  end

  def destroy
    @donator = Donator.find_by(id: params[:id])
    @donator.destroy


    redirect_to "/donators"
  end

  def show_related_children
    if session["id"] and session["type"] == "donator"
      donations = Donation.find_by(donator_id:session["id"])
      if donations
        @children = []
        if donations.class == [].class
          donations.each do |ddd|
            @children.append(Child.find_by_id(ddd.donator_id))
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
    redirect_to "/donators/"+session["id"].to_s
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
end
