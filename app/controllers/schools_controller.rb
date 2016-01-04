class SchoolsController < ApplicationController

  def index
    @schools = School.all
  end

  def show
    @school = School.find_by(id: params[:id])
  end

  def new
  end

  def create
    if params[:password] == params[:repassword]
      if Donator.find_by_user_name(params[:username]) or School.find_by_user_name(params[:username])
        session["errormessage"] = "the username already exists"
        redirect_to "/new_school"
      else
        @school = School.new
        @school.user_name=params[:username]
        @school.name = params[:name]
        @school.email = params[:email]
        @school.phone_number = params[:phone_number]
        @school.address = params[:address]
        @school.card_number = params[:card_number]
        @school.password = params[:password]
        if @school.save
          redirect_to "/"
          session["id"] = @school.id
          session["type"] = "school"
        else
          render 'new'
        end
      end
    else
      session["errormessage"] = "the passwords are inconsistent"
      redirect_to "/new_school"
    end


  end

  def edit
    if session["id"] and session["type"] == "school"
      @school = School.find_by(id: session["id"])
    else
      redirect_to "/error_page"
    end
  end

  def update
    if session["id"] and session["type"] == "school"
      @school = School.find_by(id: session["id"])
      @school.name = params[:name]
      @school.email = params[:email]
      @school.phone_number = params[:phone_number]
      @school.address = params[:address]
      @school.card_number = params[:card_number]

      if @school.save
        redirect_to "/schools/#{ @school.id }"
      else
        render 'edit'
      end
    else
      redirect_to "/error_page"
    end

  end


  def destroy
    if session["type"] == "manager"
      @school = School.find_by(id: params[:id])
      @school.destroy
      redirect_to "/schools"
    else
      redirect_to "/error_page"
    end
  end



  def show_related_children
    if session["id"] and session["type"] == "school"
      enrollments = Enrollment.where(school_id:session["id"]).to_a
      if enrollments
        @children = []
        enrollments.each do |eee|
          this = Child.find_by_id(eee.school_id)
          if this
            @children.append(this)
          end
        end

      else
        @children = []

      end

      if not @children
        @children = []
      end
    else
      redirect_to "/error_page"
    end

  end
  def show_related_news
    if session["id"] and session["type"] == "school"
      @news = News.where(:school_id => session["id"]).to_a

      if @news.class != [].class
        @news = [@news]
      end
    else
      redirect_to "/error_page"
    end
  end

  def account
    if session["id"]
      redirect_to "/schools/"+session["id"].to_s
    else
      redirect_to "/error_page"
    end
  end

  def change_password
    if session["id"] and session["type"] == "school"
      @school = School.find_by(id: session["id"])
    else
      redirect_to "/error_page"

    end
  end

  def update_password
    if session["id"] and session["type"] == "school"
      @school = School.find_by(id: session["id"])
      if params["old"] == @school.password
        if params["new"] == params["renew"]
          @school.password = params["new"]
          @school.save
          redirect_to "/school_account"
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
end
