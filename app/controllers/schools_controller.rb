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
        a = "a" + 1
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
    @school = School.find_by(id: params[:id])
  end

  def update
    @school = School.find_by(id: params[:id])
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
  end

  def destroy
    @school = School.find_by(id: params[:id])
    @school.destroy


    redirect_to "/schools"
  end

  def show_related_children
    if session["id"] and session["type"] == "school"
      enrollments = Enrollment.find_by(school_id:session["id"])

      if enrollments
        @children = []
        if enrollments.class == [].class
          enrollments.each do |eee|
            @children.append(Child.find_by_id(eee.school_id))
          end
        else
          if not Child.find_by_id(enrollments.child_id)
            a = "a" + 1
          end
          @children.append(Child.find_by_id(enrollments.child_id))
        end

      end

      if @children == nil
        @children = []
      end
    else
      redirect_to "/error_page"
    end

  end
end
