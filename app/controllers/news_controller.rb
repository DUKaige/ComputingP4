class NewsController < ApplicationController

  def index
    @news = News.all
  end

  def show
    @news = News.find_by(id: params[:id])
  end

  def new
  end

  def create
    @news = News.new
    @news.title = params[:title]
    @news.content = params[:content]
    @news.child_id = params[:child_id]
    @news.school_id = params[:school_id]

    if @news.save
      redirect_to "/news/#{ @news.id }"
    else
      render 'new'
    end
  end

  def edit
    @news = News.find_by(id: params[:id])
  end

  def update
    @news = News.find_by(id: params[:id])
    @news.title = params[:title]
    @news.content = params[:content]
    @news.child_id = params[:child_id]
    @news.school_id = params[:school_id]

    if @news.save
      redirect_to "/news/#{ @news.id }"
    else
      render 'edit'
    end
  end

  def destroy
    @news = News.find_by(id: params[:id])
    @news.destroy


    redirect_to "/news"
  end
end
