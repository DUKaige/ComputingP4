class ChildrenController < ApplicationController

  def index
    @children = Child.all
  end

  def show
    @child = Child.find_by(id: params[:id])
    @enrollment = Enrollment.find_by_child_id(@child.id)
    @news = News.where(child_id: params[:id]).to_a
  end

  def new
  end

  def create
    if session["type"] == "school"
      @child = Child.new
      @child.name = params[:name]
      @child.age = params[:age]
      @child.status = "not donated"
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
    @enrollment = Enrollment.find_by_child_id(params[:id])
    if session["type"] == "school" and session["id"] == @enrollment.school_id
      render "edit"
    else
      redirect_to "/error_page"
    end
  end

  def update
    @child = Child.find_by(id: params[:id])
    @enrollment = Enrollment.find_by_child_id(params[:id])
    if session["type"] == "school" and session["id"] == @enrollment.school_id
      @child.name = params[:name]
      @child.age = params[:age]

      if @child.save
        redirect_to "/children/#{ @child.id }"
      else
        render 'edit'
      end
    else
      redirect_to "/error_page"
    end

  end

  def destroy
    @child = Child.find_by(id: params[:id])
    @enrollment = Enrollment.find_by_child_id(@child.id)
    if session["type"] == "school" and session["id"] == @enrollment.school_id
      @child.destroy
      @enrollment.destroy
    else
      redirect_to "/error_page"
    end

    redirect_to "/children"
  end


  def change_status
    childID = eval(params["id"])
    a = Child.find_by(id:childID)
    @enrollment = Enrollment.find_by_child_id(childID)
    if session["type"] == "donator"
      a.status = "transfer"
      dd = Donation.new
      dd.child_id = childID
      dd.donator_id = session["id"]
      dd.status = "transfer"
      dd.save
      a.save
      redirect_to "/donator_children"    else
      redirect_to "/error_page"
    end

  end

  def donate
    childID = eval(params["id"])
    @enrollment = Enrollment.find_by_child_id(childID)
    if session["type"] == "school" and session["id"] == @enrollment.school_id
      thisD = Donation.find_by_child_id(childID)
      thisD.status = "complete"
      thisD.save
      thisC = Child.find_by_id(childID)
      thisC.status = "complete"
      thisC.save
      redirect_to "/"
    else
      redirect_to "/error_page"
    end


  end

end
