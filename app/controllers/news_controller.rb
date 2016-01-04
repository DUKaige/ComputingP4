class NewsController < ApplicationController

  def show
    @news = News.find_by(id: params[:id])
    @school_id = @news.school_id

    if session["type"] == "manager"

    elsif session["type"] == "school"
      if session["id"] == @school_id

      else
        redirect_to "/error_page"
      end
    elsif session["type"] == "donator"
      enrollments = Enrollment.where(school_id:@school_id).to_a
      donations = Donation.where(donator_id:session["id"] ).to_a
      childrenInSchool = []
      childrenInDonator = []
      enrollments.each do |i|
        childrenInSchool.append(Child.find_by_id(i.child_id))
      end
      donations.each do |j|
        if j.status == "complete"
          childrenInDonator.append(Child.find_by_id(j.child_id))
        end
      end
      ifVisible = FALSE
      childrenInSchool.each do |k|
        childrenInDonator.each do |w|
          if k.id == w.id
            ifVisible = TRUE
            break
          end
        end
        if ifVisible
          break
        end
      end
      if not ifVisible
        redirect_to "/error_page"
      end

    end

  end
  def new
  end

  def create
    if session["type"] == "school"
      @news = News.new
      @news.title = params[:title]
      @news.content = params[:content]
      if params[:id]
        @news.child_id = eval(params[:id])
      else
        @news.child_id = 0
      end
      @news.school_id = session["id"]
      if @news.save
        redirect_to "/news/#{ @news.id }"
      else
        render 'new'
      end
    else
      redirect_to "error_page"
    end


  end

  def edit
    @news = News.find_by(id: params[:id])
    if session["type"] == "school" and session["id"] == @news.school_id
      k = "nothing"
    else
      redirect_to "/error_page"
    end
  end

  def update
    @news = News.find_by(id: params[:id])
    if session["type"] == "school" and session["id"] == @news.school_id
      @news.title = params[:title]
      @news.content = params[:content]
      @news.child_id = params[:child_id]
      @news.school_id = params[:school_id]

      if @news.save
        redirect_to "/news/#{ @news.id }"
      else
        render 'edit'
      end
    else
      redirect_to "/error_page"
    end

  end

  def destroy
    @news = News.find_by(id: params[:id])
    if (session["type"] == "school" and session["id"] == @news.school_id)or session["type"] == "manager"
      if @news
        @news.destroy
      end
    else
      redirect_to "error_page"
    end
    redirect_to "/"
  end

  def index
    if session["type"] == "manager"
      @news = News.all
    else
      redirect_to "/error_page"
    end
  end
end
