class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  def index
    #@articles = Article.all

    @articles = Article.order("created_at DESC") #added bc of tutorial

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  def drafts
    @articles = Article.order("created_at DESC") #added bc of tutorial

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = current_user.articles.build(params[:article])  
    respond_to do |format|
      if params[:draft_button]
        @article.update_attributes(:draft => true) 
        @article.save
        format.html { redirect_to drafts_path, notice: 'Article saved as draft!' }
      elsif params[:publish_button] 
        @article.update_attributes(:draft => false)
        @article.update_attributes(:created_at => Time.now) 
        @article.save
        format.html { redirect_to @article, notice: 'Article was published!' }
      else
          format.html { render action: "new" }
          format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end



  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  #private #added due to tutorial

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end
end
