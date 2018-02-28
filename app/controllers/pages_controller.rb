class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :set_new_page, only: [:new, :create]

  def index
    @pages ||= Page.roots.map do |page|
      page.subtree.arrange
    end
  end

  def show
    @page = @page.subtree.arrange
  end

  def new
  end

  def edit
  end

  def create
    @page.assign_attributes(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @page.destroy
    redirect_url = @page.is_root? ? pages_url : page_url(@page.parent)
    respond_to do |format|
      format.html { redirect_to redirect_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_page
      @page = Page.find_by_path(params[:path])
    end

    def set_new_page
      @page = Page.new_by_path(params[:path])
    end

    def page_params
      text = params.dig(:page, :text)
      if text.present?
        params[:page][:text] = helpers.markdown_to_html(text, request.base_url)
      end
      params.require(:page).permit(:name, :title, :text)
    end
end
