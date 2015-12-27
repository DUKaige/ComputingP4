class ChildrenController < ApplicationController

  def index
    @children = Child.all
  end

  def show
    @child = Child.find_by(id: params[:id])
  end

  def new
  end

  def create
    if session["type"] == "school"
      @child = Child.new
      @child.name = params[:name]
      @child.age = params[:age]
      @child.status = "not_donated"
      newEnrollment = Enrollment.new
      newEnrollment.school_id = session["id"]
      if @child.save
        newEnrollment.child_id = @child.id
        newEnrollment.save
        redirect_to "/children/#{ @child.id }"
      else
        render 'new'
      end
    else
      redirect_to "/error_page"
    end


  end

  def edit
    @child = Child.find_by(id: params[:id])
  end

  def update
    @child = Child.find_by(id: params[:id])
    @child.name = params[:name]
    @child.age = params[:age]
    @child.status = params[:status]

    if @child.save
      redirect_to "/children/#{ @child.id }"
    else
      render 'edit'
    end
  end

  def destroy
    @child = Child.find_by(id: params[:id])
    @enrollments = Enrollment.find_by_child_id(@child.id)
    if @enrollments
      for i in @enrollments
        i.destroy
      end
    end
    @child.destroy

    redirect_to "/children"
  end


  def change_status
    childID = eval(params["id"])
    a = Child.find_by(id:childID)
    a.status = "transfer"
    dd = Donation.new
    dd.child_id = childID
    dd.donator_id = session["id"]
    dd.status = "transfer"
    dd.save
    a.save
    redirect_to "/donator_children"
  end

  def donate
    childID = eval(params["id"])
    dd = Donation.find_by_child_id(childID)
    dd.status = "complete"
    dd.save
    redirect_to "/"
  end
end
